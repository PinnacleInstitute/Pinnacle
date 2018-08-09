EXEC [dbo].pts_CheckProc 'pts_Bonus_582_1'
GO
-- Calculate Retail Bonus
CREATE PROCEDURE [dbo].pts_Bonus_582_1
   @CompanyID int,
   @BonusID int,
   @MemberID int,
   @BV money 
AS

SET NOCOUNT ON

DECLARE @Reference varchar (20), @Rate money, @Bonus money, @ID int
DECLARE @RETAIL_BONUS int
SET @RETAIL_BONUS = 1
SET @Reference = ''

-- set the bonus to 20% and round to pennies
SET @Rate = .2
SET @Bonus = ROUND((@BV - 100) * @Rate, 2)
IF @Bonus > 0
BEGIN		
	SET @Reference = CAST(@Rate AS varchar(20))
	EXEC pts_BonusItem_Add @ID, @BonusID, @CompanyID, @MemberID, 0, @RETAIL_BONUS, @Bonus, @Reference, 1
--print '1, ' + cast(@MemberID as varchar(10)) + ', ' + cast(@BV as varchar(10)) + ', ' + cast(@Bonus as varchar(10)) + ', ' + @Reference
END

GO