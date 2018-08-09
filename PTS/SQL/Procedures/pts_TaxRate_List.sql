EXEC [dbo].pts_CheckProc 'pts_TaxRate_List'
GO

CREATE PROCEDURE [dbo].pts_TaxRate_List
   @UserID int
AS

SET NOCOUNT ON

SELECT      tx.TaxRateID, 
         tx.Year, 
         tx.TaxType, 
         tx.Rate
FROM TaxRate AS tx (NOLOCK)
ORDER BY   tx.Year , tx.TaxType

GO