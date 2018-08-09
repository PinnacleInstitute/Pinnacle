EXEC [dbo].pts_CheckProc 'pts_FriendGroup_List'
GO

CREATE PROCEDURE [dbo].pts_FriendGroup_List
   @MemberID int
AS

SET NOCOUNT ON

SELECT      frg.FriendGroupID, 
         frg.FriendGroupName, 
         frg.Seq
FROM FriendGroup AS frg (NOLOCK)
WHERE (frg.MemberID = @MemberID)

ORDER BY   frg.Seq

GO