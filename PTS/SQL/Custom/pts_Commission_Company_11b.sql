EXEC [dbo].pts_CheckProc 'pts_Commission_Company_11b'
GO
--DECLARE @Count int EXEC pts_Commission_Company_11b 25453, @Count OUTPUT PRINT @Count

CREATE PROCEDURE [dbo].pts_Commission_Company_11b
   @PaymentID int ,
   @BonusMemberID int ,
   @Bonus money ,
   @Ref varchar(100) ,
   @BonusDate datetime,
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @ID int, @ReferralID int, @Level int, @MemberID int
DECLARE @Title int, @Desc varchar(100), @CommType int, @Qualify int

SET @CompanyID = 11
SET @Count = 0
SET @Bonus = ROUND(@Bonus * .20, 2)

--Get Referrer of the member who got the bonus to be matched
SET @MemberID = 0
SELECT @MemberID = ReferralID FROM Member WHERE MemberID = @BonusMemberID

-- ***************************
-- Calculate Matching Bonuses
-- ***************************
SET @Level = 1
WHILE @Level <= 5 AND @MemberID > 0
BEGIN
--	Get the Referrer's info
	SET @ReferralID = -1
	SELECT @ReferralID = ReferralID, @Qualify = Qualify, @Title = Title FROM Member WHERE MemberID = @MemberID

--	Did we find the member
	IF @ReferralID >= 0
	BEGIN
--		Are they qualified for the level
		IF @Level = 1 AND @Title < 3 SET @Qualify = 0
		IF @Level = 2 AND @Title < 4 SET @Qualify = 0
		IF @Level = 3 AND @Title < 5 SET @Qualify = 0
		IF @Level = 4 AND @Title < 6 SET @Qualify = 0
		IF @Level = 5 AND @Title < 7 SET @Qualify = 0

--		If this member is qualified to receive bonuses, otherwise skip (no dynamic compression)
		IF @Qualify > 1
		BEGIN
			SET @CommType = 4
			SET @Desc = @Ref + ' (' + CAST( @BonusMemberID AS VARCHAR(10) ) + '-' + CAST( @Level AS VARCHAR(2) ) + ')'
--			CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
			EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @BonusDate, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
			SET @Count = @Count + 1
		END 
	END 
--	Move to next level to process (no dynamic compression)
	SET @Level = @Level + 1
--	Set the memberID to get the next upline Sponsor for the matching bonus
	SET @MemberID = @ReferralID
END

GO
