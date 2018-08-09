EXEC [dbo].pts_CheckProc 'pts_Genealogy_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Genealogy_Delete ( 
   @GenealogyID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE ge
FROM Genealogy AS ge
WHERE ge.GenealogyID = @GenealogyID

GO