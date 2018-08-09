EXEC [dbo].pts_CheckProc 'pts_QuizAnswer_Update'
 GO

CREATE PROCEDURE [dbo].pts_QuizAnswer_Update ( 
   @QuizAnswerID int,
   @SessionLessonID int,
   @QuizQuestionID int,
   @QuizChoiceID int,
   @IsCorrect bit,
   @CreateDate datetime,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE qa
SET qa.SessionLessonID = @SessionLessonID ,
   qa.QuizQuestionID = @QuizQuestionID ,
   qa.QuizChoiceID = @QuizChoiceID ,
   qa.IsCorrect = @IsCorrect ,
   qa.CreateDate = @CreateDate
FROM QuizAnswer AS qa
WHERE qa.QuizAnswerID = @QuizAnswerID

GO