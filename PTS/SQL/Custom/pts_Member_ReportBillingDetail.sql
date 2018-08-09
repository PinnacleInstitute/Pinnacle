EXEC [dbo].pts_CheckProc 'pts_Member_ReportBillingDetail'
GO

CREATE PROCEDURE [dbo].pts_Member_ReportBillingDetail
   @CompanyID int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime ,
   @Billing int
AS

SET NOCOUNT ON

SELECT 	TOP 1000 MemberID , 
	NameLast + ', ' + NameFirst AS 'MemberName',
	CompanyName
FROM 	Member 
WHERE	Billing = @Billing
	AND EnrollDate >= @ReportFromDate
	AND dbo.wtfn_DateOnly(EnrollDate) <= @ReportToDate
	AND (@CompanyID = 0 OR CompanyID = @CompanyID)
	AND ( Status < 4 )

GO