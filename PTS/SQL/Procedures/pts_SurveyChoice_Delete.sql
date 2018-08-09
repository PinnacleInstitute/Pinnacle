EXEC [dbo].pts_CheckProc 'pts_SurveyChoice_Delete'
 GO

CREATE PROCEDURE [dbo].pts_SurveyChoice_Delete ( 
   @SurveyChoiceID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE sc
FROM SurveyChoice AS sc
WHERE sc.SurveyChoiceID = @SurveyChoiceID

GO