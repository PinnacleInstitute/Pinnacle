EXEC [dbo].pts_CheckProc 'pts_Bonus_582_6'
GO
-- Calculate Advancement Bonus
CREATE PROCEDURE [dbo].pts_Bonus_582_6
   @CompanyID int
AS

SET NOCOUNT ON

DECLARE @BonusMemberID int, @Reference varchar (20), @Rate money, @Bonus money, @ID int, @Title int
DECLARE @MemberID int, @EnrollerID int, @BV money, @Qualify int
DECLARE @ADVANCEMENT_BONUS int
SET @ADVANCEMENT_BONUS = 6
SET @Reference = ''

--SET @Reference = CAST(@Title AS varchar(20)) + ' - ' + CAST(@Rate AS varchar(20))
--EXEC pts_BonusItem_Add @ID, 0, @CompanyID, @MemberID, 0, @ADVANCEMENT_BONUS, @Bonus, @Reference, 1
--print '6, ' + cast(@MemberID as varchar(10)) + ', ' + cast(@BV as varchar(10)) + ', ' + cast(@Bonus as varchar(10)) + ', ' + @Reference


GO