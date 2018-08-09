EXEC [dbo].pts_CheckProc 'pts_Bonus_582_7'
GO
-- Calculate Infinity Bonus
CREATE PROCEDURE [dbo].pts_Bonus_582_7
   @CompanyID int,
   @BonusID int,
   @SponsorID int,
   @BV money
AS

SET NOCOUNT ON

DECLARE @BonusMemberID int, @Reference varchar (20), @Rate money, @Bonus money, @ID int, @level int 
DECLARE @Title int, @NextTitle int, @IDS varchar(8000), @IDSTR varchar(10), @Qualify int
 
DECLARE @INFINITY_BONUS int
SET @INFINITY_BONUS = 7
SET @Reference = ''

SET @BonusMemberID = @SponsorID
SET @NextTitle = 3
SET @level = 1
SET @IDS = ','

WHILE @SponsorID != 0
BEGIN
--	-- get the upline sponsor
	SELECT @BonusMemberID = ISNULL(MemberID,0), @SponsorID = ISNULL(SponsorID,0), @Qualify = ISNULL(Qualify,0), @Title = Title 
	FROM Member Where MemberID = @BonusMemberID

--	-- check if we already processed this SponsorID (stuck in a loop)
	SET @IDSTR = CAST(@BonusMemberID AS VARCHAR(10))
	IF CHARINDEX( ',' + @IDSTR + ',', @IDS ) = 0
	BEGIN
--		-- If we found an upline sponsor and their title is >= the next title we are looking for
		IF @BonusMemberID > 0 AND @Title >= @NextTitle
		BEGIN
			SET @Rate = 0
--			-- if we're looking for a 3 Star or higher
			IF @NextTitle = 3
			BEGIN
--				-- and we found a 3 or 4 Star, give them 1%
				IF @Title = 3 OR @Title = 4 SET @Rate = .01
--				-- and we found a 5 or 6 Star, give them 2%
				IF @Title = 5 OR @Title = 6 SET @Rate = .02
--				-- and we found a 7 Star or higher, give them 3%
				IF @Title >= 7 SET @Rate = .03
			END
--			-- if we're looking for a 5 Star or higher
			IF @NextTitle = 5
			BEGIN
--				-- and we found a 5 or 6 Star, give them 1%
				IF @Title = 5 OR @Title = 6 SET @Rate = .01
--				-- and we found a 7 Star or higher, give them 2%
				IF @Title >= 7 SET @Rate = .02
			END
--			-- if we're looking for a 7 Star or higher
			IF @NextTitle = 7
			BEGIN
--				-- and we found a 7 Star or higher, give them 1%
				IF @Title >= 7 SET @Rate = .01
			END

			SET @Bonus = ROUND(@BV * @Rate, 2)

--			-- If we found an upline sponsor and they are bonus qualified
			IF @Qualify > 0 AND @Bonus > 0
			BEGIN
				SET @Reference = CAST(@level AS varchar(20)) + ' - ' + CAST(@Rate AS varchar(20))
				EXEC pts_BonusItem_Add @ID, @BonusID, @CompanyID, @BonusMemberID, 0, @INFINITY_BONUS, @Bonus, @Reference, 1
--print '7, ' + cast(@BonusMemberID as varchar(10)) + ', ' + cast(@BV as varchar(10)) + ', ' + cast(@Bonus as varchar(10)) + ', ' + @Reference
			END
--			-- if we found a 3 or 4 Star, look for a 5 Star or higher next
			IF @Title = 3 OR @Title = 4 SET @NextTitle = 5
--			-- if we found a 5 or 6 Star, look for a 7 Star or higher next
			IF @Title = 5 OR @Title = 6 SET @NextTitle = 7
--			-- if we found a 7 Star or higher, we're done
			IF @Title >= 7 SET @SponsorID = 0
		END
		IF @SponsorID > 0 SET @BonusMemberID = @SponsorID
		SET @level = @level + 1

		IF LEN( @IDS + @IDSTR + ',' ) < 8000
			SET @IDS = @IDS + @IDSTR + ','
		ELSE
			SET @SponsorID = 0
	END
	ELSE
	BEGIN
		SET @SponsorID = 0
	END

END

GO