EXEC [dbo].pts_CheckProc 'pts_Bonus_582_4'
GO
--EXEC pts_Bonus_582_4 582, 28165, 9302, 248

-- Calculate UniLevel Bonus
CREATE PROCEDURE [dbo].pts_Bonus_582_4
   @CompanyID int,
   @BonusID int,
   @SponsorID int,
   @BV money
AS

SET NOCOUNT ON

DECLARE @BonusMemberID int, @Reference varchar (20), @Rate money, @Bonus money, @ID int, @level int, @Title int, @Qualify int
DECLARE @UNILEVEL_BONUS int
SET @UNILEVEL_BONUS = 4
SET @Reference = ''

SET @BonusMemberID = @SponsorID
-- set the bonus to 5% and round to pennies
SET @Rate = .05
SET @Bonus = ROUND(@BV * @Rate, 2)
SET @level = 1

WHILE @level <= 10
BEGIN
--	-- get the upline sponsor
	SELECT @BonusMemberID = ISNULL(MemberID,0), @SponsorID = ISNULL(SponsorID,0), @Qualify = ISNULL(Qualify,0), @Title = Title
	FROM Member Where MemberID = @BonusMemberID
--print 'BonusMemberID: ' + CAST(@BonusMemberID AS VARCHAR(19)) + ', QUALIFY: ' + CAST(@Qualify AS VARCHAR(19))  + ', LEVEL: ' + CAST(@Level AS VARCHAR(19)) 
--	-- If we found an upline sponsor and they are bonus qualified
	IF @BonusMemberID > 0 AND @Qualify > 0 
	BEGIN
--		-- Test if this title gets paid on this level
		IF @Title = 0 SET @Qualify = 0
		IF @Title = 1 AND @Level > 3 SET @Qualify = 0
		IF @Title = 2 AND @Level > 4 SET @Qualify = 0
		IF @Title = 3 AND @Level > 5 SET @Qualify = 0
		IF @Title = 4 AND @Level > 6 SET @Qualify = 0
		IF @Title = 5 AND @Level > 7 SET @Qualify = 0
		IF @Title = 6 AND @Level > 8 SET @Qualify = 0
		IF @Title = 7 AND @Level > 9 SET @Qualify = 0

--		-- Only pay bonus if this member's title has the depth
		IF @Qualify > 0 AND @Bonus > 0
		BEGIN
			SET @Reference = CAST(@level AS varchar(20)) + ' - ' + CAST(@Rate AS varchar(20))
			EXEC pts_BonusItem_Add @ID, @BonusID, @CompanyID, @BonusMemberID, 0, @UNILEVEL_BONUS, @Bonus, @Reference, 1
--print '4 , ' + cast(@BonusMemberID as varchar(10)) + ', ' + cast(@BV as varchar(10)) + ', ' + cast(@Bonus as varchar(10)) + ', ' + @Reference
		END
--		-- Increment level here - this member is bonus qualified (compression)
		SET @level = @level + 1
	END

	IF @SponsorID = 0 SET @level = 11
	IF @SponsorID > 0 SET @BonusMemberID = @SponsorID
END

GO
