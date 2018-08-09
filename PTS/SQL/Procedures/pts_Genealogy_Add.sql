EXEC [dbo].pts_CheckProc 'pts_Genealogy_Add'
 GO

CREATE PROCEDURE [dbo].pts_Genealogy_Add ( 
   @GenealogyID int OUTPUT,
   @CompanyID int,
   @GenealogyName nvarchar (40),
   @GenealogyNo int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Genealogy (
            CompanyID , 
            GenealogyName , 
            GenealogyNo
            )
VALUES (
            @CompanyID ,
            @GenealogyName ,
            @GenealogyNo            )

SET @mNewID = @@IDENTITY

SET @GenealogyID = @mNewID

GO