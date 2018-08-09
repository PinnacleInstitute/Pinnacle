EXEC [dbo].pts_CheckProc 'pts_SurveyChoice_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_SurveyChoice_Fetch ( 
   @SurveyChoiceID int,
   @SurveyQuestionID int OUTPUT,
   @Choice nvarchar (500) OUTPUT,
   @Seq int OUTPUT,
   @Total int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @SurveyQuestionID = sc.SurveyQuestionID ,
   @Choice = sc.Choice ,
   @Seq = sc.Seq ,
   @Total = sc.Total
FROM SurveyChoice AS sc (NOLOCK)
WHERE sc.SurveyChoiceID = @SurveyChoiceID

GO