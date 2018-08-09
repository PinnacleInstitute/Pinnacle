EXEC [dbo].pts_CheckProc 'pts_Attachment_ListActiveAttachments'
GO

CREATE PROCEDURE [dbo].pts_Attachment_ListActiveAttachments
   @ParentID int ,
   @ParentType int ,
   @Secure int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      att.AttachmentID, 
         att.AuthUserID, 
         att.AttachName, 
         att.FileName, 
         Left(att.Description,200) 'Description', 
         att.AttachSize, 
         att.AttachDate, 
         att.IsLink, 
         att.Secure
FROM Attachment AS att (NOLOCK)
WHERE (att.ParentID = @ParentID)
 AND (att.ParentType = @ParentType)
 AND (att.Secure <= @Secure)
 AND (att.Status = 1)

ORDER BY   att.AttachName

GO