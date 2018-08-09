EXEC [dbo].pts_CheckProc 'pts_Company_ReportTypeMember'
GO

CREATE PROCEDURE [dbo].pts_Company_ReportTypeMember
AS

SET         NOCOUNT ON

SELECT 	co.CompanyType AS 'CompanyID', 
	co.CompanyType AS 'CompanyType', 
	COUNT(me.MemberID) AS 'Quantity' 
FROM Company AS co
JOIN Member AS me ON co.CompanyID = me.CompanyID
GROUP BY co.CompanyType
ORDER BY co.CompanyType

GO