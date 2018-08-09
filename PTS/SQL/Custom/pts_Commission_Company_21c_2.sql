EXEC [dbo].pts_CheckProc 'pts_Commission_Company_21c_2'
GO
--update payment set commstatus = 1, commdate = 0 where commstatus = 2
--DECLARE @Count int EXEC pts_Commission_Company_21c_2 122370, @Count OUTPUT PRINT @Count
--update Payment set CommStatus = 1, commdate = 0 where paymentid = 2409

CREATE PROCEDURE [dbo].pts_Commission_Company_21c_2
   @PaymentID int ,
   @Now datetime ,
   @ReferralID int ,
   @BonusMemberID int ,
   @Amount money ,
   @Ref varchar(100) ,
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @ID int, @MemberID int 
DECLARE @Title int, @Bonus money, @Desc varchar(100), @CommType int, @Qualify int, @Level int 

SET @CompanyID = 21
SET @Count = 0
SET @Now = GETDATE()

IF @ReferralID = 0 SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @BonusMemberID

-- ******************************
-- Calculate Matching Bonuses
-- ******************************
SET @MemberID = @ReferralID
SET @Level = 1
WHILE @Level <= 9 AND @MemberID > 0
BEGIN
	IF @Level = 1 SET @Bonus = ROUND(@Amount * .10, 2) ELSE SET @Bonus = ROUND(@Amount * .05, 2)

--	-- Get the Referrer's info
	SET @ReferralID = -1
	SELECT @ReferralID = ReferralID, @Qualify = Qualify, @Title = Title2 FROM Member WHERE MemberID = @MemberID
--	--Did we find the member
	IF @ReferralID >= 0
	BEGIN
--		-- IF Member NOT Bonus Qualified, Accumulate Lost Bonus
		IF @Qualify <= 1 UPDATE Member SET Retail = Retail + @Bonus WHERE MemberID = @MemberID

		IF @Qualify > 1 
		BEGIN
--			-- Check if they're qualify for the Level level
			IF @Level = 1 AND @Title < 3 SET @Qualify = 0
			IF @Level = 2 AND @Title < 5 SET @Qualify = 0
			IF @Level = 3 AND @Title < 7 SET @Qualify = 0
			IF @Level = 4 AND @Title < 9 SET @Qualify = 0
			IF @Level = 5 AND @Title < 10 SET @Qualify = 0
			IF @Level = 6 AND @Title < 11 SET @Qualify = 0
			IF @Level = 7 AND @Title < 12 SET @Qualify = 0
			IF @Level = 8 AND @Title < 13 SET @Qualify = 0
			IF @Level = 9 AND @Title < 14 SET @Qualify = 0

			IF @Qualify > 1
			BEGIN
				SET @CommType = 13
				SET @Desc = @Ref + ' (' + CAST( @BonusMemberID AS VARCHAR(10) ) + '-' + CAST(@Level AS VARCHAR(2)) + ')'
--				-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
				SET @Count = @Count + 1
			END	
		END	
		SET @MemberID = @ReferralID
	END
	ELSE SET @MemberID = 0
		
	SET @Level = @Level + 1
END


GO
