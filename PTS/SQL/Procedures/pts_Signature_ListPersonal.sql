EXEC [dbo].pts_CheckProc 'pts_Signature_ListPersonal'
GO

CREATE PROCEDURE [dbo].pts_Signature_ListPersonal
   @MemberID int ,
   @UseID int ,
   @Language nvarchar (6)
AS

SET NOCOUNT ON

SELECT      sr.SignatureID, 
         sr.UseType, 
         sr.IsActive, 
         sr.UseID, 
         sr.Data, 
         sr.Language
FROM Signature AS sr (NOLOCK)
WHERE (sr.MemberID = @MemberID)
 AND (sr.UseType >= 7)
 AND (sr.UseID = @UseID)
 AND (sr.Language = @Language)

ORDER BY   sr.UseType

GO