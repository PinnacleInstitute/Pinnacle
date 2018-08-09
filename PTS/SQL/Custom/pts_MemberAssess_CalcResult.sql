EXEC [dbo].pts_CheckProc 'pts_MemberAssess_CalcResult'
GO

CREATE PROCEDURE [dbo].pts_MemberAssess_CalcResult
   @MemberAssessID int ,
   @newResult nvarchar (1000) ,
   @Result nvarchar (1000) OUTPUT
AS

SET NOCOUNT ON

IF @newResult != ''
BEGIN
	UPDATE MemberAssess SET Result = @newResult, CompleteDate = CURRENT_TIMESTAMP WHERE MemberAssessID = @MemberAssessID
END
ELSE
BEGIN
	DECLARE @AssessmentID int, @Total int, @MemberID int
	DECLARE @ResultType int, @Formula varchar(100), @CustomCode int, @IsCertify int, @Grade int, @Points int
	
	SELECT  @AssessmentID = AssessmentID, @MemberID = MemberID FROM MemberAssess WHERE MemberAssessID = @MemberAssessID
	
	SELECT  @ResultType = ResultType, @Formula = Formula, @CustomCode = CustomCode, @IsCertify = IsCertify, @Grade = Grade, @Points = Points 
	FROM Assessment WHERE AssessmentID = @AssessmentID

-- 	-- Don't calculate self-assessment introspectives
	IF @ResultType = 4
	BEGIN
			UPDATE MemberAssess SET CompleteDate = CURRENT_TIMESTAMP WHERE MemberAssessID = @MemberAssessID
	END		
	IF @ResultType != 4
	BEGIN
--		-- Get the sum of the points as defined by (@Formula)
		IF @ResultType = 1 AND @Formula != ''
		BEGIN
			EXEC pts_MemberAssess_CalcResultFormula @MemberAssessID, @Formula, @Result OUTPUT
		END
--		-- Get the custom result specified by (@CustomCode)
		ELSE IF @ResultType = 2 AND @CustomCode != 0
		BEGIN
			DECLARE @y int
--		--	IF @CustomCode = 1 EXEC pts_MemberAssess_CalcResult_1_ @MemberAssessID, @Result OUTPUT
		END
--		-- Default: Get the sum of all answers
		ELSE 
		BEGIN
			DECLARE @ResultTypeCount int, @ResultPoints int
			SET @ResultPoints = 0

			SELECT @ResultTypeCount = COUNT(*) FROM AssessAnswer AS aa
			LEFT JOIN AssessQuestion AS aq ON aa.AssessQuestionID = aq.AssessQuestionID
			WHERE aa.MemberAssessID = @MemberAssessID AND aq.ResultType <> 0

			IF @ResultTypeCount > 0 EXEC pts_MemberAssess_CalcResultType @MemberAssessID, @ResultPoints OUTPUT

			SELECT @Total = SUM(aa.answer) + SUM(ISNULL(ac.points,0)) FROM AssessAnswer AS aa
			LEFT JOIN AssessQuestion AS aq ON aa.AssessQuestionID = aq.AssessQuestionID
			LEFT JOIN AssessChoice AS ac ON aa.AssessChoiceID = ac.AssessChoiceID
			WHERE aa.MemberAssessID = @MemberAssessID AND aq.ResultType = 0

			SET @Result = CAST((@Total + @ResultPoints) as nvarchar(10))
		END
		IF @Result IS NOT NULL
		BEGIN 
			DECLARE @Status int
			DECLARE @Score MONEY
			SET @Status = 0
			SET @Score = 0
			IF @IsCertify = 1 AND ISNUMERIC(@Result) = 1	
			BEGIN
				IF @Points = 0 SET @Points = 100
				SET @Score = (CAST(@Result AS MONEY) / @Points) * 100
				IF @Score >= @Grade
					SET @Status = 1
				ELSE
					SET @Status = 2
				SET @Result = CAST(CAST(@Score AS INT) AS VARCHAR(10)) + '% ( ' + @Result + ' / ' + CAST(@Points AS VARCHAR(10)) + ' )'
			END
			UPDATE MemberAssess SET Result = @Result, Score = @Score, Status = @Status, CompleteDate = CURRENT_TIMESTAMP WHERE MemberAssessID = @MemberAssessID
--			-- look for member sessions with courses using this assessment as a final exam.
			EXEC pts_Session_GradeExam @AssessmentID, @MemberID
		END
	END
END
	
GO