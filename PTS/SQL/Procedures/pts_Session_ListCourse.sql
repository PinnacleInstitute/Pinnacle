EXEC [dbo].pts_CheckProc 'pts_Session_ListCourse'
GO

CREATE PROCEDURE [dbo].pts_Session_ListCourse
   @CourseID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      se.SessionID, 
         se.MemberID, 
         me.CompanyName AS 'MemberName', 
         LTRIM(RTRIM(se.NameFirst)) +  ' '  + LTRIM(RTRIM(se.NameLast)) AS 'StudentName', 
         se.Status, 
         se.Grade
FROM Session AS se (NOLOCK)
LEFT OUTER JOIN Course AS cs (NOLOCK) ON (se.CourseID = cs.CourseID)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (se.MemberID = me.MemberID)
WHERE (se.CourseID = @CourseID)

ORDER BY   'StudentName'

GO