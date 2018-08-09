EXEC [dbo].pts_CheckProc 'pts_SurveyChoice_ListSurvey'
GO

CREATE PROCEDURE [dbo].pts_SurveyChoice_ListSurvey
   @SurveyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      sc.SurveyChoiceID, 
         sc.SurveyQuestionID, 
         sc.Choice, 
         sc.Total
FROM SurveyChoice AS sc (NOLOCK)
LEFT OUTER JOIN SurveyQuestion AS sq (NOLOCK) ON (sc.SurveyQuestionID = sq.SurveyQuestionID)
WHERE (sq.SurveyID = @SurveyID)
 AND (sq.Status <= 1)

ORDER BY   sc.Seq

GO