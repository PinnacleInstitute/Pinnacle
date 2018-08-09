EXEC [dbo].pts_CheckProc 'pts_Member_ReportMembershipDetail'
GO

CREATE PROCEDURE [dbo].pts_Member_ReportMembershipDetail
   @CompanyID int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime ,
   @Status int
AS

SET NOCOUNT ON

SELECT 	TOP 1000 MemberID , 
	NameLast + ', ' + NameFirst AS 'MemberName',
	CompanyName
FROM 	Member 
WHERE	Status = @Status
	AND EnrollDate >= @ReportFromDate
	AND dbo.wtfn_DateOnly(EnrollDate) <= @ReportToDate
	AND (@CompanyID = 0 OR CompanyID = @CompanyID)

GO