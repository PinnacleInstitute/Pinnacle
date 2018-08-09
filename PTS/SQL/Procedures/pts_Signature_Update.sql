EXEC [dbo].pts_CheckProc 'pts_Signature_Update'
 GO

CREATE PROCEDURE [dbo].pts_Signature_Update ( 
   @SignatureID int,
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

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE sr
SET sr.MemberID = @MemberID ,
   sr.UseType = @UseType ,
   sr.UseID = @UseID ,
   sr.IsActive = @IsActive ,
   sr.Data = @Data ,
   sr.Language = @Language
FROM Signature AS sr
WHERE sr.SignatureID = @SignatureID

GO