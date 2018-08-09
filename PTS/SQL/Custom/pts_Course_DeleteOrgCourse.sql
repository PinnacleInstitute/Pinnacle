EXEC [dbo].pts_CheckProc 'pts_Course_DeleteOrgCourse'
GO

CREATE PROCEDURE [dbo].pts_Course_DeleteOrgCourse
   @CourseID int,
   @OrgID int,
   @UserID int
AS

SET NOCOUNT ON

DELETE orgco
FROM OrgCourse AS orgco
WHERE (orgco.CourseID = @CourseID)
AND (orgco.OrgID = @OrgID)
	
GO