EXEC [dbo].pts_CheckProc 'pts_Statement_ListStatement'
GO

CREATE PROCEDURE [dbo].pts_Statement_ListStatement
   @CompanyID int ,
   @Status int ,
   @PayType int
AS

SET NOCOUNT ON

SELECT      stm.StatementID, 
         stm.CompanyID, 
         stm.MerchantID, 
         stm.StatementDate, 
         stm.PaidDate, 
         stm.Amount, 
         stm.Status, 
         stm.PayType, 
         stm.Reference, 
         stm.Notes
FROM Statement AS stm (NOLOCK)
WHERE (stm.CompanyID = @CompanyID)
 AND (stm.Status = @Status)
 AND (stm.PayType = @PayType)
 AND (stm.Notes <> '')

ORDER BY   stm.StatementDate DESC

GO