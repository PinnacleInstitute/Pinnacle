EXEC [dbo].pts_CheckProc 'pts_Genealogy_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Genealogy_Fetch ( 
   @GenealogyID int,
   @CompanyID int OUTPUT,
   @GenealogyName nvarchar (40) OUTPUT,
   @GenealogyNo int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = ge.CompanyID ,
   @GenealogyName = ge.GenealogyName ,
   @GenealogyNo = ge.GenealogyNo
FROM Genealogy AS ge (NOLOCK)
WHERE ge.GenealogyID = @GenealogyID

GO