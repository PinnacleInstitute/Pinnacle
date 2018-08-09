EXEC [dbo].pts_CheckProc 'pts_FriendGroup_Delete'
 GO

CREATE PROCEDURE [dbo].pts_FriendGroup_Delete ( 
   @FriendGroupID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE frg
FROM FriendGroup AS frg
WHERE frg.FriendGroupID = @FriendGroupID

GO