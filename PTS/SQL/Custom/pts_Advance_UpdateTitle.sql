EXEC [dbo].pts_CheckProc 'pts_Advance_UpdateTitle'
GO

-- ***************************************************************************
-- Update the member's title and title history, if their title has changed
-- ***************************************************************************
CREATE PROCEDURE [dbo].pts_Advance_UpdateTitle
   @MemberID int,
   @Count int OUTPUT
AS

SET NOCOUNT ON

DECLARE @Today datetime, @OldTitle int, @NewTitle int, @MinTitle int, @TitleDate datetime, @IsEarned bit, @ID int
SET @Today = GETDATE()
SET @Count = 0

DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT me.MemberID, me.Title, ad.Title, me.MinTitle, me.TitleDate
FROM Member AS me JOIN Advance AS ad ON me.MemberID = ad.MemberID
WHERE me.CompanyID = 6 AND me.Title <> ad.Title
AND ( @MemberID = 0 OR me.MemberID = @MemberID )

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @OldTitle, @NewTitle, @MinTitle, @TitleDate
WHILE @@FETCH_STATUS = 0
BEGIN
--	Check if we have a minimum title locked-in for this member
	IF @TitleDate > 0 AND @TitleDate < @Today SET @MinTitle = 0
	IF @MinTitle > @NewTitle SET @NewTitle = @MinTitle

	IF @NewTitle != @OldTitle
	BEGIN
		UPDATE Member SET Title = @NewTitle WHERE MemberID = @MemberID
--		-- MemberTitleID,MemberID,TitleDate,Title,IsEarned,UserID
		EXEC pts_MemberTitle_Add @ID, @MemberID, @Today, @NewTitle, 1, 1
		SET @Count = @Count + 1
	END

	FETCH NEXT FROM Member_cursor INTO @MemberID, @OldTitle, @NewTitle, @MinTitle, @TitleDate
END
CLOSE Member_cursor
DEALLOCATE Member_cursor
