EXEC [dbo].pts_CheckProc 'pts_SessionLesson_DeleteQuiz'
GO

CREATE PROCEDURE [dbo].pts_SessionLesson_DeleteQuiz
   @SessionID int ,
   @LessonID int ,
   @UserID int ,
   @SessionLessonID int OUTPUT
AS

DECLARE   @mSessionLessonID int

SET NOCOUNT ON

SELECT  @mSessionLessonID = SessionLessonID FROM SessionLesson
WHERE SessionID = @SessionID AND LessonID = @LessonID

UPDATE SessionLesson SET Status = 2, Questions = '' WHERE SessionLessonID = @mSessionLessonID

DELETE QuizAnswer WHERE SessionLessonID = @mSessionLessonID

SET @SessionLessonID = ISNULL(@mSessionLessonID, 0)

GO
