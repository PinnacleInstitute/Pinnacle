EXEC [dbo].pts_CheckProc 'pts_SurveyAnswer_Add'
 GO

CREATE PROCEDURE [dbo].pts_SurveyAnswer_Add ( 
   @SurveyAnswerID int OUTPUT,
   @SurveyQuestionID int,
   @MemberID int,
   @SurveyChoiceID int,
   @Answer nvarchar (500),
   @AnswerDate datetime,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO SurveyAnswer (
            SurveyQuestionID , 
            MemberID , 
            SurveyChoiceID , 
            Answer , 
            AnswerDate
            )
VALUES (
            @SurveyQuestionID ,
            @MemberID ,
            @SurveyChoiceID ,
            @Answer ,
            @AnswerDate            )

SET @mNewID = @@IDENTITY

SET @SurveyAnswerID = @mNewID

GO