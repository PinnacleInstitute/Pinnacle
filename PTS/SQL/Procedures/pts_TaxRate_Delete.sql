EXEC [dbo].pts_CheckProc 'pts_TaxRate_Delete'
 GO

CREATE PROCEDURE [dbo].pts_TaxRate_Delete ( 
   @TaxRateID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE tx
FROM TaxRate AS tx
WHERE tx.TaxRateID = @TaxRateID

GO