EXEC [dbo].pts_CheckProc 'pts_Bonus_582_5'
GO
--EXEC pts_Bonus_582_5 582, '11/1/08'

-- Calculate Matching Bonus
CREATE PROCEDURE [dbo].pts_Bonus_582_5
   @CompanyID int,
   @BonusDate datetime 
AS

SET NOCOUNT ON

DECLARE @BonusMemberID int, @Reference varchar (20), @Rate money, @Bonus money, @ID int, @Title int
DECLARE @MemberID int, @EnrollerID int, @BV money, @Qualify int
DECLARE @MATCHING_BONUS int, @UNILEVEL_BONUS int
SET @MATCHING_BONUS = 5
SET @UNILEVEL_BONUS = 4
SET @Reference = ''

-- get all members that have received unilevel bonuses
DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
SELECT me.ReferralID, SUM(Amount) 
FROM BonusItem AS bi
Join Bonus AS bo ON bi.BonusID = bo.BonusID
Join Member AS me ON bi.MemberID = me.MemberID
WHERE bo.CompanyID = @CompanyID AND bo.BonusDate = @BonusDate
AND bi.CommType = @UNILEVEL_BONUS
AND me.ReferralID > 0
GROUP BY me.ReferralID

OPEN Member_Cursor
FETCH NEXT FROM Member_Cursor INTO @EnrollerID, @BV
WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT @MemberID = MemberID, @Title = Title, @Qualify = Qualify
	FROM Member WHERE MemberID = @EnrollerID

--	-- if we found the enroller and he is bonus qualified and is 3 Star or higher
	IF @MemberID > 0 AND @Qualify > 0 AND @Title >= 3
	BEGIN
		SET @Bonus = 0
		SET @Rate = 0
--		-- if they are a 3 or 4 Star, give them 10%
		IF @Title = 3 OR @Title = 4 SET @Rate = .10
--		-- if they are a 5 or 6 Star, give them 15%
		IF @Title = 5 OR @Title = 6 SET @Rate = .15
--		-- if they are a 7 Star or higher, give them 20%
		IF @Title >= 7 SET @Rate = .20
	
		SET @Bonus = ROUND(@BV * @Rate, 2)

		IF @Bonus > 0
		BEGIN
			SET @Reference = CAST(@Title AS varchar(20)) + ' - ' + CAST(@Rate AS varchar(20))
			EXEC pts_BonusItem_Add @ID, 0, @CompanyID, @MemberID, 0, @MATCHING_BONUS, @Bonus, @Reference, 1
--print '5, ' + cast(@MemberID as varchar(10)) + ', ' + cast(@BV as varchar(10)) + ', ' + cast(@Bonus as varchar(10)) + ', ' + @Reference
		END
	END
	FETCH NEXT FROM Member_Cursor INTO @EnrollerID, @BV
END
CLOSE Member_Cursor
DEALLOCATE Member_Cursor


GO