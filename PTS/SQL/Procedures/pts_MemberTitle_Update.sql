EXEC [dbo].pts_CheckProc 'pts_MemberTitle_Update'
 GO

CREATE PROCEDURE [dbo].pts_MemberTitle_Update ( 
   @MemberTitleID int,
   @MemberID int,
   @TitleDate datetime,
   @Title int,
   @IsEarned bit,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE mt
SET mt.MemberID = @MemberID ,
   mt.TitleDate = @TitleDate ,
   mt.Title = @Title ,
   mt.IsEarned = @IsEarned
FROM MemberTitle AS mt
WHERE mt.MemberTitleID = @MemberTitleID

GO