EXEC [dbo].pts_CheckProc 'pts_FriendGroup_EnumUserMember'
GO

CREATE PROCEDURE [dbo].pts_FriendGroup_EnumUserMember
   @MemberID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      frg.FriendGroupID AS 'ID', 
         frg.FriendGroupName AS 'Name'
FROM FriendGroup AS frg (NOLOCK)
WHERE (frg.MemberID = @MemberID)

ORDER BY   frg.Seq

GO