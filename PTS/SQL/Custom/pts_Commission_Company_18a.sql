EXEC [dbo].pts_CheckProc 'pts_Commission_Company_18a'
GO
--update payment set commstatus = 1, commdate = 0 where commstatus = 2
--DECLARE @Count int EXEC pts_Commission_Company_18a 24601, @Count OUTPUT PRINT @Count
--update Payment set CommStatus = 1, commdate = 0 where paymentid = 2409

CREATE PROCEDURE [dbo].pts_Commission_Company_18a
   @PaymentID int ,
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @ID int, @Now datetime, @ReferralID int, @SponsorID int, @PinnacleID int
DECLARE @Title int, @Bonus money, @Desc varchar(100), @CommType int, @Qualify int, @Level int 
DECLARE @Amount money, @Code varchar(100), @MemberID int, @Ref varchar(100), @cnt int

SET @CompanyID = 18
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
-- Enrollment Packages
IF CHARINDEX(@Code,'102') > 0 SET @Bonus = 2
-- Monthly Packages
IF CHARINDEX(@Code,'201') > 0 SET @Bonus = 1
IF @Bonus > 0
BEGIN
	SET @CommType = 10
	SET @Desc = @Ref
--	CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
	SET @PinnacleID = 12466 
	EXEC pts_Commission_Add @ID, @CompanyID, 4, @PinnacleID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
	SET @Count = @Count + 1
END

-- ************************************************************
-- Calculate Sales Bonuses for new enrollment/upgrade packages
-- ************************************************************
IF CHARINDEX(@Code,'102,201') > 0
BEGIN
	SET @Bonus = 0
	SELECT @Qualify = Qualify, @Title = Title FROM Member WHERE MemberID = @ReferralID
	IF @Qualify > 1
	BEGIN
		IF @Code = '102'
		BEGIN
			IF @Title <= 3 SET @Bonus = 70  -- Sales Manager
			IF @Title > 3 SET @Bonus = 80  -- Sales Director
		END
		IF @Code = '201'
		BEGIN
			IF @Title <= 3 SET @Bonus = 7  -- Sales Manager
			IF @Title > 3 SET @Bonus = 8  -- Sales Director
		END
	END
	IF @Bonus > 0
	BEGIN
	SET @CommType = 1
		SET @Desc = @Ref
--		CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
		SET @Count = @Count + 1
	END
END

-- ***********************************************************************
-- Calculate Unilevel Team Bonuses on Affiliate enrollment and monthly fees
-- ***********************************************************************
IF CHARINDEX(@Code,'102,201') > 0
BEGIN
--	-- Start with the member's sponsor (matrix upline)
	SET @MemberID = @SponsorID
	IF @Code = '102' SET @Amount = 200
	IF @Code = '201' SET @Amount = 20

--	-- Set Bonus
	SET @Level = 1
	WHILE @Level <= 6 AND @MemberID > 0
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
--				-- Account Manager = Title 2 qualified for 1 level
				IF @Title-1 < @Level SET @Qualify = 0
				
				IF @Qualify > 1 
				BEGIN
					SET @CommType = 5
					IF @Level = 1 SET @Bonus = @Amount * .05
					IF @Level = 2 SET @Bonus = @Amount * .05
					IF @Level = 3 SET @Bonus = @Amount * .03
					IF @Level = 4 SET @Bonus = @Amount * .02
					IF @Level = 5 SET @Bonus = @Amount * .01
					IF @Level = 6 SET @Bonus = @Amount * .01

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
END

-- Update Payment Commission Status and date
UPDATE Payment SET CommStatus = 2, CommDate = @Now WHERE PaymentID = @PaymentID

GO
