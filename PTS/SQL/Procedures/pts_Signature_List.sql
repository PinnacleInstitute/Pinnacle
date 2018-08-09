EXEC [dbo].pts_CheckProc 'pts_Signature_List'
GO

CREATE PROCEDURE [dbo].pts_Signature_List
   @MemberID int
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
 AND (sr.UseType < 7)

ORDER BY   sr.UseType , sr.UseID

GO