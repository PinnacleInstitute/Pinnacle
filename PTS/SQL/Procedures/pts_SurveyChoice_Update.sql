EXEC [dbo].pts_CheckProc 'pts_SurveyChoice_Update'
 GO

CREATE PROCEDURE [dbo].pts_SurveyChoice_Update ( 
   @SurveyChoiceID int,
   @SurveyQuestionID int,
   @Choice nvarchar (500),
   @Seq int,
   @Total int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE sc
SET sc.SurveyQuestionID = @SurveyQuestionID ,
   sc.Choice = @Choice ,
   sc.Seq = @Seq ,
   sc.Total = @Total
FROM SurveyChoice AS sc
WHERE sc.SurveyChoiceID = @SurveyChoiceID

GO