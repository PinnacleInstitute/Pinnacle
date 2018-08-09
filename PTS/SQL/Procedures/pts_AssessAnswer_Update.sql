EXEC [dbo].pts_CheckProc 'pts_AssessAnswer_Update'
 GO

CREATE PROCEDURE [dbo].pts_AssessAnswer_Update ( 
   @AssessAnswerID int,
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

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE asa
SET asa.MemberAssessID = @MemberAssessID ,
   asa.AssessQuestionID = @AssessQuestionID ,
   asa.AssessChoiceID = @AssessChoiceID ,
   asa.Answer = @Answer ,
   asa.AnswerDate = @AnswerDate ,
   asa.AnswerText = @AnswerText
FROM AssessAnswer AS asa
WHERE asa.AssessAnswerID = @AssessAnswerID

GO