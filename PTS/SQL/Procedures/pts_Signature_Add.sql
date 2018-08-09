EXEC [dbo].pts_CheckProc 'pts_Signature_Add'
 GO

CREATE PROCEDURE [dbo].pts_Signature_Add ( 
   @SignatureID int OUTPUT,
   @MemberID int,
   @UseType int,
   @UseID int,
   @IsActive bit,
   @Data nvarchar (4000),
   @Language varchar (6),
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Signature (
            MemberID , 
            UseType , 
            UseID , 
            IsActive , 
            Data , 
            Language
            )
VALUES (
            @MemberID ,
            @UseType ,
            @UseID ,
            @IsActive ,
            @Data ,
            @Language            )

SET @mNewID = @@IDENTITY

SET @SignatureID = @mNewID

GO