EXEC [dbo].pts_CheckProc 'pts_QuizAnswer_Grade'
GO

CREATE PROCEDURE [dbo].pts_QuizAnswer_Grade
   @SessionLessonID int,
   @UserID int,
   @QuizAnswerID int OUTPUT
AS

SET NOCOUNT ON

DECLARE @MaxScore int, @Score int, @Grade money
DECLARE @SessionID int, @LessonID int, @CourseID int, @PassingGrade int

SET @MaxScore = 0
SET @Score = 0
SET @Grade = 0

-- Get the maximum possible score for this Quiz
SELECT @MaxScore = ISNULL(SUM(QQ.Points),0)
FROM QuizAnswer AS QA JOIN QuizQuestion AS QQ ON QA.QuizQuestionID = QQ.QuizQuestionID
WHERE QA.SessionLessonID = @SessionLessonID

-- Get the actual score for these Quiz answers
SELECT @Score = ISNULL(SUM(QQ.Points),0)
FROM QuizAnswer AS QA JOIN QuizQuestion AS QQ ON QA.QuizQuestionID = QQ.QuizQuestionID
WHERE QA.SessionLessonID = @SessionLessonID AND IsCorrect = 1

-- Calculate the score for these Quiz Answers
SET @Grade = 0
IF @MaxScore > 0
	SET @Grade = CAST(((@Score * 100) / @MaxScore) AS money)

-- Get the SessionID and LessonID for this Session Lesson
SELECT @SessionID = SessionID, @LessonID = LessonID FROM SessionLesson WHERE SessionLessonID = @SessionLessonID

-- Get the Passing Grade for this Lesson
SELECT @PassingGrade = PassingGrade FROM Lesson WHERE LessonID = @LessonID

-- Store the Grade and set the status for the SessionLesson
IF @Grade < @PassingGrade
	UPDATE SessionLesson SET QuizScore = @Grade, Status = 3 WHERE SessionLessonID = @SessionLessonID
IF @Grade >= @PassingGrade
	UPDATE SessionLesson SET QuizScore = @Grade, Status = 4 WHERE SessionLessonID = @SessionLessonID

SET @QuizAnswerID = 1

GO

