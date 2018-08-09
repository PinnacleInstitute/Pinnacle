EXEC [dbo].pts_CheckProc 'pts_ForumModerator_Add'
 GO

CREATE PROCEDURE [dbo].pts_ForumModerator_Add ( 
   @ForumModeratorID int OUTPUT,
   @ForumID int,
   @BoardUserID int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO ForumModerator (
            ForumID , 
            BoardUserID
            )
VALUES (
            @ForumID ,
            @BoardUserID            )

SET @mNewID = @@IDENTITY

SET @ForumModeratorID = @mNewID

GO