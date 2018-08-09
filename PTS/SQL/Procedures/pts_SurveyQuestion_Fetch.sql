EXEC [dbo].pts_CheckProc 'pts_SurveyQuestion_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_SurveyQuestion_Fetch ( 
   @SurveyQuestionID int,
   @SurveyID int OUTPUT,
   @Question nvarchar (1000) OUTPUT,
   @Seq int OUTPUT,
   @IsText bit OUTPUT,
   @Total int OUTPUT,
   @Status int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @SurveyID = sq.SurveyID ,
   @Question = sq.Question ,
   @Seq = sq.Seq ,
   @IsText = sq.IsText ,
   @Total = sq.Total ,
   @Status = sq.Status
FROM SurveyQuestion AS sq (NOLOCK)
WHERE sq.SurveyQuestionID = @SurveyQuestionID

GO