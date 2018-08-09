EXEC [dbo].pts_CheckProc 'pts_Attachment_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Attachment_Fetch ( 
   @AttachmentID int,
   @CompanyID int OUTPUT,
   @ParentID int OUTPUT,
   @AuthUserID int OUTPUT,
   @RefID int OUTPUT,
   @AttachName nvarchar (60) OUTPUT,
   @FileName nvarchar (100) OUTPUT,
   @Description nvarchar (3000) OUTPUT,
   @ParentType int OUTPUT,
   @AttachSize int OUTPUT,
   @AttachDate datetime OUTPUT,
   @ExpireDate datetime OUTPUT,
   @Status int OUTPUT,
   @IsLink bit OUTPUT,
   @Secure int OUTPUT,
   @Score int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = att.CompanyID ,
   @ParentID = att.ParentID ,
   @AuthUserID = att.AuthUserID ,
   @RefID = att.RefID ,
   @AttachName = att.AttachName ,
   @FileName = att.FileName ,
   @Description = att.Description ,
   @ParentType = att.ParentType ,
   @AttachSize = att.AttachSize ,
   @AttachDate = att.AttachDate ,
   @ExpireDate = att.ExpireDate ,
   @Status = att.Status ,
   @IsLink = att.IsLink ,
   @Secure = att.Secure ,
   @Score = att.Score
FROM Attachment AS att (NOLOCK)
WHERE att.AttachmentID = @AttachmentID

GO