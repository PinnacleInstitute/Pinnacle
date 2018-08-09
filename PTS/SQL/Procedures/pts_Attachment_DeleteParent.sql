EXEC [dbo].pts_CheckProc 'pts_Attachment_DeleteParent'
GO

CREATE PROCEDURE [dbo].pts_Attachment_DeleteParent
   @ParentType int ,
   @ParentID int ,
   @UserID int
AS

SET NOCOUNT ON

DELETE att
FROM Attachment AS att
WHERE (att.ParentType = @ParentType)
 AND (att.ParentID = @ParentID)


GO