EXEC [dbo].pts_CheckProc 'pts_Genealogy_List'
GO

CREATE PROCEDURE [dbo].pts_Genealogy_List
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      ge.GenealogyID, 
         ge.GenealogyName, 
         ge.GenealogyNo
FROM Genealogy AS ge (NOLOCK)
WHERE (ge.CompanyID = @CompanyID)

ORDER BY   ge.GenealogyNo

GO