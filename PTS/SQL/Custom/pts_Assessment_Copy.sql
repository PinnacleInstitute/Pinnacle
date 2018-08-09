EXEC [dbo].pts_CheckProc 'pts_Assessment_Copy'
GO

--DECLARE @NewAssessmentID int 
--EXEC pts_Assessment_Copy 7, 194, @NewAssessmentID OUTPUT
--PRINT CAST(@NewAssessmentID AS VARCHAR(10))

CREATE PROCEDURE [dbo].pts_Assessment_Copy
   @AssessmentID int ,
   @TrainerID int ,
   @NewAssessmentID int OUTPUT
AS

INSERT INTO Assessment (
            TrainerID, CompanyID, FirstQuestionCode, AssessmentName, Description, Courses, Assessments, AssessDate, 
            Status, AssessmentType, NewURL, EditURL, ResultType, Formula, CustomCode, Takes, Delay, IsTrial, IsPaid, 
            IsCertify, AssessType, AssessLevel, AssessLength, ScoreFactor, Rating, Grade, Points, TimeLimit
            )
SELECT @TrainerID, CompanyID, FirstQuestionCode, AssessmentName, Description, Courses, Assessments, AssessDate, 
       Status, AssessmentType, NewURL, EditURL, ResultType, Formula, CustomCode, Takes, Delay, IsTrial, IsPaid, 
       IsCertify, AssessType, AssessLevel, AssessLength, ScoreFactor, Rating, Grade, Points, TimeLimit
FROM Assessment WHERE AssessmentID = @AssessmentID 
     

SET @NewAssessmentID = @@IDENTITY

DECLARE @AssessQuestionID int, @QuestionCode int, @Question nvarchar (1000), @Description nvarchar (2000)
DECLARE @Grp int, @Seq int, @QuestionType int, @RankMin int, @RankMax int, @ResultType int, @Answer int, @Points int
DECLARE @NextType int, @NextQuestion int, @Formula varchar (100), @CustomCode int, @MultiSelect bit, @MediaType int
DECLARE @MediaFile varchar (80), @Courses varchar (50), @Status int, @Discrimination decimal (10, 8)
DECLARE @Difficulty decimal (10, 8), @Guessing decimal (10, 8), @UseCount int

DECLARE AssessQuestion_cursor CURSOR LOCAL STATIC FOR 
SELECT AssessQuestionID, QuestionCode, Question, Description, Grp, Seq, QuestionType, RankMin, RankMax,
ResultType, Answer, Points, NextType, NextQuestion, Formula, CustomCode, MultiSelect, MediaType, MediaFile, Courses,
Status, Discrimination, Difficulty, Guessing, UseCount
FROM AssessQuestion WHERE AssessmentID = @AssessmentID
OPEN AssessQuestion_cursor
FETCH NEXT FROM AssessQuestion_cursor INTO @AssessQuestionID, @QuestionCode, @Question, @Description, 
@Grp, @Seq, @QuestionType, @RankMin, @RankMax, @ResultType, @Answer, @Points, @NextType, @NextQuestion, @Formula, 
@CustomCode, @MultiSelect, @MediaType, @MediaFile, @Courses, @Status, @Discrimination, @Difficulty, @Guessing, @UseCount

WHILE @@FETCH_STATUS = 0
BEGIN
	DECLARE @NewAssessQuestionID int
	EXEC pts_AssessQuestion_Add @NewAssessQuestionID OUTPUT, @NewAssessmentID, @QuestionCode, @Question, @Description, @Grp,
         @Seq, @QuestionType, @RankMin, @RankMax, @ResultType, @Answer, @Points, @NextType, @NextQuestion, @Formula,
         @CustomCode, @MultiSelect, @MediaType, @MediaFile, @Courses, @Status, @Discrimination, @Difficulty, @Guessing, @UseCount, 1

	IF @QuestionType = 3
	BEGIN
		DECLARE @AssessChoiceID int, @Choice nvarchar (200)
		DECLARE AssessChoice_cursor CURSOR LOCAL STATIC FOR 
		SELECT  Choice, Seq, Points, NextQuestion, Courses
		FROM AssessChoice WHERE AssessQuestionID = @AssessQuestionID
		OPEN AssessChoice_cursor
		FETCH NEXT FROM AssessChoice_cursor INTO @Choice, @Seq, @Points, @NextQuestion, @Courses
		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC pts_AssessChoice_Add @AssessChoiceID OUTPUT, @NewAssessQuestionID, @Choice, @Seq, @Points, @NextQuestion, @Courses, 1

			FETCH NEXT FROM AssessChoice_cursor INTO @Choice, @Seq, @Points, @NextQuestion, @Courses
		END
		CLOSE AssessChoice_cursor
		DEALLOCATE AssessChoice_cursor
	END

	FETCH NEXT FROM AssessQuestion_cursor INTO @AssessQuestionID, @QuestionCode, @Question, @Description, 
	@Grp, @Seq, @QuestionType, @RankMin, @RankMax, @ResultType, @Answer, @Points, @NextType, @NextQuestion, @Formula, 
	@CustomCode, @MultiSelect, @MediaType, @MediaFile, @Courses, @Status, @Discrimination, @Difficulty, @Guessing, @UseCount

END
CLOSE AssessQuestion_cursor
DEALLOCATE AssessQuestion_cursor



GO