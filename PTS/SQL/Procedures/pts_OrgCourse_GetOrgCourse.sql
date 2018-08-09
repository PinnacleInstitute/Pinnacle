EXEC [dbo].pts_CheckProc 'pts_OrgCourse_GetOrgCourse'
GO

CREATE PROCEDURE [dbo].pts_OrgCourse_GetOrgCourse
   @OrgID int ,
   @CourseID int ,
   @UserID int ,
   @OrgCourseID int OUTPUT
AS

DECLARE @mOrgCourseID int

SET NOCOUNT ON

SELECT      @mOrgCourseID = oco.OrgCourseID
FROM OrgCourse AS oco (NOLOCK)
WHERE (oco.OrgID = @OrgID)
 AND (oco.CourseID = @CourseID)


SET @OrgCourseID = ISNULL(@mOrgCourseID, 0)
GO