EXEC [dbo].pts_CheckProc 'pts_AssessAnswer_Add'
 GO

CREATE PROCEDURE [dbo].pts_AssessAnswer_Add ( 
   @AssessAnswerID int OUTPUT,
   @MemberAssessID int,
   @AssessQuestionID int,
   @AssessChoiceID int,
   @Answer int,
   @AnswerDate datetime,
   @AnswerText nvarchar (500),
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO AssessAnswer (
            MemberAssessID , 
            AssessQuestionID , 
            AssessChoiceID , 
            Answer , 
            AnswerDate , 
            AnswerText
            )
VALUES (
            @MemberAssessID ,
            @AssessQuestionID ,
            @AssessChoiceID ,
            @Answer ,
            @AnswerDate ,
            @AnswerText            )

SET @mNewID = @@IDENTITY

SET @AssessAnswerID = @mNewID

GO