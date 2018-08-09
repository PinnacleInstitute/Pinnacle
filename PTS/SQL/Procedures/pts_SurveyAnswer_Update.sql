EXEC [dbo].pts_CheckProc 'pts_SurveyAnswer_Update'
 GO

CREATE PROCEDURE [dbo].pts_SurveyAnswer_Update ( 
   @SurveyAnswerID int,
   @SurveyQuestionID int,
   @MemberID int,
   @SurveyChoiceID int,
   @Answer nvarchar (500),
   @AnswerDate datetime,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE sa
SET sa.SurveyQuestionID = @SurveyQuestionID ,
   sa.MemberID = @MemberID ,
   sa.SurveyChoiceID = @SurveyChoiceID ,
   sa.Answer = @Answer ,
   sa.AnswerDate = @AnswerDate
FROM SurveyAnswer AS sa
WHERE sa.SurveyAnswerID = @SurveyAnswerID

GO