EXEC [dbo].pts_CheckProc 'pts_Attachment_Delete'
GO

CREATE PROCEDURE [dbo].pts_Attachment_Delete
   @AttachmentID int,
   @UserID int
AS

SET NOCOUNT ON

EXEC pts_Shortcut_DeleteItem
   80 ,
   @AttachmentID

DELETE att
FROM Attachment AS att
WHERE (att.AttachmentID = @AttachmentID)


GO