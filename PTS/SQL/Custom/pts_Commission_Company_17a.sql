EXEC [dbo].pts_CheckProc 'pts_Commission_Company_17a'
GO
--update payment set commstatus = 1, commdate = 0 where commstatus = 2
--DECLARE @Count int EXEC pts_Commission_Company_17a 122370, @Count OUTPUT PRINT @Count
--update Payment set CommStatus = 1, commdate = 0 where paymentid = 2409

CREATE PROCEDURE [dbo].pts_Commission_Company_17a
   @PaymentID int ,
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @ID int, @Now datetime, @ReferralID int, @SponsorID int, @PinnacleID int
DECLARE @Title int, @Bonus money, @Desc varchar(100), @CommType int, @Qualify int, @Level int 
DECLARE @Amount money, @Code varchar(100), @MemberID int, @Ref varchar(100), @cnt int

SET @CompanyID = 17
SET @Now = GETDATE()

SELECT @Amount = pa.Amount, @Code = pa.Purpose, @MemberID = me.MemberID, 
	   @Ref = LTRIM(STR(me.MemberID)) + ' ' + me.NameFirst + ' ' + me.NameLast, @ReferralID = me.ReferralID, @SponsorID = me.SponsorID
FROM   Payment AS pa
JOIN   Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID 
WHERE  pa.PaymentID = @PaymentID AND pa.Status = 3 AND pa.CommStatus = 1

-- Update Payment Commission Status and date
UPDATE Payment SET CommStatus = 2, CommDate = @Now WHERE PaymentID = @PaymentID

-- Set the Bonus Volume (BV) 
IF CHARINDEX(@Code,'104,204') > 0 SET @Amount = 70
IF CHARINDEX(@Code,'105,205') > 0 SET @Amount = 300
IF CHARINDEX(@Code,'104,204,105,205') = 0 SET @Amount = 0


--	*************************************************
--	Calculate Pinnacle System Fees
--	*************************************************
SET @Bonus = 0
-- Enrollment Packages
IF CHARINDEX(@Code,'101,102,103,104,105,106,107,108') > 0 SET @Bonus = 3
-- Upgrade Packages
IF CHARINDEX(@Code,'111,112,113,114,115,116') > 0 SET @Bonus = 3
-- Monthly Packages
IF CHARINDEX(@Code,'202,203,204,205,206,207,208') > 0 SET @Bonus = 3
IF @Bonus > 0
BEGIN
	SET @CommType = 10
	SET @Desc = @Ref
--	CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
	SET @PinnacleID = 12046 
	EXEC pts_Commission_Add @ID, @CompanyID, 4, @PinnacleID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
	SET @Count = @Count + 1
END

-- ************************************************************
-- Calculate Sales Bonuses for new enrollment/upgrade packages
-- ************************************************************
IF CHARINDEX(@Code,'101,102,103,104,105,106,107,108,111,112,113,114,115,116') > 0
BEGIN
	SET @Bonus = 0
	SELECT @Qualify = Qualify, @Title = Title FROM Member WHERE MemberID = @ReferralID

	IF @Title < 3 
		SET @Bonus = ROUND(@Amount * .05, 2) -- Default Bonus (Free Member 5%, Not Qualified, < Bronze)
	ELSE 
	BEGIN
		SET @Bonus = ROUND(@Amount * .1, 2) -- Upgrade Packages (Bronze+)
--		November Promotion - make everyone qualified
		SET @Qualify = 2
	END	

	IF @Qualify <= 1 UPDATE Member SET Retail = Retail + @Bonus WHERE MemberID = @ReferralID
	

	IF @Qualify > 1 
	BEGIN
	SET @CommType = 1
		SET @Desc = @Ref
--		CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
		SET @Count = @Count + 1
	END
END

-- ************************************************************
-- Calculate Leadership, Matching and Executive Bonuses for new enrollment/upgrade packages
-- ************************************************************
IF CHARINDEX(@Code,'102,103,104,105,106,107,108,111,112,113,114,115,116') > 0
BEGIN
	SET @cnt = 0
	EXEC pts_Commission_Company_17c @MemberID, @PaymentID, @Amount, @Ref, @cnt OUTPUT
	SET @Count = @Count + @cnt
END

-- ***********************************************************************
-- Calculate Matrix Team Bonuses on Affiliate enrollment and monthly fees
-- ***********************************************************************
IF CHARINDEX(@Code,'202,203,204,205,206,207,208') > 0
BEGIN
--	-- Start with the member's sponsor (matrix upline)
	SET @MemberID = @SponsorID

--	-- Set Bonus
	SET @CommType = 5
	IF @Code = '202' SET @Bonus = 1.5
	IF @Code = '203' SET @Bonus = 3.5
--	IF @Code = '204' SET @Bonus = 7.5
	IF @Code = '204' SET @Bonus = 3.5
	IF @Code = '205' SET @Bonus = 15
	IF @Code = '206' SET @Bonus = 30
	IF @Code = '207' SET @Bonus = 50
	IF @Code = '208' SET @Bonus = 150
	
	SET @Level = 1
	WHILE @Level <= 15 AND @MemberID > 0
	BEGIN
--		-- Get the Referrer's info
		SET @SponsorID = -1
		SELECT @SponsorID = SponsorID, @Qualify = Qualify, @Title = Title FROM Member WHERE MemberID = @MemberID
--		--Did we find the member
		IF @SponsorID >= 0
		BEGIN
--			-- Check for 2+ personal bonus-qualified Affiliates+	
--			SELECT @cnt = COUNT(*) FROM Member WHERE ReferralID = @MemberID AND Qualify > 1 AND Title >= 2 
			SELECT @cnt = COUNT(*) FROM Member WHERE ReferralID = @MemberID AND Status = 1 AND Title >= 2 
			IF @cnt < 2 SET @Qualify = 0 

--			-- Management Override (top, Bob W., Mike S.)
			IF @MemberID IN (12045,12046,26684,12559,26911,29464,29095) SET @Qualify = 2
			
			IF @Qualify <= 1 UPDATE Member SET Retail = Retail + @Bonus WHERE MemberID = @MemberID
			
			IF @Qualify > 1 
			BEGIN
--				-- Check if qualified for level based on title
--				IF @Title <= @Level SET @Qualify = 0
				IF @Title = 1 SET @Qualify = 0
				IF @Title = 2 AND @Level > 2 SET @Qualify = 0
				IF @Title = 3 AND @Level > 4 SET @Qualify = 0
				IF @Title = 4 AND @Level > 6 SET @Qualify = 0
				IF @Title = 5 AND @Level > 8 SET @Qualify = 0
				IF @Title = 6 AND @Level > 10 SET @Qualify = 0
				IF @Title = 7 AND @Level > 12 SET @Qualify = 0

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
END

GO
