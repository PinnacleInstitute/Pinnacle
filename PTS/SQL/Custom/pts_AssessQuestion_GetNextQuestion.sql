EXEC [dbo].pts_CheckProc 'pts_AssessQuestion_GetNextQuestion'
GO

CREATE PROCEDURE [dbo].pts_AssessQuestion_GetNextQuestion
   @AssessQuestionID int ,
   @MemberAssessID int ,
   @NextQuestion int OUTPUT
AS

SET         NOCOUNT ON

DECLARE @AssessmentID int, @QuestionType int, @NextType int, @Question varchar(200), @Grp int, @Formula varchar(100), @CustomCode int

SELECT  @AssessmentID = AssessmentID, 
	@QuestionType = QuestionType, 
	@NextType = NextType, 
	@Grp = Grp, 
	@NextQuestion = NextQuestion, 
	@Formula = Formula, 
	@CustomCode = CustomCode 
FROM AssessQuestion WHERE AssessQuestionID = @AssessQuestionID

--No Next Type is defined
IF @NextType = 0
BEGIN
	EXEC pts_AssessQuestion_LoadDefaultQuestion @AssessmentID, @Grp, @NextQuestion OUTPUT, @Grp OUTPUT, @QuestionType OUTPUT, @Question OUTPUT
END
-- Specific Next Question for all Question Types
ELSE IF @NextType = 1
BEGIN
	SELECT @NextQuestion = ISNULL(AssessQuestionID,0) FROM AssessQuestion
	WHERE AssessmentID = @AssessmentID AND QuestionCode = @NextQuestion 
END
-- Custom Next Question for all Question Types
ELSE IF @NextType = 6
BEGIN
	EXEC pts_AssessQuestion_CustomNext @CustomCode, @AssessQuestionID, @MemberAssessID, @NextQuestion OUTPUT
END
-- Priority Question Types
ELSE IF @QuestionType = 1
BEGIN
--	Highest Priority
	IF @NextType = 2
	BEGIN
		EXEC pts_AssessQuestion_LoadDefaultQuestion @AssessmentID, @Grp, @NextQuestion OUTPUT, @Grp OUTPUT, @QuestionType OUTPUT,@Question OUTPUT
	END
--	Lowest Priority
	ELSE IF @NextType = 3
	BEGIN
		EXEC pts_AssessQuestion_LoadDefaultQuestion @AssessmentID, @Grp, @NextQuestion OUTPUT, @Grp OUTPUT, @QuestionType OUTPUT,@Question OUTPUT
	END
	ELSE
	BEGIN
		EXEC pts_AssessQuestion_LoadDefaultQuestion @AssessmentID, @Grp, @NextQuestion OUTPUT, @Grp OUTPUT, @QuestionType OUTPUT,@Question OUTPUT
	END
END
-- Rank Question Types
ELSE IF @QuestionType = 2
BEGIN
--	Sum of Answers
	IF @NextType = 4
	BEGIN
		EXEC pts_AssessQuestion_SumResultFormula @AssessmentID,@MemberAssessID,@Grp,@Formula,@NextQuestion OUTPUT 
	END
	ELSE
	BEGIN
		EXEC pts_AssessQuestion_LoadDefaultQuestion @AssessmentID, @Grp, @NextQuestion OUTPUT, @Grp OUTPUT, @QuestionType OUTPUT, @Question OUTPUT
	END
END
-- Choice Question Types
ELSE IF @QuestionType = 3
BEGIN
--	Sum of Answers
	IF @NextType = 4
	BEGIN
		EXEC pts_AssessQuestion_SumResultFormula @AssessmentID,@MemberAssessID,@Grp,@Formula,@NextQuestion OUTPUT 
	END
--	Specified by selected Choice
	ELSE IF @NextType = 5 
	BEGIN
		SELECT @NextQuestion = ac.NextQuestion
		FROM  AssessAnswer AS aa
		LEFT JOIN AssessChoice AS ac ON ac.AssessChoiceID = aa.AssessChoiceID
		WHERE aa.MemberAssessID = @MemberAssessID and aa.AssessQuestionID = @AssessQuestionID
		
		SELECT @NextQuestion = AssessQuestionID
		FROM  AssessQuestion
		WHERE  (AssessmentID = @AssessmentID)  and (QuestionCode = @NextQuestion)
	END
	ELSE
	BEGIN
		EXEC pts_AssessQuestion_LoadDefaultQuestion @AssessmentID, @Grp, @NextQuestion OUTPUT, @Grp OUTPUT, @QuestionType OUTPUT,@Question OUTPUT
	END
END

GO