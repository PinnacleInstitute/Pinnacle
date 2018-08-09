EXEC [dbo].pts_CheckProc 'pts_Company_ReportStats'
GO

CREATE PROCEDURE [dbo].pts_Company_ReportStats
AS

SET NOCOUNT ON

SELECT 	co.CompanyID 'CompanyID',
	co.CompanyName 'CompanyName',
	co.CompanyType 'CompanyType',
	co.Status 'Status',
	co.EnrollDate 'EnrollDate',
	COUNT(me.MemberID) 'Amount',
	SUM(me.Price) 'Quantity'
FROM Company AS co
LEFT JOIN Member AS me ON co.CompanyID = me.CompanyID
WHERE me.Status = 1 OR ( me.Status = 2 AND me.BillingID != 0 )
GROUP BY co.CompanyID, co.CompanyName, co.CompanyType, co.Status, co.EnrollDate
ORDER BY Quantity DESC
GO