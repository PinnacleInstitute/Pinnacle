EXEC [dbo].pts_CheckProc 'pts_QuizQuestion_ListQuizQuestion'
GO

CREATE PROCEDURE [dbo].pts_QuizQuestion_ListQuizQuestion
   @LessonID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      qq.QuizQuestionID, 
         qq.LessonID, 
         qq.QuizChoiceID, 
         qq.Question, 
         qq.Explain, 
         qq.Points, 
         qq.IsRandom, 
         qq.Seq, 
         qq.MediaType, 
         qq.MediaFile
FROM QuizQuestion AS qq (NOLOCK)
WHERE (qq.LessonID = @LessonID)

ORDER BY   qq.Seq

GO