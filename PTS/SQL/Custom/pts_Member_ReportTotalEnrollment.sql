EXEC [dbo].pts_CheckProc 'pts_Member_ReportTotalEnrollment'
GO

CREATE PROCEDURE [dbo].pts_Member_ReportTotalEnrollment
   @CompanyID int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime ,
   @Unit varchar(10)
AS

SET NOCOUNT ON

SELECT MIN(ome.MemberID) AS 'MemberID',
	dbo.wtfn_DateOnly(ome.EnrollDate) AS 'EnrollDate',
	MIN(ome.Quantity) 'Quantity'
FROM (
	SELECT  MIN(MemberID) AS 'MemberID',
		EnrollDate = CASE @Unit
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
		END,
		Quantity = (
			SELECT COUNT(*) 
		    	FROM (
				SELECT CompanyID,
					EnrollDate = CASE @Unit
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
						END
				FROM Member
			) AS ime
		    	WHERE dbo.wtfn_DateOnly(ime.EnrollDate) <= dbo.wtfn_DateOnly(me.EnrollDate) 
			AND (@CompanyID = 0 OR ime.CompanyID = @CompanyID)
		)
	FROM Member AS me
	WHERE dbo.wtfn_DateOnly(me.EnrollDate) <= @ReportToDate
	AND (@CompanyID = 0 OR me.CompanyID = @CompanyID)
	AND Status != 0
	GROUP BY me.EnrollDate	
) AS ome
WHERE ome.EnrollDate >= @ReportFromDate
GROUP BY ome.EnrollDate
ORDER BY ome.EnrollDate

GO