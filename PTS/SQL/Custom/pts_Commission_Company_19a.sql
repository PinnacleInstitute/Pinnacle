EXEC [dbo].pts_CheckProc 'pts_Commission_Company_19a'
GO
--update payment set commstatus = 1, commdate = 0 where commstatus = 2
--DECLARE @Count int EXEC pts_Commission_Company_19a 34287, @Count OUTPUT PRINT @Count
--update Payment set CommStatus = 1, commdate = 0 where paymentid = 2409

CREATE PROCEDURE [dbo].pts_Commission_Company_19a
   @PaymentID int ,
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @ID int, @Now datetime, @ReferralID int, @SponsorID int, @PinnacleID int
DECLARE @Title int, @Bonus money, @BV money, @Desc varchar(100), @CommType int, @Qualify int, @Level int, @Team int 
DECLARE @Amount money, @Code varchar(100), @MemberID int, @Ref varchar(100) 

SET @CompanyID = 19
SET @Now = GETDATE()

SELECT @Amount = pa.Amount, @Code = pa.Purpose, @MemberID = me.MemberID, 
	   @Ref = LTRIM(STR(me.MemberID)) + ' ' + me.NameFirst + ' ' + me.NameLast, @ReferralID = me.ReferralID, @SponsorID = me.SponsorID
FROM   Payment AS pa
JOIN   Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID 
WHERE  pa.PaymentID = @PaymentID AND pa.Status = 3 AND pa.CommStatus = 1

--	*************************************************
--	Calculate Pinnacle System Fees
--	*************************************************
SET @Bonus = 0
-- Affiliate Enrollment and Monthly Payments
IF CHARINDEX(@Code,'201,211') > 0 SET @Bonus = 1
IF @Bonus > 0
BEGIN
	SET @CommType = 10
	SET @Desc = @Ref
--	CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
	SET @PinnacleID = 14514 
	EXEC pts_Commission_Add @ID, @CompanyID, 4, @PinnacleID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
	SET @Count = @Count + 1
END

--	*************************************************
--	Calculate Retail Commissions
--	*************************************************
SET @Bonus = 0
IF CHARINDEX(@Code,'101,102,103,104') > 0 SET @Bonus = 13 -- new cell phone service
IF CHARINDEX(@Code,'111,112,113,114') > 0 SET @Bonus = 3  -- montlhy cell phone service
IF CHARINDEX(@Code,'201') > 0 SET @Bonus = 10             -- new affiliate
IF @Bonus > 0
BEGIN
	SET @Qualify = 0 
	SELECT @Qualify = Qualify FROM Member WHERE MemberID = @ReferralID
	IF @Qualify > 1
	BEGIN
		SET @CommType = 1
		SET @Desc = @Ref
--			-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
		SET @Count = @Count + 1
	END
END

-- ***********************************************************************
-- Calculate Matrix Team Bonuses
-- ***********************************************************************
SET @BV = 0
IF CHARINDEX(@Code,'101,102,103,104,111,112,113,114') > 0 SET @BV = 2.5 -- cell phone service
IF CHARINDEX(@Code,'201,211') > 0 SET @BV = 10                          -- new affiliate
IF @BV > 0
BEGIN
--	-- Start with the member's sponsor (matrix upline)
	SET @MemberID = @SponsorID

--	-- Set Bonus
	SET @CommType = 2
	SET @Bonus = ROUND(@Amount * .06, 2) -- 6%
	
	SET @Level = 1
	WHILE @Level <= 14 AND @MemberID > 0
	BEGIN
--		-- Get the Referrer's info
		SET @SponsorID = -1
		SELECT @SponsorID = SponsorID, @Qualify = Qualify, @Title = Title FROM Member WHERE MemberID = @MemberID

--		--Did we find the member
		IF @SponsorID >= 0
		BEGIN
			IF @Qualify > 1 
			BEGIN
--				-- Check if qualified for level based on title
				IF @Title = 1 SET @Qualify = 0                  -- Affiliate
				IF @Title = 2 AND @Level > 4 SET @Qualify = 0   -- Qualified Affiliate
				IF @Title = 3 AND @Level > 8 SET @Qualify = 0   -- Senior Affiliate
				IF @Title = 4 AND @Level > 11 SET @Qualify = 0  -- Affiliate Trainer

				IF @Qualify > 1 
				BEGIN
					SET @Desc = @Ref + ' (' + CAST( @Level AS VARCHAR(2) ) + ')'
--					-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
					EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
					SET @Count = @Count + 1
				END
--				-- move to next level to process (dynamic compression)
				SET @Level = @Level + 1
			END 
--			-- Set the memberID to get the next upline Referral
			SET @MemberID = @SponsorID
		END
		ELSE SET @MemberID = 0
	END
	
--	-- ************************************************************
--	-- Calculate 5 Leadership Bonuses
--	-- ************************************************************
	SET @CommType = 3
	SET @Bonus = ROUND(@Amount * .03, 2) -- 3%

	SET @Team = 6  -- Sales Manager
	WHILE @ReferralID > 0 AND @Team <= 10 -- Executive VP
	BEGIN
		SET @Title = -1
		SELECT @Qualify = Qualify, @Title = Title, @SponsorID = ReferralID FROM Member WHERE MemberID = @ReferralID
	--	Did we find the referrer
		IF @Title >= 0
		BEGIN
	--		-- Sales Manager Executive Bonus	
			IF @Title >= @Team
			BEGIN
				SET @Desc = @Ref + ' (' + CAST( @Team AS VARCHAR(10) ) + ')'
	--				-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
				SET @Count = @Count + 1
				SET @Team = @Team + 1
			END 
	--		-- Marketing Director Executive Bonus	
			IF @Title >= @Team
			BEGIN
				SET @Desc = @Ref + ' (' + CAST( @Team AS VARCHAR(10) ) + ')'
	--				-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
				SET @Count = @Count + 1
				SET @Team = @Team + 1
			END 
	--		-- Vice President Executive Bonus	
			IF @Title >= @Team
			BEGIN
				SET @Desc = @Ref + ' (' + CAST( @Team AS VARCHAR(10) ) + ')'
	--				-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
				SET @Count = @Count + 1
				SET @Team = @Team + 1
			END 
	--		-- Senior VP Executive Bonus	
			IF @Title >= @Team
			BEGIN
				SET @Desc = @Ref + ' (' + CAST( @Team AS VARCHAR(10) ) + ')'
	--				-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
				SET @Count = @Count + 1
				SET @Team = @Team + 1
			END 
	--		-- Executive VP Executive Bonus	
			IF @Title >= @Team
			BEGIN
				SET @Desc = @Ref + ' (' + CAST( @Team AS VARCHAR(10) ) + ')'
	--				-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
				SET @Count = @Count + 1
				SET @Team = @Team + 1
			END 
			SET @ReferralID = @SponsorID
		END
		ELSE SET @ReferralID = 0
	END
END

-- Update Payment Commission Status and date
UPDATE Payment SET CommStatus = 2, CommDate = @Now WHERE PaymentID = @PaymentID

GO
