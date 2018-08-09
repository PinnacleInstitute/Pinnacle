EXEC [dbo].pts_CheckProc 'pts_SurveyAnswer_ListComments'
GO

CREATE PROCEDURE [dbo].pts_SurveyAnswer_ListComments
   @SurveyQuestionID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      sa.SurveyAnswerID, 
         sa.Answer, 
         sa.AnswerDate
FROM SurveyAnswer AS sa (NOLOCK)
WHERE (sa.SurveyQuestionID = @SurveyQuestionID)
 AND (sa.Answer <> '')


GO