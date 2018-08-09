EXEC [dbo].pts_CheckProc 'pts_Issue_ReportStatusAssigned'
GO

CREATE PROCEDURE [dbo].pts_Issue_ReportStatusAssigned
   @CompanyID int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime ,
   @AssignedTo nvarchar (15)
AS

SET NOCOUNT ON

SELECT 	Status AS 'IssueID', 
	Status, 
	COUNT(*) AS 'Quantity' 
FROM  Issue 
WHERE CompanyID = @CompanyID
AND   ChangeDate >= @ReportFromDate
AND   ChangeDate <= @ReportToDate
AND   AssignedTo = @AssignedTo	
GROUP BY Status
ORDER BY Status
GO