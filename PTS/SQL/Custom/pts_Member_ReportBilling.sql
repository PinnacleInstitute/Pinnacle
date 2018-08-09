EXEC [dbo].pts_CheckProc 'pts_Member_ReportBilling'
GO

CREATE PROCEDURE [dbo].pts_Member_ReportBilling
   @CompanyID int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime
AS

SET NOCOUNT ON

SELECT 	Billing AS 'MemberID', 
	Billing, 
	COUNT(*) AS 'Quantity' 
FROM 	Member 
WHERE	EnrollDate >= @ReportFromDate
	AND dbo.wtfn_DateOnly(EnrollDate) <= @ReportToDate
	AND (@CompanyID = 0 OR CompanyID = @CompanyID)
	AND ( Status < 4 )
GROUP BY Billing
ORDER BY Billing

GO