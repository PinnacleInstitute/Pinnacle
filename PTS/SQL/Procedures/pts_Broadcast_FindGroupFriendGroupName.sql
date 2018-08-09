EXEC [dbo].pts_CheckProc 'pts_Broadcast_FindGroupFriendGroupName'
 GO

CREATE PROCEDURE [dbo].pts_Broadcast_FindGroupFriendGroupName ( 
   @SearchText nvarchar (40),
   @Bookmark nvarchar (50),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
   @FriendGroupID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(frg.FriendGroupName, '') + dbo.wtfn_FormatNumber(bc.BroadcastID, 10) 'BookMark' ,
            bc.BroadcastID 'BroadcastID' ,
            bc.MemberID 'MemberID' ,
            bc.FriendGroupID 'FriendGroupID' ,
            frg.FriendGroupName 'FriendGroupName' ,
            bc.BroadcastDate 'BroadcastDate' ,
            bc.Status 'Status' ,
            bc.Stories 'Stories' ,
            bc.Friends 'Friends'
FROM Broadcast AS bc (NOLOCK)
LEFT OUTER JOIN FriendGroup AS frg (NOLOCK) ON (bc.FriendGroupID = frg.FriendGroupID)
WHERE ISNULL(frg.FriendGroupName, '') LIKE @SearchText + '%'
AND ISNULL(frg.FriendGroupName, '') + dbo.wtfn_FormatNumber(bc.BroadcastID, 10) >= @BookMark
AND         (bc.MemberID = @MemberID)
AND         (bc.FriendGroupID = @FriendGroupID)
ORDER BY 'Bookmark'

GO