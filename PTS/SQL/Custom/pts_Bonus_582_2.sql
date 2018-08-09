EXEC [dbo].pts_CheckProc 'pts_Bonus_582_2'
GO
-- Calculate Builder Bonus
CREATE PROCEDURE [dbo].pts_Bonus_582_2
   @CompanyID int,
   @BonusID int,
   @EnrollerID int,
   @BV money
AS

SET NOCOUNT ON

DECLARE @BonusMemberID int, @SponsorID int, @Reference varchar (20), @Rate money, @Bonus money, @ID int, @level int, @Qualify int
DECLARE @BUILDER_BONUS int
SET @BUILDER_BONUS = 2
SET @Reference = ''

SET @BonusMemberID = @EnrollerID
SET @level = 1

WHILE @level <= 3
BEGIN
--	-- set the bonus to 40%, 10%, 10% and round to pennies
	IF @level = 1 SET @Rate = .4
	IF @level > 1 SET @Rate = .1
	SET @Bonus = ROUND(@BV * @Rate, 2)

--	-- get the upline enroller/sponsor
	SELECT @BonusMemberID = ISNULL(MemberID,0), @SponsorID = ISNULL(SponsorID,0), @Qualify = ISNULL(Qualify,0) 
	FROM Member Where MemberID = @BonusMemberID

--	-- If we found an upline enroller/sponsor and they are bonus qualified
	IF @BonusMemberID > 0 AND @Qualify > 0 AND @Bonus > 0
	BEGIN
		SET @Reference = CAST(@level AS varchar(20)) + ' - ' + CAST(@Rate AS varchar(20))
--   		BonusItemID,BonusID,CompanyID,MemberID,MemberBonusID,CommType,Amount,@Reference,@UserID
		EXEC pts_BonusItem_Add @ID, @BonusID, @CompanyID, @BonusMemberID, 0, @BUILDER_BONUS, @Bonus, @Reference, 1
--print '2, ' + cast(@BonusMemberID as varchar(10)) + ', ' + cast(@BV as varchar(10)) + ', ' + cast(@Bonus as varchar(10)) + ', ' + @Reference
	END
	IF @SponsorID = 0 SET @level = 4
	IF @SponsorID > 0
	BEGIN
		SET @BonusMemberID = @SponsorID
		SET @level = @level + 1
	END
END

GO