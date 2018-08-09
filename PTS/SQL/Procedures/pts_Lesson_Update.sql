EXEC [dbo].pts_CheckProc 'pts_Lesson_Update'
 GO

CREATE PROCEDURE [dbo].pts_Lesson_Update ( 
   @LessonID int,
   @CourseID int,
   @LessonName nvarchar (80),
   @Description nvarchar (1000),
   @Status int,
   @LessonLength int,
   @Seq int,
   @MediaURL varchar (250),
   @MediaType int,
   @MediaLength int,
   @MediaWidth int,
   @MediaHeight int,
   @Content int,
   @Quiz int,
   @QuizLimit int,
   @QuizLength int,
   @PassingGrade int,
   @QuizWeight int,
   @IsPassQuiz bit,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE le
SET le.CourseID = @CourseID ,
   le.LessonName = @LessonName ,
   le.Description = @Description ,
   le.Status = @Status ,
   le.LessonLength = @LessonLength ,
   le.Seq = @Seq ,
   le.MediaURL = @MediaURL ,
   le.MediaType = @MediaType ,
   le.MediaLength = @MediaLength ,
   le.MediaWidth = @MediaWidth ,
   le.MediaHeight = @MediaHeight ,
   le.Content = @Content ,
   le.Quiz = @Quiz ,
   le.QuizLimit = @QuizLimit ,
   le.QuizLength = @QuizLength ,
   le.PassingGrade = @PassingGrade ,
   le.QuizWeight = @QuizWeight ,
   le.IsPassQuiz = @IsPassQuiz
FROM Lesson AS le
WHERE le.LessonID = @LessonID

GO