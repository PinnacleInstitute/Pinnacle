EXEC [dbo].pts_CheckProc 'pts_Attachment_ListAttachments'
GO

CREATE PROCEDURE [dbo].pts_Attachment_ListAttachments
   @ParentID int ,
   @ParentType int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      att.AttachmentID, 
         att.AuthUserID, 
         att.AttachName, 
         att.FileName, 
         Left(att.Description,200) 'Description', 
         att.ParentType, 
         att.AttachSize, 
         att.AttachDate, 
         att.Status, 
         att.IsLink, 
         att.Secure
FROM Attachment AS att (NOLOCK)
WHERE (att.ParentID = @ParentID)
 AND (att.ParentType = @ParentType)

ORDER BY   att.AttachName

GO