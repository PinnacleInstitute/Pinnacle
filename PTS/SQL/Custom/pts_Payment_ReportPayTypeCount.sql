EXEC [dbo].pts_CheckProc 'pts_Payment_ReportPayTypeCount'
GO

CREATE PROCEDURE [dbo].pts_Payment_ReportPayTypeCount
   @Status int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime
AS

SET NOCOUNT ON

SELECT 	PayType AS 'PaymentID', 
	PayType, 
	COUNT(*) AS 'Count' 
FROM 	Payment 
WHERE   (@Status = 0 OR Status = @Status)
AND	dbo.wtfn_DateOnly(PayDate) >= @ReportFromDate
AND     dbo.wtfn_DateOnly(PayDate) <= @ReportToDate
AND     OwnerType <> 52
GROUP BY PayType
ORDER BY PayType

GO