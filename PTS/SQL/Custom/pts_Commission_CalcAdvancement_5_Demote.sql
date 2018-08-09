EXEC [dbo].pts_CheckProc 'pts_Commission_CalcAdvancement_5_Demote'
GO

--DECLARE @Count int EXEC pts_Commission_CalcAdvancement_5_Demote 1208, 2, 0, 0, 0, 0, @Count OUTPUT PRINT @Count
--select title, title2, maxmembers from member where memberid=572

CREATE PROCEDURE [dbo].pts_Commission_CalcAdvancement_5_Demote
	@MemberID int, 
	@PayTitle int, 
	@MinTitle int, 
	@TitleDate datetime, 
	@PermTitle int, 
	@Sales money,
	@Count int OUTPUT
AS

SET NOCOUNT ON

DECLARE @Today datetime, @MaxTitle int, @NewTitle int, @Maintain int
DECLARE @Qualify int, @cnt int, @ID int, @IsEarned bit

SET @Today = GETDATE()
SET @Count = 0

-- Check if we have a minimum title locked-in for this member
IF @TitleDate > 0 AND @TitleDate < @Today SET @MinTitle = 1

-- Check for a title demotion, don't drop below the minimum title for this member
SET @cnt = 0
SET @Qualify = 0
SET @NewTitle = @PayTitle
WHILE @Qualify = 0 AND @NewTitle > @MinTitle
BEGIN
	SET @NewTitle = @PayTitle - @cnt
--	Check if they have already achieved this title, and must only maintain it now
	IF @PermTitle >= @NewTitle SET @Maintain = 1 ELSE SET @Maintain = 0
--	Check if member meets the next recruiting requirement, if so, check next titles 
	EXEC pts_Commission_CalcAdvancement_5_Test @MemberID, @NewTitle, @Maintain, @Sales, 0, @Qualify OUTPUT
--	If member fails title promotion test next level down, otherwise rollforward to last good title
	IF @Qualify = 0 SET @cnt = @cnt + 1
END

-- If we have a new title, store and log the change
IF @NewTitle != @PayTitle
BEGIN
	IF @MinTitle > @NewTitle
	BEGIN
		SET @IsEarned = 0
		SET @NewTitle = @MinTitle
	END
	ELSE
		SET @IsEarned = 1

--	-- Update the affiliate's pay title
	UPDATE Member SET Title2 = @NewTitle WHERE MemberID = @MemberID

--	-- MemberTitleID,MemberID,TitleDate,Title,IsEarned,UserID
	EXEC pts_MemberTitle_Add @ID, @MemberID, @Today, @NewTitle, @IsEarned, 1
--print CAST(@MemberID AS VARCHAR(10)) + ' - ' + CAST(@PayTitle AS VARCHAR(10)) + ' - ' + CAST(@NewTitle AS VARCHAR(10))
	SET @Count = 1
END

GO
