EXEC [dbo].pts_CheckProc 'pts_Session_ListOrgMemberComplete'
GO

CREATE PROCEDURE [dbo].pts_Session_ListOrgMemberComplete
   @MemberID int ,
   @OrgID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      se.SessionID, 
         se.CourseID, 
         se.OrgCourseID, 
         cs.CourseName AS 'CourseName', 
         cs.CourseLength AS 'CourseLength', 
         cs.PassingGrade AS 'PassingGrade', 
         cs.Video AS 'Video', 
         cs.Audio AS 'Audio', 
         cs.Quiz AS 'Quiz', 
         LTRIM(RTRIM(se.NameFirst)) +  ' '  + LTRIM(RTRIM(se.NameLast)) AS 'StudentName', 
         se.Status, 
         se.RegisterDate, 
         se.StartDate, 
         se.CompleteDate, 
         se.Grade, 
         se.TotalRating, 
         se.Time, 
         se.Times, 
         se.IsInactive
FROM Session AS se (NOLOCK)
LEFT OUTER JOIN Course AS cs (NOLOCK) ON (se.CourseID = cs.CourseID)
LEFT OUTER JOIN OrgCourse AS oc (NOLOCK) ON (se.CourseID = oc.CourseID)
WHERE (se.MemberID = @MemberID)
 AND (se.Status > 4)
 AND (se.IsInactive = 0)
 AND (cs.CourseCategoryID >= 0)
 AND (oc.OrgID = @OrgID)

ORDER BY   se.RegisterDate DESC , cs.CourseName

GO