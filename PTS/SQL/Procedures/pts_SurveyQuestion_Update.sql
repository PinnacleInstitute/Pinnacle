EXEC [dbo].pts_CheckProc 'pts_SurveyQuestion_Update'
 GO

CREATE PROCEDURE [dbo].pts_SurveyQuestion_Update ( 
   @SurveyQuestionID int,
   @SurveyID int,
   @Question nvarchar (1000),
   @Seq int,
   @IsText bit,
   @Total int,
   @Status int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE sq
SET sq.SurveyID = @SurveyID ,
   sq.Question = @Question ,
   sq.Seq = @Seq ,
   sq.IsText = @IsText ,
   sq.Total = @Total ,
   sq.Status = @Status
FROM SurveyQuestion AS sq
WHERE sq.SurveyQuestionID = @SurveyQuestionID

GO