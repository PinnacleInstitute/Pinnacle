EXEC [dbo].pts_CheckProc 'pts_Attachment_Add'
 GO

CREATE PROCEDURE [dbo].pts_Attachment_Add ( 
   @AttachmentID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Attachment (
            CompanyID , 
            ParentID , 
            AuthUserID , 
            RefID , 
            AttachName , 
            FileName , 
            Description , 
            ParentType , 
            AttachSize , 
            AttachDate , 
            ExpireDate , 
            Status , 
            IsLink , 
            Secure , 
            Score
            )
VALUES (
            @CompanyID ,
            @ParentID ,
            @AuthUserID ,
            @RefID ,
            @AttachName ,
            @FileName ,
            @Description ,
            @ParentType ,
            @AttachSize ,
            @AttachDate ,
            @ExpireDate ,
            @Status ,
            @IsLink ,
            @Secure ,
            @Score            )

SET @mNewID = @@IDENTITY

SET @AttachmentID = @mNewID

GO