EXEC [dbo].pts_CheckProc 'pts_AssessQuestion_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_AssessQuestion_Fetch ( 
   @AssessQuestionID int,
   @AssessmentID int OUTPUT,
   @QuestionCode int OUTPUT,
   @Question nvarchar (1000) OUTPUT,
   @Description nvarchar (2000) OUTPUT,
   @Grp int OUTPUT,
   @Seq int OUTPUT,
   @QuestionType int OUTPUT,
   @RankMin int OUTPUT,
   @RankMax int OUTPUT,
   @ResultType int OUTPUT,
   @Answer int OUTPUT,
   @Points int OUTPUT,
   @NextType int OUTPUT,
   @NextQuestion int OUTPUT,
   @Formula varchar (100) OUTPUT,
   @CustomCode int OUTPUT,
   @MultiSelect bit OUTPUT,
   @MediaType int OUTPUT,
   @MediaFile varchar (80) OUTPUT,
   @Courses varchar (50) OUTPUT,
   @Status int OUTPUT,
   @Discrimination decimal (10, 8) OUTPUT,
   @Difficulty decimal (10, 8) OUTPUT,
   @Guessing decimal (10, 8) OUTPUT,
   @UseCount int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @AssessmentID = asq.AssessmentID ,
   @QuestionCode = asq.QuestionCode ,
   @Question = asq.Question ,
   @Description = asq.Description ,
   @Grp = asq.Grp ,
   @Seq = asq.Seq ,
   @QuestionType = asq.QuestionType ,
   @RankMin = asq.RankMin ,
   @RankMax = asq.RankMax ,
   @ResultType = asq.ResultType ,
   @Answer = asq.Answer ,
   @Points = asq.Points ,
   @NextType = asq.NextType ,
   @NextQuestion = asq.NextQuestion ,
   @Formula = asq.Formula ,
   @CustomCode = asq.CustomCode ,
   @MultiSelect = asq.MultiSelect ,
   @MediaType = asq.MediaType ,
   @MediaFile = asq.MediaFile ,
   @Courses = asq.Courses ,
   @Status = asq.Status ,
   @Discrimination = asq.Discrimination ,
   @Difficulty = asq.Difficulty ,
   @Guessing = asq.Guessing ,
   @UseCount = asq.UseCount
FROM AssessQuestion AS asq (NOLOCK)
WHERE asq.AssessQuestionID = @AssessQuestionID

GO