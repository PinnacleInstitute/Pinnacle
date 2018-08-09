EXEC [dbo].pts_CheckProc 'pts_MemberAssess_CertifyCompany'
GO

--EXEC pts_MemberAssess_CertifyCompany 13, '1/1/2000', '1/1/06', 25

CREATE PROCEDURE [dbo].pts_MemberAssess_CertifyCompany
   @MemberID int ,
   @StartDate datetime ,
   @CompleteDate datetime ,
   @AssessmentID int
AS

SET NOCOUNT ON

DECLARE @CompanyID int
SET @CompanyID = @MemberID

SELECT  
	MIN(tmp.MemberID) AS 'MemberAssessID',
        tmp.CompanyName AS 'AssessmentName', 
        tmp.Role AS 'MemberName', 
	COUNT(*) AS 'Num1',
	SUM(tmp.Taken) AS 'Num2',
	SUM(tmp.Passed) AS 'Num3'
FROM (
	SELECT
        ma.CompanyName AS 'CompanyName', 
        me.Role AS 'Role', 
        me.MemberID AS 'MemberID', 
        ( 
		SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END
		FROM MemberAssess as ma
		WHERE ma.MemberID = me.MemberID
		AND ma.AssessmentID = @AssessmentID
		AND ma.CompleteDate >= @StartDate
		AND ma.CompleteDate <= @CompleteDate
	) AS 'Taken', 
        ( 
		SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END
		FROM MemberAssess as ma
		WHERE ma.MemberID = me.MemberID
		AND ma.AssessmentID = @AssessmentID
		AND ma.CompleteDate >= @StartDate
		AND ma.CompleteDate <= @CompleteDate
		AND ma.Status = 1
	) AS 'Passed' 
	FROM Member as me
	LEFT OUTER JOIN Member AS ma ON me.MasterID = ma.MemberID
	WHERE me.CompanyID = @CompanyID AND me.Status <= 3 
)tmp
GROUP BY tmp.CompanyName, tmp.Role
ORDER BY tmp.CompanyName, tmp.Role

GO
