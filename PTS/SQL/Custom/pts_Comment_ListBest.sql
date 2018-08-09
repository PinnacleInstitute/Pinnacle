EXEC [dbo].pts_CheckProc 'pts_Comment_ListBest'
GO

CREATE PROCEDURE [dbo].pts_Comment_ListBest
   @OwnerType int ,
   @OwnerID int
AS

SET NOCOUNT ON

SELECT   cmt.CommentID, 
         cmt.MemberID, 
         me.NameFirst + ' ' + me.NameLast 'MemberName', 
         cmt.ReplyID, 
         mer.NameFirst + ' ' + mer.NameLast 'ReplyName', 
         cmt.CommentDate, 
         cmt.Msg, 
         cmt.Status, 
         cmt.Likes, 
         cmt.Dislikes, 
         cmt.Bads, 
         cmt.Favorites
FROM Comment AS cmt (NOLOCK)
LEFT OUTER JOIN Member AS me ON cmt.MemberID = me.MemberID
LEFT OUTER JOIN Comment AS cmr ON cmt.ReplyID = cmr.CommentID
LEFT OUTER JOIN Member AS mer ON cmr.MemberID = mer.MemberID
WHERE (cmt.OwnerType = @OwnerType)
 AND (cmt.OwnerID = @OwnerID)

ORDER BY   cmt.Likes DESC

GO