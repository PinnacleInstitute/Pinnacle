EXEC [dbo].pts_CheckProc 'pts_Commission_CalcAdvancement_2'
GO

--DECLARE @Count int
--EXEC pts_Commission_CalcAdvancement_2 @Count OUTPUT
--PRINT @Count

CREATE PROCEDURE [dbo].pts_Commission_CalcAdvancement_2
   @OwnerID int ,
   @Count int OUTPUT
AS

SET NOCOUNT ON

DECLARE @Today datetime, @MemberID int, @Title int, @MinTitle int, @TitleDate datetime, @NewTitle int
DECLARE @Advance int, @cnt int, @ID int, @IsEarned bit, @MaxTitle int
SET @Today = GETDATE()
SET @Count = 0
SET @MaxTitle = 9

-- Remove title from all inactive members
UPDATE Member SET Title = 0 WHERE CompanyID = 2 AND Status >= 5

-- ************************************************
-- Calculate the title advancements for each member (except referring affiliates)
-- Process all active members up to 9 Star
-- ************************************************
DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, Title, MinTitle, TitleDate FROM Member
WHERE CompanyID = 2 AND Status < 5 AND Status != 3 AND Title <= @MaxTitle
--and memberid=86186

OPEN Member_Cursor
FETCH NEXT FROM Member_Cursor INTO @MemberID, @Title, @MinTitle, @TitleDate
WHILE @@FETCH_STATUS = 0
BEGIN
--print 'Title: ' + cast(@Title as varchar(10))
	SET @NewTitle = @Title
	SET @Advance = 1
	SET @cnt = 0
--	-- Check for a title promotion
	WHILE @Advance = 1 AND @Title < @MaxTitle
	BEGIN
		SET @NewTitle = @Title + ( @cnt + 1 )
--		-- Check if member meets the next recruiting requirement, if so, check next titles 
		EXEC pts_Commission_CalcAdvancement_2_Test @MemberID, @NewTitle, @Advance OUTPUT
--print 'A: ' + cast(@NewTitle as varchar(10)) + ' ' + cast(@Advance as varchar(10))
--		-- If member advances check for next title promotion, otherwise rollback to last good title
		IF @Advance = 1
			SET @cnt = @cnt + 1
		ELSE
			SET @NewTitle = @NewTitle - 1
	END

--	-- If no promotion, check for a title demotion
	IF @NewTitle = @Title
	BEGIN
--		-- Check if we have a minimum title locked-in for this member
		IF @TitleDate > 0 AND @TitleDate < @Today SET @MinTitle = 0

		SET @Advance = 0
		SET @cnt = 0
--		-- Check for a title demotion, don't drop below the minimum title for this member
		WHILE @Advance = 0 AND @NewTitle > @MinTitle
		BEGIN
			SET @NewTitle = @Title - (@cnt + 1)
--			-- Check if member meets the next recruiting requirement, if so, check next titles 
			EXEC pts_Commission_CalcAdvancement_2_Test @MemberID, @NewTitle, @Advance OUTPUT
--print 'P: ' + cast(@NewTitle as varchar(10)) + ' ' + cast(@Advance as varchar(10))
--			-- If member fails title promotion test next level down, otherwise rollforward to last good title
			IF @Advance = 0 SET @cnt = @cnt + 1
		END
	END

--	If we have a new title or a higher minimum title, store and log the change
	IF @NewTitle != @Title OR @MinTitle > @NewTitle
	BEGIN
		IF @MinTitle > @NewTitle
		BEGIN
			SET @IsEarned = 0
			SET @NewTitle = @MinTitle
		END
		ELSE
			SET @IsEarned = 1

		UPDATE Member SET Title = @NewTitle WHERE MemberID = @MemberID
--		-- MemberTitleID,MemberID,TitleDate,Title,IsEarned,UserID
		EXEC pts_MemberTitle_Add @ID, @MemberID, @Today, @NewTitle, @IsEarned, 1
		SET @Count = @Count + 1
--print 'Update Title: ' + cast(@NewTitle as varchar(10))
	END

	FETCH NEXT FROM Member_Cursor INTO @MemberID, @Title, @MinTitle, @TitleDate
END
CLOSE Member_Cursor
DEALLOCATE Member_Cursor

GO
