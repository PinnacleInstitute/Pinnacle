EXEC [dbo].pts_CheckProc 'pts_Session_ProgramSummary'
GO

--EXEC pts_Session_ProgramSummary 547, 84

CREATE PROCEDURE [dbo].pts_Session_ProgramSummary
   @OrgID int ,
   @MemberID int
AS

SET NOCOUNT ON

SELECT  cs.CourseID 'SessionID', 
	ISNULL(se.SessionID,0) 'CourseID',
        cs.CourseName, 
        ISNULL(se.Status,0) 'Status',
        ISNULL(se.StartDate,0) 'StartDate',
        ISNULL(se.CompleteDate,0) 'CompleteDate',
        ISNULL(se.Grade,0) 'Grade',
	cs.Credit,
        oc.Status 'OCStatus'
FROM    Course AS cs (NOLOCK)
JOIN	OrgCourse as oc ON cs.CourseID = oc.CourseID AND oc.OrgID = @OrgID
LEFT OUTER JOIN	Session as se ON cs.CourseID = se.CourseID AND se.MemberID = @MemberID
WHERE ISNULL(se.Status,0) <> 3
ORDER BY oc.Seq

GO
