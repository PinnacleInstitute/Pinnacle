EXEC [dbo].pts_CheckProc 'pts_Payment_ReportStatusCount'
GO

CREATE PROCEDURE [dbo].pts_Payment_ReportStatusCount
   @ReportFromDate datetime ,
   @ReportToDate datetime
AS

SET NOCOUNT ON

SELECT 	Status AS 'PaymentID', 
	Status, 
	COUNT(*) AS 'Count' 
FROM 	Payment 
WHERE	dbo.wtfn_DateOnly(PayDate) >= @ReportFromDate
AND     dbo.wtfn_DateOnly(PayDate) <= @ReportToDate
AND     OwnerType <> 52
GROUP BY Status
ORDER BY Status

GO