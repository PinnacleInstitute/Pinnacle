EXEC [dbo].pts_CheckProc 'pts_Attachment_ListCompanyAttachments'
GO

CREATE PROCEDURE [dbo].pts_Attachment_ListCompanyAttachments
   @CompanyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      att.AttachmentID, 
         att.AttachName, 
         att.FileName, 
         att.AttachDate, 
         att.Status
FROM Attachment AS att (NOLOCK)
WHERE (att.CompanyID = @CompanyID)
 AND (att.IsLink <> 0)

ORDER BY   att.AttachName

GO