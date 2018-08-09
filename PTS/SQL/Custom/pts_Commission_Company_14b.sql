EXEC [dbo].pts_CheckProc 'pts_Commission_Company_14b'
GO
--DECLARE @Count int EXEC pts_Commission_Company_14b 7995, 0, '', @Count OUTPUT PRINT @Count
--select * from Commission order by CommissionID desc

CREATE PROCEDURE [dbo].pts_Commission_Company_14b
   @MemberID int ,
   @PaymentID int ,
   @Ref varchar(100),
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @ID int, @Now datetime, @ReferralID int, @Sponsor3ID int, @Level int, @Level2 int, @Title int
DECLARE @Bonus money, @Desc varchar(100), @CommType int, @Qualify int, @cnt int, @BonusID int
DECLARE @QVLeft money, @QVRight money, @Amount money 

IF @Ref = '' SELECT @Ref = LTRIM(STR(MemberID)) + ' ' + NameFirst + ' ' + NameLast FROM Member WHERE MemberID = @MemberID
-- If missing PaymentID get the latest payment
IF @PaymentID = 0
BEGIN
	SELECT TOP 1 @PaymentID = PaymentID FROM Payment AS pa JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
	WHERE so.MemberID = @MemberID ORDER BY pa.PayDate DESC
END

SET @CompanyID = 14
SET @Count = 0
SET @Now = GETDATE()

--*****************************************************
-- Calculate Binary Bonuses - Walk up the entire upline
--*****************************************************
SET @Level = 0
WHILE @MemberID > 0
BEGIN
	SET @Level = @Level + 1
--	-- Get the Sponsor3's info
	SET @Sponsor3ID = -1
	SELECT @Sponsor3ID = Sponsor3ID, @Qualify = Qualify FROM Member WHERE MemberID = @MemberID

--	--Did we find the member
	IF @Sponsor3ID >= 0
	BEGIN
--		-- Get their number of referred Affiliates (must be Silver or higher)
		SELECT @cnt = COUNT(*) FROM Member WHERE ReferralID = @MemberID AND Status >= 1 AND Status <= 4 AND Title >= 3

--		-- Are they qualified for binary bonuses by referring at least 2 binary members
		IF @cnt < 2 SET @Qualify = 0

--		-- Is this member qualified to receive bonuses, otherwise skip
		IF @Qualify > 1
		BEGIN
			SET @Bonus = 0
			SET @QVLeft = 0
			SET @QVRight = 0
--			-- Get the sales volume of both legs (must be Gold or higher)
			SELECT TOP 1 @QVLeft = QV4 FROM Member WHERE Sponsor3ID = @MemberID AND pos = 0 AND Status > 0 -- Status >= 1 AND Status <= 4
			SELECT TOP 1 @QVRight = QV4 FROM Member WHERE Sponsor3ID = @MemberID AND pos = 1 AND Status > 0 -- Status >= 1 AND Status <= 4
--			-- If we have $100+ sales volume in both legs
			IF @QVLeft >= 100 AND @QVRight >= 100
			BEGIN
--				-- Use the lesser leg sales volume
				IF @QVLeft > @QVRight SET @Amount = @QVRight ELSE SET @Amount = @QVLeft
--				-- Pay a $15 bonus for each $100 on the lesser leg sales volume
				SET @Amount = CAST(@Amount / 100 AS INT ) * 100
				SET @Bonus = @Amount * .15
			END
					
			IF @Bonus > 0
			BEGIN
				SET @CommType = 3
				SET @Desc = @Ref + ' (' + CAST( @Level AS VARCHAR(5) ) + ')'
--				-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
				SET @Count = @Count + 1

--				-- Add BinarySale Bonus record (decrease binary sales volume) 
--				-- BinarySaleID, MemberID, RefID, SaleDate, SaleType, Amount, UserID
				IF @Amount > 0 EXEC pts_BinarySale_Add @ID, @MemberID, @PaymentID, @Now, 2, @Amount, 1

--				***************************************************************
--				Calculate Binary Matching Bonuses for up to 4 upline referrers
--				***************************************************************
				-- Save the person that just received this binary bonus
				SET @BonusID = @MemberID
				SELECT @MemberID = ReferralID FROM Member WHERE MemberID = @MemberID
				SET @Bonus = ROUND(@Bonus * .25, 2)
				SET @Level2 = 1
				WHILE @Level2 <= 4 AND @MemberID > 0
				BEGIN
--					-- Get the Referrer's info
					SET @ReferralID = -1
					SELECT @ReferralID = ReferralID, @Title = Title, @Qualify = Qualify FROM Member WHERE MemberID = @MemberID

--					--Did we find the member
					IF @ReferralID >= 0
					BEGIN
--						-- Are they title qualified for the level
 						IF @Level2 = 1 AND @Title < 5 SET @Qualify = 0 -- Diamond+
						IF @Level2 = 2 AND @Title < 7 SET @Qualify = 0 -- 3 Diamond+
						IF @Level2 = 3 AND @Title < 8 SET @Qualify = 0 -- Blue Diamond+
						IF @Level2 = 4 AND @Title < 9 SET @Qualify = 0 -- Presidential+

--						-- If this member is qualified to receive matching bonuses, otherwise skip (no dynamic compression)
						IF @Qualify > 1
						BEGIN
							SET @CommType = 4
							SET @Desc = @Ref + ' (' + CAST( @Level2 AS VARCHAR(2) ) + ') (#' + CAST( @BonusID AS VARCHAR(10) ) + ')'
--									-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
							EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
							SET @Count = @Count + 1
						END
--							-- Set the memberID to get the next upline ReferralID for the matching bonus
						SET @MemberID = @ReferralID
--								-- move to next level to process (no dynamic compression)
						SET @Level2 = @Level2 + 1
					END
					ELSE SET @MemberID = 0
				END
			END
		END 
--		-- Set the memberID to get the next upline Sponsor3ID
		SET @MemberID = @Sponsor3ID
	END
	ELSE SET @MemberID = 0
END

GO
