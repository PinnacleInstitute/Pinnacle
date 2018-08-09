EXEC [dbo].pts_CheckProc 'pts_TaxRate_FetchRate'
GO

CREATE PROCEDURE [dbo].pts_TaxRate_FetchRate
   @Year int ,
   @TaxType int ,
   @TaxRateID int OUTPUT ,
   @Rate money OUTPUT
AS

SET NOCOUNT ON

SELECT      @TaxRateID = tx.TaxRateID, 
         @Rate = tx.Rate
FROM TaxRate AS tx (NOLOCK)
WHERE (tx.Year = @Year)
 AND (tx.TaxType = @TaxType)


GO