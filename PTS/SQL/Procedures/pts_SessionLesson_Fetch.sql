EXEC [dbo].pts_CheckProc 'pts_SessionLesson_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_SessionLesson_Fetch ( 
   @SessionLessonID int,
   @SessionID int OUTPUT,
   @LessonID int OUTPUT,
   @LessonName nvarchar (60) OUTPUT,
   @Description nvarchar (1000) OUTPUT,
   @Content bit OUTPUT,
   @Quiz bit OUTPUT,
   @MediaType int OUTPUT,
   @MediaURL nvarchar (80) OUTPUT,
   @LessonLength int OUTPUT,
   @PassingGrade int OUTPUT,
   @QuizWeight int OUTPUT,
   @IsPassQuiz bit OUTPUT,
   @Status int OUTPUT,
   @QuizScore int OUTPUT,
   @CreateDate datetime OUTPUT,
   @CompleteDate datetime OUTPUT,
   @Time int OUTPUT,
   @Times int OUTPUT,
   @Questions nvarchar (200) OUTPUT,
   @Location nvarchar (20) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @SessionID = sl.SessionID ,
   @LessonID = sl.LessonID ,
   @LessonName = le.LessonName ,
   @Description = le.Description ,
   @Content = le.Content ,
   @Quiz = le.Quiz ,
   @MediaType = le.MediaType ,
   @MediaURL = le.MediaURL ,
   @LessonLength = le.LessonLength ,
   @PassingGrade = le.PassingGrade ,
   @QuizWeight = le.QuizWeight ,
   @IsPassQuiz = le.IsPassQuiz ,
   @Status = sl.Status ,
   @QuizScore = sl.QuizScore ,
   @CreateDate = sl.CreateDate ,
   @CompleteDate = sl.CompleteDate ,
   @Time = sl.Time ,
   @Times = sl.Times ,
   @Questions = sl.Questions ,
   @Location = sl.Location
FROM SessionLesson AS sl (NOLOCK)
LEFT OUTER JOIN Lesson AS le (NOLOCK) ON (sl.LessonID = le.LessonID)
WHERE sl.SessionLessonID = @SessionLessonID

GO