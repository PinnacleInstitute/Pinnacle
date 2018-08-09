EXEC [dbo].pts_CheckProc 'pts_Session_ReportMember'
GO

CREATE PROCEDURE [dbo].pts_Session_ReportMember
   @MemberID int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime
AS
SET NOCOUNT ON

DECLARE @CompanyID int

SELECT @CompanyID = CompanyID FROM Member WHERE MemberID = @MemberID

SELECT 	co.CourseID 'SessionID',
	co.CourseID 'CourseID' ,
	co.CourseName 'CourseName' ,
	co.Description 'Feedback' ,
	tr.CompanyName 'MemberName' ,
	ISNULL(se.Status,0) 'Status' ,
	ISNULL(se.RegisterDate,0) 'StartDate' ,
	ISNULL(se.CompleteDate,0) 'CompleteDate' ,
	ISNULL(se.Grade,0) 'Grade' ,
	ISNULL(se.Time,0) 'Time' ,
	ISNULL(se.Times,0) 'Times' ,
	ISNULL(se.OrgCourseID,-1) 'OrgCourseID' 
FROM Course AS co
JOIN Trainer AS tr ON co.TrainerID = tr.TrainerID
LEFT OUTER JOIN Session AS se ON co.CourseID = se.CourseID AND se.MemberID = @MemberID
WHERE (se.RegisterDate IS NULL OR se.RegisterDate >= @ReportFromDate )
AND (se.RegisterDate IS NULL OR se.RegisterDate <= @ReportToDate )
AND (se.IsInactive IS NULL OR se.IsInactive = 0 )
AND co.CourseID IN
(
	SELECT oc.CourseID FROM (
		SELECT Org.OrgID
		FROM Org
		LEFT OUTER JOIN (
			SELECT Org.OrgID, Org.Hierarchy
			FROM OrgMember
			JOIN Org ON (OrgMember.OrgID = Org.OrgID)
			WHERE Org.PrivateID = Org.OrgID
			AND OrgMember.MemberID = @MemberID
		) AS private ON (private.OrgID = Org.PrivateID)
		WHERE Org.CompanyID = @CompanyID
		AND (Org.Status = 2 OR Org.Status = 3)
		AND (Org.PrivateID = 0 OR Org.Hierarchy LIKE private.Hierarchy + '%')
		AND (Org.CourseCount > 0)
	) AS al
	JOIN OrgCourse AS oc ON al.OrgID = oc.OrgID
	UNION ALL
	(
		SELECT CourseID
		FROM Session AS se
		WHERE MemberID = @MemberID
	)
)
ORDER BY OrgCourseID DESC, co.CourseName

GO
