EXEC [dbo].pts_CheckProc 'pts_TaxRate_Update'
 GO

CREATE PROCEDURE [dbo].pts_TaxRate_Update ( 
   @TaxRateID int,
   @Year int,
   @TaxType int,
   @Rate money,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE tx
SET tx.Year = @Year ,
   tx.TaxType = @TaxType ,
   tx.Rate = @Rate
FROM TaxRate AS tx
WHERE tx.TaxRateID = @TaxRateID

GO