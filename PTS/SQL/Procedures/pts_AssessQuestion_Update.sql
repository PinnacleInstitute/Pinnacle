EXEC [dbo].pts_CheckProc 'pts_AssessQuestion_Update'
 GO

CREATE PROCEDURE [dbo].pts_AssessQuestion_Update ( 
   @AssessQuestionID int,
   @AssessmentID int,
   @QuestionCode int,
   @Question nvarchar (1000),
   @Description nvarchar (2000),
   @Grp int,
   @Seq int,
   @QuestionType int,
   @RankMin int,
   @RankMax int,
   @ResultType int,
   @Answer int,
   @Points int,
   @NextType int,
   @NextQuestion int,
   @Formula varchar (100),
   @CustomCode int,
   @MultiSelect bit,
   @MediaType int,
   @MediaFile varchar (80),
   @Courses varchar (50),
   @Status int,
   @Discrimination decimal (10, 8),
   @Difficulty decimal (10, 8),
   @Guessing decimal (10, 8),
   @UseCount int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE asq
SET asq.AssessmentID = @AssessmentID ,
   asq.QuestionCode = @QuestionCode ,
   asq.Question = @Question ,
   asq.Description = @Description ,
   asq.Grp = @Grp ,
   asq.Seq = @Seq ,
   asq.QuestionType = @QuestionType ,
   asq.RankMin = @RankMin ,
   asq.RankMax = @RankMax ,
   asq.ResultType = @ResultType ,
   asq.Answer = @Answer ,
   asq.Points = @Points ,
   asq.NextType = @NextType ,
   asq.NextQuestion = @NextQuestion ,
   asq.Formula = @Formula ,
   asq.CustomCode = @CustomCode ,
   asq.MultiSelect = @MultiSelect ,
   asq.MediaType = @MediaType ,
   asq.MediaFile = @MediaFile ,
   asq.Courses = @Courses ,
   asq.Status = @Status ,
   asq.Discrimination = @Discrimination ,
   asq.Difficulty = @Difficulty ,
   asq.Guessing = @Guessing ,
   asq.UseCount = @UseCount
FROM AssessQuestion AS asq
WHERE asq.AssessQuestionID = @AssessQuestionID

GO