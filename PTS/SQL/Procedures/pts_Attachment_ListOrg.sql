EXEC [dbo].pts_CheckProc 'pts_Attachment_ListOrg'
GO

CREATE PROCEDURE [dbo].pts_Attachment_ListOrg
   @ParentID int ,
   @Secure int
AS

SET NOCOUNT ON

SELECT      att.AttachmentID, 
         att.AuthUserID, 
         att.AttachName, 
         att.FileName, 
         Left(att.Description,200) 'Description', 
         att.ParentType, 
         att.ParentID, 
         att.AttachSize, 
         att.AttachDate, 
         att.Status, 
         att.IsLink, 
         att.Secure
FROM Attachment AS att (NOLOCK)
WHERE (att.ParentType = 28)
 AND (att.ParentID = @ParentID)
 AND (att.Secure <= @Secure)
 AND (att.Status <= 1)
 AND ((att.ExpireDate = 0)
 OR (att.ExpireDate > GETDATE()))

ORDER BY   att.AttachName

GO