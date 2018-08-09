EXEC [dbo].pts_CheckProc 'pts_OrgCourse_Delete'
GO

CREATE PROCEDURE [dbo].pts_OrgCourse_Delete
   @OrgCourseID int ,
   @UserID int
AS

SET NOCOUNT ON

EXEC pts_OrgCourse_Update_Counters
   @OrgCourseID ,
   -1 ,
   @UserID

DELETE oco
FROM OrgCourse AS oco
WHERE (oco.OrgCourseID = @OrgCourseID)


GO