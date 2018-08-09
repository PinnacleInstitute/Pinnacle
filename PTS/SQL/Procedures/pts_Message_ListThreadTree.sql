EXEC [dbo].pts_CheckProc 'pts_Message_ListThreadTree'
GO

CREATE PROCEDURE [dbo].pts_Message_ListThreadTree
   @ThreadID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      mbm.MessageID, 
         mbm.BoardUserID, 
         mbm.ParentID, 
         mbm.Status, 
         mbu.BoardUserName AS 'BoardUserName', 
         mbm.ModifyID, 
         mod.BoardUserName AS 'ModifyName', 
         mbm.MessageTitle, 
         mbm.Body, 
         mbu.Signature AS 'Signature', 
         mbm.CreateDate, 
         mbm.ChangeDate
FROM Message AS mbm (NOLOCK)
LEFT OUTER JOIN Forum AS mbf (NOLOCK) ON (mbm.ForumID = mbf.ForumID)
LEFT OUTER JOIN BoardUser AS mbu (NOLOCK) ON (mbm.BoardUserID = mbu.BoardUserID)
LEFT OUTER JOIN BoardUser AS mod (NOLOCK) ON (mbm.ModifyID = mod.BoardUserID)
WHERE (mbm.ThreadID = @ThreadID)

ORDER BY   mbm.CreateDate

GO