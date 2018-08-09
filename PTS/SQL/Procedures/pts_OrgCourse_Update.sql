EXEC [dbo].pts_CheckProc 'pts_OrgCourse_Update'
 GO

CREATE PROCEDURE [dbo].pts_OrgCourse_Update ( 
   @OrgCourseID int,
   @OrgID int,
   @CourseID int,
   @Status int,
   @QuizLimit int,
   @Seq int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE oco
SET oco.OrgID = @OrgID ,
   oco.CourseID = @CourseID ,
   oco.Status = @Status ,
   oco.QuizLimit = @QuizLimit ,
   oco.Seq = @Seq
FROM OrgCourse AS oco
WHERE oco.OrgCourseID = @OrgCourseID

GO