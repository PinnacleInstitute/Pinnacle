EXEC [dbo].pts_CheckProc 'pts_Member_ReportNewEnrollment'
GO

CREATE PROCEDURE [dbo].pts_Member_ReportNewEnrollment
   @CompanyID int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime ,
   @Unit varchar(10) 
AS

SET NOCOUNT ON

SELECT 	MIN(me.MemberID) AS 'MemberID' ,
	dbo.wtfn_DateOnly(me.EnrollDate) AS 'EnrollDate',
	COUNT(*) AS 'Quantity' 
FROM (
	SELECT
		MemberID,
		CASE @unit
		WHEN 'year' THEN 
			CAST( ('1/1/' + CAST(YEAR(enrolldate) AS VARCHAR(4))) AS datetime)
		WHEN 'quarter' THEN 
			DATEADD(q, 
				DATEPART( q, enrolldate )-1, 
				CAST( ('1/1/' + 
					CAST(YEAR(enrolldate) AS VARCHAR(4))) AS datetime) ) 
		WHEN 'month' THEN 
			CONVERT(datetime, 
				'1/' + 
					CAST(MONTH(enrolldate) AS VARCHAR(2)) + 
					'/' + 
					CAST(YEAR(enrolldate) AS VARCHAR(4)), 
				103) 
		WHEN 'week' THEN 
			DATEADD(ww, 
				DATEPART( ww, enrolldate )-1, 
				CAST( ('1/1/' + 
					CAST(YEAR(enrolldate) AS VARCHAR(4))) AS datetime) ) 
		ELSE 
			dbo.wtfn_DateOnly(EnrollDate)
		END AS 'EnrollDate'
	FROM 	Member
	WHERE 	EnrollDate >= @ReportFromDate
		AND dbo.wtfn_DateOnly(EnrollDate) <= @ReportToDate
		AND (@CompanyID = 0 OR CompanyID = @CompanyID)
		AND Status != 0
	) AS me
GROUP BY me.EnrollDate
ORDER BY me.EnrollDate
GO