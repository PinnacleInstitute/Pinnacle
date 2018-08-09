EXEC [dbo].pts_CheckProc 'pts_Payment_ReportStatusAmount'
GO

CREATE PROCEDURE [dbo].pts_Payment_ReportStatusAmount
   @ReportFromDate datetime ,
   @ReportToDate datetime ,
   @OwnerType int
AS

SET NOCOUNT ON

IF @OwnerType = 1
BEGIN
	SELECT 	Status AS 'PaymentID', 
		Status, 
		SUM(Amount) AS 'Amount' 
	FROM 	Payment 
	WHERE	dbo.wtfn_DateOnly(PayDate) >= @ReportFromDate
	AND     dbo.wtfn_DateOnly(PayDate) <= @ReportToDate
	AND     OwnerType <> 52
	GROUP BY Status
	ORDER BY Status
END
IF @OwnerType = 2
BEGIN
	SELECT 	Status AS 'PaymentID', 
		Status, 
		SUM(Commission) AS 'Amount' 
	FROM 	Payment 
	WHERE	dbo.wtfn_DateOnly(PayDate) >= @ReportFromDate
	AND     dbo.wtfn_DateOnly(PayDate) <= @ReportToDate
	AND     OwnerType <> 52
	GROUP BY Status
	ORDER BY Status
END
IF @OwnerType = 3
BEGIN
	SELECT 	Status AS 'PaymentID', 
		Status, 
		SUM(Retail) AS 'Amount' 
	FROM 	Payment 
	WHERE	dbo.wtfn_DateOnly(PayDate) >= @ReportFromDate
	AND     dbo.wtfn_DateOnly(PayDate) <= @ReportToDate
	AND     OwnerType <> 52
	GROUP BY Status
	ORDER BY Status
END

GO