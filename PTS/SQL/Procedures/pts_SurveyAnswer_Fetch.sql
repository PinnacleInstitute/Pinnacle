EXEC [dbo].pts_CheckProc 'pts_SurveyAnswer_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_SurveyAnswer_Fetch ( 
   @SurveyAnswerID int,
   @SurveyQuestionID int OUTPUT,
   @MemberID int OUTPUT,
   @SurveyChoiceID int OUTPUT,
   @Answer nvarchar (500) OUTPUT,
   @AnswerDate datetime OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @SurveyQuestionID = sa.SurveyQuestionID ,
   @MemberID = sa.MemberID ,
   @SurveyChoiceID = sa.SurveyChoiceID ,
   @Answer = sa.Answer ,
   @AnswerDate = sa.AnswerDate
FROM SurveyAnswer AS sa (NOLOCK)
WHERE sa.SurveyAnswerID = @SurveyAnswerID

GO