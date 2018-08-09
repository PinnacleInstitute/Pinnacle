EXEC [dbo].pts_CheckProc 'pts_Broadcast_FindGroupBroadcastDate'
 GO

CREATE PROCEDURE [dbo].pts_Broadcast_FindGroupBroadcastDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
   @FriendGroupID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20
IF (@Bookmark = '') SET @Bookmark = '99991231'
IF (ISDATE(@SearchText) = 1)
            SET @SearchText = CONVERT(nvarchar(10), CONVERT(datetime, @SearchText), 112)
ELSE
            SET @SearchText = ''


SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), bc.BroadcastDate, 112), '') + dbo.wtfn_FormatNumber(bc.BroadcastID, 10) 'BookMark' ,
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
WHERE ISNULL(CONVERT(nvarchar(10), bc.BroadcastDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), bc.BroadcastDate, 112), '') + dbo.wtfn_FormatNumber(bc.BroadcastID, 10) <= @BookMark
AND         (bc.MemberID = @MemberID)
AND         (bc.FriendGroupID = @FriendGroupID)
ORDER BY 'Bookmark' DESC

GO