EXEC [dbo].pts_CheckProc 'pts_Company_ReportStatus'
GO

CREATE PROCEDURE [dbo].pts_Company_ReportStatus
AS

SET         NOCOUNT ON

SELECT 	Status AS 'CompanyID', 
	Status AS 'Status', 
	COUNT(*) AS 'Quantity' 
FROM 	Company 
GROUP BY Status
ORDER BY Status

GO