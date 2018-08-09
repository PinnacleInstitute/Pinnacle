EXEC [dbo].pts_CheckProc 'pts_Issue_ReportStatus'
GO

CREATE PROCEDURE [dbo].pts_Issue_ReportStatus
   @CompanyID int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime
AS

SET NOCOUNT ON

SELECT 	Status AS 'IssueID', 
	Status, 
	COUNT(*) AS 'Quantity' 
FROM 	Issue 
WHERE CompanyID = @CompanyID
AND   ChangeDate >= @ReportFromDate
AND   ChangeDate <= @ReportToDate
GROUP BY Status
ORDER BY Status
GO