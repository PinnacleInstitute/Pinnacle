EXEC [dbo].pts_CheckProc 'pts_Commission_ListPayout'
GO

CREATE PROCEDURE [dbo].pts_Commission_ListPayout
   @PayoutID int ,
   @CommType int
AS

SET NOCOUNT ON

SELECT      co.CommissionID, 
         co.PayoutID, 
         co.RefID, 
         co.CommDate, 
         co.Status, 
         co.CommType, 
         co.Amount, 
         co.Total, 
         co.Charge, 
         co.Description, 
         co.Notes
FROM Commission AS co (NOLOCK)
LEFT OUTER JOIN CommType AS ct (NOLOCK) ON (co.CompanyID = ct.CompanyID AND co.CommType = ct.CommTypeNo)
WHERE (co.PayoutID = @PayoutID)
 AND (co.CommType = @CommType)


GO