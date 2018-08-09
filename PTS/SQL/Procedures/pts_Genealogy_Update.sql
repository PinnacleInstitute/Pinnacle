EXEC [dbo].pts_CheckProc 'pts_Genealogy_Update'
 GO

CREATE PROCEDURE [dbo].pts_Genealogy_Update ( 
   @GenealogyID int,
   @CompanyID int,
   @GenealogyName nvarchar (40),
   @GenealogyNo int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE ge
SET ge.CompanyID = @CompanyID ,
   ge.GenealogyName = @GenealogyName ,
   ge.GenealogyNo = @GenealogyNo
FROM Genealogy AS ge
WHERE ge.GenealogyID = @GenealogyID

GO