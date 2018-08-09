EXEC [dbo].pts_CheckProc 'pts_TaxRate_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_TaxRate_Fetch ( 
   @TaxRateID int,
   @Year int OUTPUT,
   @TaxType int OUTPUT,
   @Rate money OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @Year = tx.Year ,
   @TaxType = tx.TaxType ,
   @Rate = tx.Rate
FROM TaxRate AS tx (NOLOCK)
WHERE tx.TaxRateID = @TaxRateID

GO