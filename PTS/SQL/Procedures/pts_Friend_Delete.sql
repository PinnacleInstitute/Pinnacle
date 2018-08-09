EXEC [dbo].pts_CheckProc 'pts_Friend_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Friend_Delete ( 
   @FriendID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE fr
FROM Friend AS fr
WHERE fr.FriendID = @FriendID

GO