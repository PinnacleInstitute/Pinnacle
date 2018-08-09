EXEC [dbo].pts_CheckProc 'pts_Lesson_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Lesson_Fetch ( 
   @LessonID int,
   @CourseID int OUTPUT,
   @CourseName nvarchar (60) OUTPUT,
   @LessonName nvarchar (80) OUTPUT,
   @Description nvarchar (1000) OUTPUT,
   @Status int OUTPUT,
   @LessonLength int OUTPUT,
   @Seq int OUTPUT,
   @MediaURL varchar (250) OUTPUT,
   @MediaType int OUTPUT,
   @MediaLength int OUTPUT,
   @MediaWidth int OUTPUT,
   @MediaHeight int OUTPUT,
   @Content int OUTPUT,
   @Quiz int OUTPUT,
   @QuizLimit int OUTPUT,
   @QuizLength int OUTPUT,
   @PassingGrade int OUTPUT,
   @QuizWeight int OUTPUT,
   @IsPassQuiz bit OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CourseID = le.CourseID ,
   @CourseName = cs.CourseName ,
   @LessonName = le.LessonName ,
   @Description = le.Description ,
   @Status = le.Status ,
   @LessonLength = le.LessonLength ,
   @Seq = le.Seq ,
   @MediaURL = le.MediaURL ,
   @MediaType = le.MediaType ,
   @MediaLength = le.MediaLength ,
   @MediaWidth = le.MediaWidth ,
   @MediaHeight = le.MediaHeight ,
   @Content = le.Content ,
   @Quiz = le.Quiz ,
   @QuizLimit = le.QuizLimit ,
   @QuizLength = le.QuizLength ,
   @PassingGrade = le.PassingGrade ,
   @QuizWeight = le.QuizWeight ,
   @IsPassQuiz = le.IsPassQuiz
FROM Lesson AS le (NOLOCK)
LEFT OUTER JOIN Course AS cs (NOLOCK) ON (le.CourseID = cs.CourseID)
WHERE le.LessonID = @LessonID

GO