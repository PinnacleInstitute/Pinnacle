EXEC [dbo].pts_CheckProc 'pts_Session_ReportOrg'
GO

CREATE PROCEDURE [dbo].pts_Session_ReportOrg
   @OrgID int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime
AS

SET NOCOUNT ON

SELECT 	(oc.OrgCourseID*10)+se.Status 'SessionID',
	co.CourseID 'CourseID',
	co.CourseName 'CourseName',
	oc.Status 'OCStatus',
	se.Status 'Status',
	COUNT(se.SessionID) 'Quantity'
FROM OrgCourse AS oc
LEFT JOIN Course AS co ON oc.CourseID = co.CourseID
LEFT JOIN Session AS se ON co.CourseID = se.CourseID
WHERE oc.OrgID = @OrgID
AND se.RegisterDate >= @ReportFromDate
AND se.RegisterDate <= @ReportToDate
GROUP BY oc.OrgCourseID, co.CourseID, co.CourseName, oc.Status, se.Status
ORDER BY co.CourseName, se.Status
GO
