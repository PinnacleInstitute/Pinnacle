EXEC [dbo].pts_CheckProc 'pts_Course_UpdateOrgCourse'
GO

CREATE PROCEDURE [dbo].pts_Course_UpdateOrgCourse
   @CourseID int,
   @OrgID int,
   @OrgStatus int,
   @UserID int
AS

SET NOCOUNT ON

UPDATE OrgCourse
SET Status = @OrgStatus
WHERE (CourseID = @CourseID)
AND (OrgID = @OrgID)
	
GO