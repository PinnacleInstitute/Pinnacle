EXEC [dbo].pts_CheckProc 'pts_Bonus_CalcBonuses'
GO

--EXEC pts_Bonus_CalcBonuses 582, '11/1/08', '10/1/08', '11/1/08'

CREATE PROCEDURE [dbo].pts_Bonus_CalcBonuses
   @CompanyID int,
   @BonusDate datetime, 
   @FromDate datetime, 
   @ToDate datetime 
AS

SET NOCOUNT ON

-- *********************************************************************************
IF @CompanyID = 582
BEGIN
-- *********************************************************************************

DECLARE @BonusID int, @MemberID int, @BV money, @Months int, @EnrollerID int, @SponsorID int, @Qualify int, @Title int 
DECLARE @BuilderPoints money, @TotalPoints money 
SET @BuilderPoints = 0
SET @TotalPoints = 0

-- --------------------------------------------------------------------------------------------------------
-- Process each Bonus Record for individual bonuses (retail,builder,unilevel,infinity) 
-- --------------------------------------------------------------------------------------------------------
DECLARE Bonus_Cursor CURSOR LOCAL STATIC FOR 
SELECT bo.BonusID, bo.MemberID, bo.BV, DATEDIFF(month, me.EnrollDate, @FromDate) + 1,
	me.ReferralID, me.SponsorID, me.Qualify, me.Title 
FROM Bonus AS bo
JOIN Member AS me ON bo.MemberID = me.MemberID
WHERE bo.CompanyID = @CompanyID AND bo.BonusDate = @BonusDate

OPEN Bonus_Cursor
FETCH NEXT FROM Bonus_Cursor INTO @BonusID, @MemberID, @BV, @Months, @EnrollerID, @SponsorID, @Qualify, @Title

WHILE @@FETCH_STATUS = 0
BEGIN
--	-- Accumulate Total Points
	SET @TotalPoints = @TotalPoints + @BV

--	-- Create Retail Bonus if personal points > 100 and the member is bonus qualified --------------
	IF @BV > 100 AND @Qualify > 0
		EXEC pts_Bonus_582_1 @CompanyID, @BonusID, @MemberID, @BV

--	-- Create Builder Bonuses if member is in their first 3 months ---------------------------------
	IF @Months <= 3
	BEGIN
		SET @BuilderPoints = @BuilderPoints + @BV
		EXEC pts_Bonus_582_2 @CompanyID, @BonusID, @EnrollerID, @BV
	END

--	-- Create UniLevel Bonus if member is past their first 3 months --------------------------------
	IF @Months > 3
		EXEC pts_Bonus_582_4 @CompanyID, @BonusID, @SponsorID, @BV

--	-- Create Infinity Bonuses ---------------------------------------------------------------------
	EXEC pts_Bonus_582_7 @CompanyID, @BonusID, @SponsorID, @BV

	FETCH NEXT FROM Bonus_Cursor INTO @BonusID, @MemberID, @BV, @Months, @EnrollerID, @SponsorID, @Qualify, @Title
END
CLOSE Bonus_Cursor
DEALLOCATE Bonus_Cursor

-- Create Builder Pool Bonuses --------------------------------------------------------------------
EXEC pts_Bonus_582_3 @CompanyID, @FromDate, @ToDate, @BuilderPoints

-- Create Matching Bonuses ------------------------------------------------------------------------
EXEC pts_Bonus_582_5 @CompanyID, @BonusDate

-- Create Advancement Bonuses ---------------------------------------------------------------------
--EXEC pts_Bonus_582_6 @CompanyID

-- Create All-Star Bonuses ------------------------------------------------------------------------
--SET @TotalPoints = @BuilderPoints
EXEC pts_Bonus_582_8 @CompanyID, @TotalPoints

-- --------------------------------------------------------------------------------------------------------
-- Create Missing Bonus Records from created Bonus Items for members without a bonus record
-- A bonus may have been created for a member that did not have an order (qualify=locked)
-- --------------------------------------------------------------------------------------------------------
EXEC pts_Bonus_Missing @CompanyID, @BonusDate

-- --------------------------------------------------------------------------------------------------------
-- Populate BonusItem.MemberBonusID and bonus totals
-- MemberBonusID links the bonus item to the member receiving the bonus
-- BonusID links the bonus item to the member that generated the bonus
-- --------------------------------------------------------------------------------------------------------
EXEC pts_Bonus_Totals @CompanyID, @BonusDate


END

GO