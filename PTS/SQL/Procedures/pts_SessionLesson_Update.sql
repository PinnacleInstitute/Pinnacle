EXEC [dbo].pts_CheckProc 'pts_SessionLesson_Update'
 GO

CREATE PROCEDURE [dbo].pts_SessionLesson_Update ( 
   @SessionLessonID int,
   @SessionID int,
   @LessonID int,
   @Status int,
   @QuizScore int,
   @CreateDate datetime,
   @CompleteDate datetime,
   @Time int,
   @Times int,
   @Questions nvarchar (200),
   @Location nvarchar (20),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE sl
SET sl.SessionID = @SessionID ,
   sl.LessonID = @LessonID ,
   sl.Status = @Status ,
   sl.QuizScore = @QuizScore ,
   sl.CreateDate = @CreateDate ,
   sl.CompleteDate = @CompleteDate ,
   sl.Time = @Time ,
   sl.Times = @Times ,
   sl.Questions = @Questions ,
   sl.Location = @Location
FROM SessionLesson AS sl
WHERE sl.SessionLessonID = @SessionLessonID

GO