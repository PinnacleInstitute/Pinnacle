EXEC [dbo].pts_CheckProc 'pts_Member_ReportMembership'
GO

CREATE PROCEDURE [dbo].pts_Member_ReportMembership
   @CompanyID int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime
AS

SET NOCOUNT ON

SELECT 	Status AS 'MemberID', 
	Status, 
	COUNT(*) AS 'Quantity' 
FROM 	Member 
WHERE	EnrollDate >= @ReportFromDate
	AND dbo.wtfn_DateOnly(EnrollDate) <= @ReportToDate
	AND (@CompanyID = 0 OR CompanyID = @CompanyID)
GROUP BY Status
ORDER BY Status
GO