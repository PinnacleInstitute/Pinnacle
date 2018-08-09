EXEC [dbo].pts_CheckProc 'pts_Payout_ListCompany'
GO

CREATE PROCEDURE [dbo].pts_Payout_ListCompany
   @CompanyID int ,
   @PayDate datetime ,
   @Amount money
AS

SET NOCOUNT ON

SELECT      po.PayoutID, 
         po.PayDate, 
         po.Amount
FROM Payout AS po (NOLOCK)
WHERE (po.CompanyID = @CompanyID)
 AND (po.PayDate = @PayDate)
 AND (po.Amount >= @Amount)

ORDER BY   po.Amount DESC

GO