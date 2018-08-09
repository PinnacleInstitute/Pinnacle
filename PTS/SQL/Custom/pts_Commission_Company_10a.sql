EXEC [dbo].pts_CheckProc 'pts_Commission_Company_10a'
GO
--update payment set commstatus = 1, commdate = 0 where commstatus = 2
--DECLARE @Count int EXEC pts_Commission_Company_10a 17882, @Count OUTPUT PRINT @Count
--update Payment set CommStatus = 1, commdate = 0 where paymentid = 2409

CREATE PROCEDURE [dbo].pts_Commission_Company_10a
   @PaymentID int ,
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @ID int, @Now datetime, @ReferralID int, @SponsorID int, @Level int, @Level2 int
DECLARE @Title int, @Bonus money, @Desc varchar(100), @CommType int, @Qualify int
DECLARE @tmpMemberID int, @FastStart int, @cnt int, @Price money, @BV money
DECLARE @CommPlan int, @Amount money, @Code varchar(10), @MemberID int, @Ref varchar(100)
DECLARE @EnrollDate datetime, @PinnacleID int
DECLARE @QVLeft money, @QVRight money

SET @CompanyID = 10
SET @Now = GETDATE()

DECLARE SalesItem_cursor CURSOR LOCAL STATIC FOR 
SELECT pr.CommPlan, si.Quantity * pr.BV, pr.Code, me.MemberID, LTRIM(STR(me.MemberID)) + ' ' + me.NameFirst + ' ' + me.NameLast
FROM   SalesItem AS si
JOIN   SalesOrder AS so ON si.SalesOrderID = so.SalesOrderID
JOIN   Product AS pr ON si.ProductID = pr.ProductID
JOIN   Member AS me ON so.MemberID = me.MemberID 
JOIN   Payment AS pa ON pa.OwnerType = 52 AND so.SalesOrderID = pa.OwnerID 
WHERE  pa.PaymentID = @PaymentID AND pa.Status = 3 AND pa.CommStatus = 1
--AND	   pr.BV > 0 
AND so.Status <= 3 AND si.Status <= 3

OPEN SalesItem_cursor
FETCH NEXT FROM SalesItem_cursor INTO @CommPlan, @Amount, @Code, @MemberID, @Ref
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @tmpMemberID = @MemberID
	SET @FastStart = 0

--	*************************************************
--	Calculate Pinnacle System Fees
--	*************************************************
	IF @Code = '101' OR @Code = '102' OR @Code = '103'
	BEGIN
	--	Pay Pinnacle System Fees 		
		SET @PinnacleID = 9068
		SET @CommType = 10
		IF @Code = '101' SET @Bonus = 1  -- Website Fee
		IF @Code = '102' SET @Bonus = 3  -- Diamond Pak
		IF @Code = '103' SET @Bonus = 2  -- Wealth Builder Monthly
		SET @Desc = @Ref
	--	-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @PinnacleID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
		SET @Count = @Count + 1
	END		

	SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID
	SET @Qualify = 0

--	*************************************************
--	Diamond Package Bonuses
--	*************************************************
	IF @Code = '102'
	BEGIN
		SELECT @Price = Price, @Qualify = Qualify, @Title = Title FROM Member WHERE MemberID = @ReferralID

--		Must be Diamond+
		IF @Title < 2 SET @Qualify = 0
		
--		Retail Commission
		IF @Qualify > 1
		BEGIN
			SET @Bonus = 30
			SET @CommType = 1
			SET @Desc = @Ref
--			-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
			EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
			SET @Count = @Count + 1
		END

--		Coded Bonuses
		SET @cnt = 0
		EXEC pts_Commission_Company_10c @MemberID, @PaymentID, @Ref, @cnt OUTPUT
		SET @Count = @Count + @cnt
	END

--	*************************************************
--	Monthly Bonuses
--	*************************************************
	IF @Code = '103'
	BEGIN
--		-- Start with the member's referrer
		SET @MemberID = @ReferralID
		SET @Level = 1
		WHILE @Level <= 5 AND @MemberID > 0
		BEGIN
--			-- Get the Referrer's info
			SET @ReferralID = -1
			SELECT @ReferralID = ReferralID, @Qualify = Qualify FROM Member WHERE MemberID = @MemberID

--			-- Get their number of referred Diamonds
			SELECT @BV = COUNT(*) FROM Member WHERE ReferralID = @MemberID AND Title > 1 AND Status >= 1 AND Status <= 4

--			--Did we find the member
			IF @ReferralID >= 0
			BEGIN
--				-- Are they qualified for the level
				IF @Level = 1 AND @BV < 1 SET @Qualify = 0
				IF @Level = 2 AND @BV < 2 SET @Qualify = 0
				IF @Level = 3 AND @BV < 3 SET @Qualify = 0
				IF @Level = 4 AND @BV < 4 SET @Qualify = 0
				IF @Level = 5 AND @BV < 5 SET @Qualify = 0

--				-- Is this member qualified to receive bonuses, otherwise skip (dynamic compression)
				IF @Qualify > 1
				BEGIN
					SET @Bonus = 3
					SET @CommType = 3
					SET @Desc = @Ref + ' (' + CAST( @Level AS VARCHAR(2) ) + ')'
--					-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
					EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
					SET @Count = @Count + 1

--					-- ***************************
--					-- Calculate Matching Bonuses
--					-- ***************************
					SET @MemberID = @ReferralID
					SET @Level2 = 1
					WHILE @Level2 <= 4 AND @MemberID > 0
					BEGIN
--						-- Get the Referrer's info
						SET @SponsorID = -1
						SELECT @SponsorID = ReferralID, @Qualify = Qualify, @Title = Title FROM Member WHERE MemberID = @MemberID

--						--Did we find the member
						IF @SponsorID >= 0
						BEGIN
--							-- Are they qualified for the level
							IF @Level2 = 1 AND @Title < 3 SET @Qualify = 0
							IF @Level2 = 2 AND @Title < 4 SET @Qualify = 0
							IF @Level2 = 3 AND @Title < 5 SET @Qualify = 0
							IF @Level2 = 4 AND @Title < 6 SET @Qualify = 0

--							-- If this member is qualified to receive bonuses, otherwise skip (no dynamic compression)
							IF @Qualify > 1
							BEGIN
								SET @Bonus = ROUND(@Amount * .25, 2)
								SET @CommType = 4
								SET @Desc = @Ref + ' (' + CAST( @Level2 AS VARCHAR(2) ) + ')'
--								-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
								EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
								SET @Count = @Count + 1
							END 
						END 
--						-- move to next level to process (no dynamic compression)
						SET @Level2 = @Level2 + 1
--						-- Set the memberID to get the next upline Sponsor for the matching bonus
						SET @MemberID = @SponsorID
					END
--					-- ***************************
--					-- move to next level to process (dynamic compression)
					SET @Level = @Level + 1
				END 
--				-- Set the memberID to get the next upline Referral
				SET @MemberID = @ReferralID
			END
			ELSE SET @MemberID = 0
		END
	END

	FETCH NEXT FROM SalesItem_cursor INTO @CommPlan, @Amount, @Code, @MemberID, @Ref
END
CLOSE SalesItem_cursor
DEALLOCATE SalesItem_cursor


-- Update Payment Commission Status and date
UPDATE Payment SET CommStatus = 2, CommDate = @Now WHERE PaymentID = @PaymentID

GO
