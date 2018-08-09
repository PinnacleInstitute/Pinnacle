EXEC [dbo].pts_CheckProc 'pts_SurveyQuestion_Delete'
 GO

CREATE PROCEDURE [dbo].pts_SurveyQuestion_Delete ( 
   @SurveyQuestionID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE sq
FROM SurveyQuestion AS sq
WHERE sq.SurveyQuestionID = @SurveyQuestionID

GO