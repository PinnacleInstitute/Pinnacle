EXEC [dbo].pts_CheckProc 'pts_SurveyAnswer_ListComments_SurveyID'
GO

CREATE PROCEDURE [dbo].pts_SurveyAnswer_ListComments_SurveyID
   @SurveyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      sa.SurveyAnswerID, 
         sa.SurveyQuestionID, 
         sa.SurveyChoiceID, 
         sa.Answer, 
         sa.AnswerDate
FROM SurveyAnswer AS sa (NOLOCK)
LEFT OUTER JOIN SurveyQuestion AS sq (NOLOCK) ON (sa.SurveyQuestionID = sq.SurveyQuestionID)
WHERE (sq.SurveyID = @SurveyID)


GO