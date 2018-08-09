EXEC [dbo].pts_CheckProc 'pts_Survey_Delete'
GO

CREATE PROCEDURE [dbo].pts_Survey_Delete
   @SurveyID int ,
   @UserID int
AS

DELETE sc FROM SurveyChoice AS sc JOIN SurveyQuestion AS sq ON sc.SurveyQuestionID = sq.SurveyQuestionID WHERE sq.SurveyID = @SurveyID
DELETE SurveyQuestion where SurveyID = @SurveyID
DELETE Survey where SurveyID = @SurveyID

GO