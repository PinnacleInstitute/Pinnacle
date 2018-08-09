EXEC [dbo].pts_CheckProc 'pts_Signature_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Signature_Fetch ( 
   @SignatureID int,
   @MemberID int OUTPUT,
   @UseType int OUTPUT,
   @UseID int OUTPUT,
   @IsActive bit OUTPUT,
   @Data nvarchar (4000) OUTPUT,
   @Language varchar (6) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = sr.MemberID ,
   @UseType = sr.UseType ,
   @UseID = sr.UseID ,
   @IsActive = sr.IsActive ,
   @Data = sr.Data ,
   @Language = sr.Language
FROM Signature AS sr (NOLOCK)
WHERE sr.SignatureID = @SignatureID

GO