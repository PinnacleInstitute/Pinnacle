EXEC [dbo].pts_CheckProc 'pts_Commission_Company_21b_2'
GO
--DECLARE @Count int EXEC pts_Commission_Company_21b_2 7995, 0, '', @Count OUTPUT PRINT @Count
--select * from Commission order by CommissionID desc

CREATE PROCEDURE [dbo].pts_Commission_Company_21b_2
   @MemberID int ,
   @PaymentID int ,
   @Ref varchar(100),
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @ID int, @Now datetime, @ReferralID int, @Sponsor3ID int, @Level int, @Title int
DECLARE @Bonus money, @Desc varchar(100), @CommType int, @Qualify int, @cnt int, @BonusID int
DECLARE @QVLeft money, @QVRight money, @Amount money, @Rate money 

IF @Ref = '' SELECT @Ref = LTRIM(STR(MemberID)) + ' ' + NameFirst + ' ' + NameLast FROM Member WHERE MemberID = @MemberID
-- If missing PaymentID get the latest payment
IF @PaymentID = 0 SELECT TOP 1 @PaymentID = PaymentID FROM Payment WHERE OwnerType = 4 AND OwnerID = @MemberID ORDER BY PayDate DESC

SET @CompanyID = 21
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
	SELECT @Sponsor3ID = Sponsor3ID, @Qualify = Qualify, @Title = Title2 FROM Member WHERE MemberID = @MemberID

--	--Did we find the member
	IF @Sponsor3ID >= 0
	BEGIN
--		-- Get their number of referred Affiliates (must be Silver or higher)
		SELECT @cnt = COUNT(*) FROM Member WHERE ReferralID = @MemberID AND Status >= 1 AND Status <= 4 AND Title >= 2

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
--				-- Calculate Cycle Bonus based on Title
				SET @Rate = 0
				IF @Title >= 3 AND @Title <= 6 SET @Rate = .05
				IF @Title >= 7 AND @Title <= 8 SET @Rate = .06
				IF @Title >= 9 AND @Title <= 10 SET @Rate = .07
				IF @Title >= 11 AND @Title <= 11 SET @Rate = .08
				IF @Title >= 12 AND @Title <= 13 SET @Rate = .09
				IF @Title = 14 SET @Rate = .10

--				-- Use the lesser leg sales volume
				IF @QVLeft > @QVRight SET @Amount = @QVRight ELSE SET @Amount = @QVLeft
--				-- Pay a cycle bonus for each $100 on the lesser leg sales volume
				SET @Amount = CAST(@Amount / 100 AS INT ) * 100
				SET @Bonus = @Amount * @Rate
			END
					
			IF @Bonus > 0
			BEGIN
				SET @CommType = 12
				SET @Desc = @Ref + ' (' + CAST( @Level AS VARCHAR(5) ) + ')'
--				-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
				SET @Count = @Count + 1

--				-- Add BinarySale Bonus record (decrease binary sales volume) 
--				-- BinarySaleID, MemberID, RefID, SaleDate, SaleType, Amount, UserID
				IF @Amount > 0 EXEC pts_BinarySale_Add @ID, @MemberID, @PaymentID, @Now, 2, @Amount, 1

--				-- Calculate Matching Bonuses
				EXEC pts_Commission_Company_21c_2 @PaymentID, @Now, @MemberID, 0, @Bonus, @Ref, @cnt OUTPUT
				SET @Count = @Count + @cnt

			END
		END 
--		-- Set the memberID to get the next upline Sponsor3ID
		SET @MemberID = @Sponsor3ID
	END
	ELSE SET @MemberID = 0
END

GO
