EXEC [dbo].pts_CheckProc 'pts_Commission_ListPayoutSummary'
GO

CREATE PROCEDURE [dbo].pts_Commission_ListPayoutSummary
   @PayoutID int
AS

SET NOCOUNT ON

SELECT 	co.CommType, ct.CommTypeName, MIN(co.CommissionID) 'CommissionID', SUM(co.Amount) 'Amount'
FROM 	Commission AS co (NOLOCK)
LEFT OUTER JOIN CommType AS ct (NOLOCK) ON (co.CompanyID = ct.CompanyID AND co.CommType = ct.CommTypeNo)
WHERE 	co.PayoutID = @PayoutID
GROUP BY co.CommType, ct.CommTypeName
ORDER BY co.CommType

GO
