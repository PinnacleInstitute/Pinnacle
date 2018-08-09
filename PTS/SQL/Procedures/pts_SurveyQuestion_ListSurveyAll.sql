EXEC [dbo].pts_CheckProc 'pts_SurveyQuestion_ListSurveyAll'
GO

CREATE PROCEDURE [dbo].pts_SurveyQuestion_ListSurveyAll
   @SurveyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      sq.SurveyQuestionID, 
         sq.SurveyID, 
         sq.Question, 
         sq.Seq, 
         sq.IsText, 
         sq.Status, 
         sq.Total
FROM SurveyQuestion AS sq (NOLOCK)
WHERE (sq.SurveyID = @SurveyID)

ORDER BY   sq.Seq

GO