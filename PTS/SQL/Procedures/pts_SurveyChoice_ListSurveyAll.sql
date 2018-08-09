EXEC [dbo].pts_CheckProc 'pts_SurveyChoice_ListSurveyAll'
GO

CREATE PROCEDURE [dbo].pts_SurveyChoice_ListSurveyAll
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

ORDER BY   sc.Seq

GO