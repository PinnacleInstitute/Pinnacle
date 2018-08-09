EXEC [dbo].pts_CheckProc 'pts_OrgCourse_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_OrgCourse_Fetch ( 
   @OrgCourseID int,
   @OrgID int OUTPUT,
   @CourseID int OUTPUT,
   @Status int OUTPUT,
   @QuizLimit int OUTPUT,
   @Seq int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @OrgID = oco.OrgID ,
   @CourseID = oco.CourseID ,
   @Status = oco.Status ,
   @QuizLimit = oco.QuizLimit ,
   @Seq = oco.Seq
FROM OrgCourse AS oco (NOLOCK)
LEFT OUTER JOIN Course AS co (NOLOCK) ON (oco.CourseID = co.CourseID)
LEFT OUTER JOIN Org AS org (NOLOCK) ON (oco.OrgID = org.OrgID)
WHERE oco.OrgCourseID = @OrgCourseID

GO