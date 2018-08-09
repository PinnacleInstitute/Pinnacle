EXEC [dbo].pts_CheckProc 'pts_SurveyQuestion_ListSurvey'
GO

CREATE PROCEDURE [dbo].pts_SurveyQuestion_ListSurvey
   @SurveyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      sq.SurveyQuestionID, 
         sq.SurveyID, 
         sq.Question, 
         sq.Seq, 
         sq.IsText, 
         sq.Total
FROM SurveyQuestion AS sq (NOLOCK)
WHERE (sq.SurveyID = @SurveyID)
 AND (sq.Status <= 1)

ORDER BY   sq.Seq

GO