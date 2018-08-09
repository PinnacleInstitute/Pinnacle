EXEC [dbo].pts_CheckProc 'pts_AssessAnswer_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_AssessAnswer_Fetch ( 
   @AssessAnswerID int,
   @MemberAssessID int OUTPUT,
   @AssessQuestionID int OUTPUT,
   @AssessChoiceID int OUTPUT,
   @Discrimination decimal (10, 8) OUTPUT,
   @Difficulty decimal (10, 8) OUTPUT,
   @Guessing decimal (10, 8) OUTPUT,
   @UseCount int OUTPUT,
   @Answer int OUTPUT,
   @AnswerDate datetime OUTPUT,
   @AnswerText nvarchar (500) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberAssessID = asa.MemberAssessID ,
   @AssessQuestionID = asa.AssessQuestionID ,
   @AssessChoiceID = asa.AssessChoiceID ,
   @Discrimination = asq.Discrimination ,
   @Difficulty = asq.Difficulty ,
   @Guessing = asq.Guessing ,
   @UseCount = asq.UseCount ,
   @Answer = asa.Answer ,
   @AnswerDate = asa.AnswerDate ,
   @AnswerText = asa.AnswerText
FROM AssessAnswer AS asa (NOLOCK)
LEFT OUTER JOIN MemberAssess AS ma (NOLOCK) ON (asa.MemberAssessID = ma.MemberAssessID)
LEFT OUTER JOIN AssessQuestion AS asq (NOLOCK) ON (asa.AssessQuestionID = asq.AssessQuestionID)
WHERE asa.AssessAnswerID = @AssessAnswerID

GO