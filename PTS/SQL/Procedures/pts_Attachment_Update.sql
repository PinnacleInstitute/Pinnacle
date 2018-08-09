EXEC [dbo].pts_CheckProc 'pts_Attachment_Update'
 GO

CREATE PROCEDURE [dbo].pts_Attachment_Update ( 
   @AttachmentID int,
   @CompanyID int,
   @ParentID int,
   @AuthUserID int,
   @RefID int,
   @AttachName nvarchar (60),
   @FileName nvarchar (100),
   @Description nvarchar (3000),
   @ParentType int,
   @AttachSize int,
   @AttachDate datetime,
   @ExpireDate datetime,
   @Status int,
   @IsLink bit,
   @Secure int,
   @Score int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE att
SET att.CompanyID = @CompanyID ,
   att.ParentID = @ParentID ,
   att.AuthUserID = @AuthUserID ,
   att.RefID = @RefID ,
   att.AttachName = @AttachName ,
   att.FileName = @FileName ,
   att.Description = @Description ,
   att.ParentType = @ParentType ,
   att.AttachSize = @AttachSize ,
   att.AttachDate = @AttachDate ,
   att.ExpireDate = @ExpireDate ,
   att.Status = @Status ,
   att.IsLink = @IsLink ,
   att.Secure = @Secure ,
   att.Score = @Score
FROM Attachment AS att
WHERE att.AttachmentID = @AttachmentID

GO