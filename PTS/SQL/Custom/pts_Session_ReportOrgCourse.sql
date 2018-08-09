EXEC [dbo].pts_CheckProc 'pts_Session_ReportOrgCourse'
GO

CREATE PROCEDURE [dbo].pts_Session_ReportOrgCourse
   @OrgID int ,
   @CourseID int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime
AS

SET NOCOUNT ON

SELECT 	se.SessionID,
   LTRIM(RTRIM(se.NameFirst)) +  ' '  + LTRIM(RTRIM(se.NameLast)) AS 'StudentName', 
	se.Status,
	se.StartDate,
	se.CompleteDate,
	se.Grade,
	se.Time,
	se.Times
FROM OrgCourse AS oc
LEFT JOIN Session AS se ON oc.CourseID = se.CourseID
WHERE oc.OrgID = @OrgID
AND oc.CourseID = @CourseID
AND se.RegisterDate >= @ReportFromDate
AND se.RegisterDate <= @ReportToDate
ORDER BY se.Status, 'StudentName'

GO
