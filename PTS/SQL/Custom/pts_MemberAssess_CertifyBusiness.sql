EXEC [dbo].pts_CheckProc 'pts_MemberAssess_CertifyBusiness'
GO

--EXEC pts_MemberAssess_CertifyBusiness 0, '1/1/2000', '1/1/06', 3

CREATE PROCEDURE [dbo].pts_MemberAssess_CertifyBusiness
   @MemberID int ,
   @StartDate datetime ,
   @CompleteDate datetime ,
   @AssessmentID int
AS

SET NOCOUNT ON

DECLARE @MasterID int
SET @MasterID = @MemberID

SELECT  
	MIN(tmp.MemberID) AS 'MemberAssessID',
        tmp.GroupID AS 'AssessmentName', 
        tmp.Role AS 'MemberName', 
	COUNT(*) AS 'Num1',
	SUM(tmp.Taken) AS 'Num2',
	SUM(tmp.Passed) AS 'Num3'
FROM (
	SELECT
        me.GroupID AS 'GroupID', 
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
	WHERE me.MasterID = @MasterID AND me.Status <= 3 
)tmp
GROUP BY tmp.GroupID, tmp.Role
ORDER BY tmp.GroupID, tmp.Role

GO
