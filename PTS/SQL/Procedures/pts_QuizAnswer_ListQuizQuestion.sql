EXEC [dbo].pts_CheckProc 'pts_QuizAnswer_ListQuizQuestion'
GO

CREATE PROCEDURE [dbo].pts_QuizAnswer_ListQuizQuestion
   @SessionLessonID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      qa.QuizAnswerID, 
         qa.QuizQuestionID
FROM QuizAnswer AS qa (NOLOCK)
WHERE (qa.SessionLessonID = @SessionLessonID)


GO