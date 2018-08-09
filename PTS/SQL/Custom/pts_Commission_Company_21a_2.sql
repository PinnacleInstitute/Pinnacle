EXEC [dbo].pts_CheckProc 'pts_Commission_Company_21a_2'
GO
--update payment set commstatus = 1, commdate = 0 where commstatus = 2
--DECLARE @Count int EXEC pts_Commission_Company_21a_2 122370, @Count OUTPUT PRINT @Count
--update Payment set CommStatus = 1, commdate = 0 where paymentid = 2409

CREATE PROCEDURE [dbo].pts_Commission_Company_21a_2
   @PaymentID int ,
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @ID int, @Now datetime, @ReferralID int, @Sponsor3ID int, @PinnacleID int, @Team int, @EnrollDate datetime, @FastStartDate datetime
DECLARE @Title int, @Bonus money, @Desc varchar(100), @CommType int, @Qualify int, @Level int 
DECLARE @Amount money, @Code varchar(100), @MemberID int, @tmpMemberID int, @Ref varchar(100), @cnt int
DECLARE @GiftQty int, @GiftPV money, @PaymentTitle int, @Retail money

SET @CompanyID = 21
SET @Now = GETDATE()
SET @GiftQty = 0
SET @GiftPV = 0

SELECT @Amount = pa.Amount, @Code = pa.Purpose, @MemberID = me.MemberID, @PaymentTitle = me.Title,
	   @Ref = LTRIM(STR(me.MemberID)) + ' ' + me.NameFirst + ' ' + me.NameLast, @ReferralID = me.ReferralID, @Sponsor3ID = me.Sponsor3ID,
	   @Retail = pa.Retail
FROM   Payment AS pa
JOIN   Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID 
WHERE  pa.PaymentID = @PaymentID AND pa.Status = 3 AND pa.CommStatus = 1

SET @tmpMemberID = @MemberID
--Process product certificates
IF @Code = '100'
BEGIN
--	Get Qty and PV from Retail Price (1.25 = 1 qty, 25 pv)
	SET @GiftQty = FLOOR(@Retail)
	SET @GiftPV = (@Retail - @GiftQty) * 100
END

-- Update Payment Commission Status and date
UPDATE Payment SET CommStatus = 2, CommDate = @Now WHERE PaymentID = @PaymentID

-- Set the Bonus Volume (BV) 
IF @Code = '100' SET @Amount = @GiftQty * @GiftPV
IF CHARINDEX(@Code,'101,201,202,203') > 0 SET @Amount = 10
IF CHARINDEX(@Code,'102,204') > 0 SET @Amount = 25
IF CHARINDEX(@Code,'103,205') > 0 SET @Amount = 50

--	*************************************************
--	Calculate Pinnacle System Fees
--	*************************************************
SET @Bonus = 0
IF @Code = '100'
BEGIN
	IF @GiftPV = 10 SET @Bonus = 0.40 * @GiftQty
	IF @GiftPV = 25 SET @Bonus = 1.25 * @GiftQty
	IF @GiftPV = 50 SET @Bonus = 2.50 * @GiftQty
END
IF CHARINDEX(@Code,'101,201,202,203') > 0 SET @Bonus = 0.40
IF CHARINDEX(@Code,'102,204') > 0 SET @Bonus = 1.00
IF CHARINDEX(@Code,'103,205') > 0 SET @Bonus = 2.00
IF @Bonus > 0
BEGIN
	SET @CommType = 19
	SET @Desc = @Ref
--	CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
	SET @PinnacleID = 37701 
	EXEC pts_Commission_Add @ID, @CompanyID, 4, @PinnacleID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
	SET @Count = @Count + 1
END

-- ***********************************************************************
-- Calculate Team Bonuses
-- ***********************************************************************
IF CHARINDEX(@Code,'100,101,102,103,201,202,203,204,205') > 0
BEGIN
--	Start with the member's sponsor (team upline)
--	If customer sale, use enroller's sponsor (customer title = 1)
	IF @PaymentTitle = 1
		SELECT @MemberID = ReferralID FROM Member WHERE MemberID = @ReferralID
	ELSE
		SET @MemberID = @ReferralID
	
--	-- Set Bonus Type
	SET @CommType = 11
	
	SET @Level = 1
	WHILE @Level <= 9 AND @MemberID > 0
	BEGIN
		IF @Level = 1 SET @Bonus = @Amount * .10 ELSE SET @Bonus = @Amount * .03

--		-- Get the Referrer's info
		SET @ReferralID = -1
		SELECT @ReferralID = ReferralID, @Qualify = Qualify, @Title = Title2 FROM Member WHERE MemberID = @MemberID
--		--Did we find the member
		IF @ReferralID >= 0
		BEGIN
			IF @Qualify <= 1 UPDATE Member SET Retail = Retail + @Bonus WHERE MemberID = @MemberID

			IF @Qualify > 1 
			BEGIN
--				-- Check if qualified for level based on title
				IF @Level = 1 AND @Title < 3 SET @Qualify = 0
				IF @Level = 2 AND @Title < 4 SET @Qualify = 0
				IF @Level = 3 AND @Title < 5 SET @Qualify = 0
				IF @Level = 4 AND @Title < 6 SET @Qualify = 0
				IF @Level = 5 AND @Title < 8 SET @Qualify = 0
				IF @Level = 6 AND @Title < 10 SET @Qualify = 0
				IF @Level = 7 AND @Title < 12 SET @Qualify = 0
				IF @Level = 8 AND @Title < 13 SET @Qualify = 0
				IF @Level = 9 AND @Title < 14 SET @Qualify = 0

				IF @Qualify > 1 
				BEGIN
					SET @Desc = @Ref + ' (' + CAST( @Level AS VARCHAR(2) ) + ')'
--					-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
					EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
					SET @Count = @Count + 1
					
--					-- Calculate Matching Bonuses
					EXEC pts_Commission_Company_21c_2 @PaymentID, @Now, @MemberID, @ReferralID, @Bonus, @Ref, @cnt OUTPUT
					SET @Count = @Count + @cnt

				END
--				-- move to next level to process (dynamic compression)
				SET @Level = @Level + 1
			END 
--			-- Set the memberID to get the next upline Referral
			SET @MemberID = @ReferralID
		END
		ELSE SET @MemberID = 0
	END
END

GO
