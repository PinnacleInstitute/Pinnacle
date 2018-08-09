EXEC [dbo].pts_CheckProc 'pts_Company_ReportType'
GO

CREATE PROCEDURE [dbo].pts_Company_ReportType
AS

SET         NOCOUNT ON

SELECT 	CompanyType AS 'CompanyID', 
	CompanyType AS 'CompanyType', 
	COUNT(*) AS 'Quantity' 
FROM 	Company 
GROUP BY CompanyType
ORDER BY CompanyType
GO