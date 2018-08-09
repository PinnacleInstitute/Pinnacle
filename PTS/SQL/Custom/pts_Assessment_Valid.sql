/*
Checking List:
	date created:4/29/05 -> 3-Check Assessment Single and Multiple Results formula
	date created:4/29/05 -> 6-Check Questiontype 3 and 4 recommended courses must be non-formula
	date created:4/29/05 -> 7-Check Questiontype 1 and 2 recommended course formula 
	date created:4/29/05 -> 9-Check Choice Recommended Courses must be non-formula
	date created:4/29/05 -> 12-Decision Assessment must have at least one question result
	date created:		 ->	15-Unique Question Codes
	date created:		 ->	18-MediaType required MediaFile
	date created:		 ->	21-Decision Choices must be single-select 
	date created:		 ->	24-Choice questions must have at least two choices
	date created:		 ->	27-NextQuestion Choices (Decision) must have a next question
	date created:4/29/05 -> 30-NextQuestion Choices next question not refer to itself
	date created:		 ->	33-NextQuestion Questions must have a nextquestion
	date created:		 ->	36-Decision Questions must be one per page
	date created:		 ->	39-Decision Result Question must have a description
	date created:		 ->	42-Decision Questions must be type 3 or 4
	date created:		 ->	45-NonDecision Questions must not be type 4
	date created:		 ->	48-Assessment FirstQuestionCode must be valid question
	date created:		 ->	51-Questions NextQuestion must be valid question
	date created:		 ->	54-Choices NextQuestion must be valid question
*/

EXEC [dbo].pts_CheckProc 'pts_Assessment_Valid'
GO

--DECLARE @Result varchar(1000) EXEC pts_Assessment_Valid 1, @Result OUTPUT PRINT @Result

CREATE PROCEDURE [dbo].pts_Assessment_Valid
   @AssessmentID int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON

SET @Result = ''

DECLARE @x int, @ID int, @Code int, @Cnt int, @Type int 
DECLARE @asmResultType int, @asmFormula nvarchar(100), @asmCourses nvarchar(50)
DECLARE @Crsopenbracket int, @Crsclosebracket int, @Course nvarchar(100)
DECLARE  @isError int, @tmpisError int, @CrsX int, @Token nvarchar(50), @Label nvarchar(50)

SELECT  @asmResultType = asm.ResultType, @asmFormula = asm.Formula, @asmCourses = asm.Courses FROM Assessment AS asm
WHERE  asm.AssessmentID = @AssessmentID

--3_Check Assessment Single and Multiple Results formula
IF @asmResultType = 1 
BEGIN
	SET @x =  CHARINDEX(':',@asmFormula)
	SET @Crsopenbracket = CHARINDEX('[',@asmCourses)
	SET @Crsclosebracket = CHARINDEX(']',@asmCourses)
	SET @CrsX =  CHARINDEX(':',@asmCourses)
	SET @isError = 0
	SET @tmpisError = 0

--	Formula Error
	IF @asmFormula != ''
	BEGIN
		IF @x = 0 SET @Result = @Result + 'Sum formula Error ! ~~'
	END

--  Result required normal courses or formula with no bracket
	IF @asmFormula = ''
	BEGIN
		IF @CrsX > 0
		BEGIN
			IF @Crsopenbracket > 0 OR @Crsclosebracket > 0  SET @isError = 1
			ELSE
			BEGIN
				EXEC pts_Assessment_CheckCourseFormula  @asmCourses, @tmpisError OUTPUT
				IF @tmpisError != 0 SET @isError  = 1
		 	END
			IF @isError = 1	SET @Result = @Result + 'Incorrect course formula for single result !~~'
		END
    END

--  Results required normal courses or formula with bracket
	IF @x > 0 AND @CrsX > 0
	BEGIN
		SET @isError = 0
		IF @Crsopenbracket = 0 OR @Crsclosebracket = 0 SET @isError = 1
		ELSE 
		BEGIN
			SET @Crsopenbracket = 0
			SET @Crsclosebracket = 0

			WHILE @asmCourses != ''
			BEGIN
--  		    Get Each Token ( ex. C>a:1,2,3)	
			    SET @Crsopenbracket = CHARINDEX('[',@asmCourses)
			    SET @Crsclosebracket = CHARINDEX(']',@asmCourses)
			
			    IF @Crsopenbracket > 0 AND @Crsclosebracket > 0
			    BEGIN
			        SET @Token = SUBSTRING(@asmCourses,1,@Crsclosebracket-1)
					SET @asmCourses = SUBSTRING(@asmCourses, @Crsclosebracket+1, LEN(@asmCourses) - @Crsclosebracket)
			    END
			    ELSE
			    BEGIN
					SET @asmCourses = ''
			    END
			    SET @Label = SUBSTRING(@Token,1,@Crsopenbracket-1) + CAST(':' AS nvarchar(1))
				IF CHARINDEX(@Label,@asmFormula) = 0 SET @isError = 1
				IF @isError != 1
				BEGIN
					SET @Course = SUBSTRING(@Token,@Crsopenbracket+1,LEN(@Token)-@Crsopenbracket)
					IF CHARINDEX(':',@Course) = 0 SET @isError  = 1
					EXEC pts_Assessment_CheckCourseFormula  @Course, @tmpisError OUTPUT
					IF @tmpisError != 0 SET @isError  = 1
			   	END
			END			
		END
		IF @isError = 1	SET @Result = @Result + 'Incorrect course formula for multiple result !~~'
	END
END

--6_Check Questiontype 3 and 4 recommended courses must be non-formula
DECLARE AssessQuestion_cursor CURSOR STATIC FOR
SELECT aq.Courses,aq.QuestionCode FROM AssessQuestion AS aq
WHERE aq.AssessmentID = @AssessmentID AND aq.Courses LIKE '%:%'AND (aq.QuestionType = 3 OR aq.Questiontype = 4)

OPEN AssessQuestion_cursor
FETCH NEXT FROM AssessQuestion_cursor INTO @Course, @Code
SET @x = 0
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @x = @x + 1
	IF @x = 1 SET @Result = @Result + 'Course formula is not required in Question ('
	SET @Result = @Result + CAST(@Code AS VARCHAR(10))
	FETCH NEXT FROM AssessQuestion_cursor INTO @Course, @Code
	IF @@FETCH_STATUS = 0 SET @Result = @Result + ',' ELSE SET @Result = @Result + ')~~'

END
CLOSE AssessQuestion_cursor
DEALLOCATE AssessQuestion_cursor

--7-Check Questiontype 1 and 2 recommended course formula
DECLARE AssessQuestion_cursor CURSOR STATIC FOR
SELECT aq.Courses,aq.QuestionCode FROM AssessQuestion AS aq
WHERE aq.AssessmentID = @AssessmentID AND aq.Courses LIKE '%:%'AND (aq.QuestionType = 1 OR aq.Questiontype = 2)

OPEN AssessQuestion_cursor
FETCH NEXT FROM AssessQuestion_cursor INTO @Course, @Code
SET @x = 0
SET @isError = 0
SET @tmpisError = 0

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Crsopenbracket = CHARINDEX('[',@Course)
	SET @Crsclosebracket = CHARINDEX(']',@Course)

	IF @Crsopenbracket > 0 OR @Crsclosebracket > 0  
	BEGIN
		IF @x = 0 SET @Result = @Result + 'Incorrect course formula in Question ('
		SET @Result = @Result + CAST(@Code AS VARCHAR(10))
		SET @isError = 1
		SET @x = 1
	END 
	ELSE
	BEGIN
		EXEC pts_Assessment_CheckCourseFormula  @Course, @tmpisError OUTPUT
		IF @tmpisError != 0 
		BEGIN
			IF @x = 0 SET @Result = @Result + 'Incorrect course formula in Question ('
			SET @Result = @Result + CAST(@Code AS VARCHAR(10))
			SET @isError = 1
			SET @x = 1
		END
	END
	FETCH NEXT FROM AssessQuestion_cursor INTO @Course, @Code
	IF @@FETCH_STATUS = 0 
	BEGIN
		IF @isError = 1 SET @Result = @Result + ',' 
    END
	ELSE IF @isError = 1  SET @Result = @Result + ')~~'

END
CLOSE AssessQuestion_cursor
DEALLOCATE AssessQuestion_cursor


--9_Check Choice Recommended Courses must be non-formula
DECLARE AssessChoice_cursor CURSOR STATIC FOR 
SELECT ac.Courses, aq.QuestionCode FROM AssessQuestion AS aq
JOIN AssessChoice AS ac ON aq.AssessQuestionID = ac.AssessQuestionID 
WHERE aq.AssessmentID = @AssessmentID AND ac.Courses LIKE '%:%'

OPEN AssessChoice_cursor
FETCH NEXT FROM AssessChoice_cursor INTO @Course, @Code
SET @x = 0
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @x = @x + 1
	IF @x = 1 SET @Result = @Result + 'Course formula not require for choice in Question - ('
	SET @Result = @Result + CAST(@Code AS VARCHAR(10))
	FETCH NEXT FROM AssessChoice_cursor INTO @Course, @Code
	IF @@FETCH_STATUS = 0 SET @Result = @Result + ',' ELSE SET @Result = @Result + ')~~'
END
CLOSE AssessChoice_cursor
DEALLOCATE AssessChoice_cursor

--12_Decision Assessment must have at last one question result
IF @asmResultType = 3
BEGIN
	SELECT  @Cnt=COUNT(*) FROM AssessQuestion AS aq
	JOIN Assessment AS asm ON aq.AssessmentID = asm.AssessmentID
	WHERE aq.AssessmentID = @AssessmentID AND aq.QuestionType = 4 
	IF @Cnt < 1 
	BEGIN
		SET @Result = @Result + 'Must have at least 1 result question~~'
	END
END

--15_Unique Question Codes
DECLARE Assess_cursor CURSOR STATIC FOR 
SELECT AssessmentID, QuestionCode, COUNT(*) FROM AssessQuestion GROUP BY AssessmentID, QuestionCode 
HAVING AssessmentID = @AssessmentID AND QuestionCode > 0 AND COUNT(*) > 1
OPEN Assess_cursor
FETCH NEXT FROM Assess_cursor INTO @ID, @Code, @Cnt 
SET @x = 0
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @x = @x + 1
	IF @x = 1 SET @Result = @Result + 'Duplicate Question #s ('
	SET @Result = @Result + CAST(@Code AS VARCHAR(10))
	FETCH NEXT FROM Assess_cursor INTO @ID, @Code, @Cnt 
	IF @@FETCH_STATUS = 0 SET @Result = @Result + ',' ELSE SET @Result = @Result + ')~~'
END
CLOSE Assess_cursor
DEALLOCATE Assess_cursor

--18_MediaType required MediaFile
DECLARE Assess_cursor CURSOR STATIC FOR 
SELECT QuestionCode FROM AssessQuestion WHERE AssessmentID = @AssessmentID AND MediaType > 0 AND MediaFile = ''
OPEN Assess_cursor
FETCH NEXT FROM Assess_cursor INTO @Code 
SET @x = 0
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @x = @x + 1
	IF @x = 1 SET @Result = @Result + 'Question Missing MediaFile ('
	SET @Result = @Result + CAST(@Code AS VARCHAR(10))
	FETCH NEXT FROM Assess_cursor INTO @Code 
	IF @@FETCH_STATUS = 0 SET @Result = @Result + ',' ELSE SET @Result = @Result + ')~~'
END
CLOSE Assess_cursor
DEALLOCATE Assess_cursor

--21_Decision Choices must be single-select 
IF @asmResultType = 3
BEGIN
	DECLARE Assess_cursor CURSOR STATIC FOR 
	SELECT QuestionCode FROM AssessQuestion WHERE AssessmentID = @AssessmentID AND MultiSelect = 1
	OPEN Assess_cursor
	FETCH NEXT FROM Assess_cursor INTO @Code 
	SET @x = 0
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @x = @x + 1
		IF @x = 1 SET @Result = @Result + 'Invalid Decision Tree Multiselect Choices ('
		SET @Result = @Result + CAST(@Code AS VARCHAR(10))
		FETCH NEXT FROM Assess_cursor INTO @Code 
		IF @@FETCH_STATUS = 0 SET @Result = @Result + ',' ELSE SET @Result = @Result + ')~~'
	END
	CLOSE Assess_cursor
	DEALLOCATE Assess_cursor
END

--24_Choice questions must have at least two choices
DECLARE Assess_cursor CURSOR STATIC FOR 
SELECT aq.AssessmentID, aq.QuestionCode,aq.QuestionType, COUNT(ac.AssessChoiceID) FROM AssessQuestion AS aq
LEFT JOIN AssessChoice AS ac ON aq.AssessQuestionID = ac.AssessQuestionID 
GROUP BY aq.AssessmentID, aq.QuestionCode, aq.QuestionType
HAVING aq.AssessmentID = @AssessmentID AND COUNT(ac.AssessChoiceID) < 2 AND aq.QuestionType = 3
OPEN Assess_cursor
FETCH NEXT FROM Assess_cursor INTO @ID, @Code,@Type, @Cnt 
SET @x = 0
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @x = @x + 1
	IF @x = 1 SET @Result = @Result + 'Too Few Choices ('
	SET @Result = @Result + CAST(@Code AS VARCHAR(10))
	FETCH NEXT FROM Assess_cursor INTO @ID, @Code,@Type, @Cnt 
	IF @@FETCH_STATUS = 0 SET @Result = @Result + ',' ELSE SET @Result = @Result + ')~~'
END
CLOSE Assess_cursor
DEALLOCATE Assess_cursor

--27_NextQuestion Choices (Decision) must have a next question
DECLARE Assess_cursor CURSOR STATIC FOR 
SELECT aq.QuestionCode FROM AssessQuestion AS aq
JOIN AssessChoice AS ac ON aq.AssessQuestionID = ac.AssessQuestionID 
JOIN Assessment AS am ON aq.AssessmentID = am.AssessmentID 
WHERE aq.AssessmentID = @AssessmentID AND(aq.NextType = 5 OR am.ResultType = 3) AND ac.NextQuestion = 0
OPEN Assess_cursor
FETCH NEXT FROM Assess_cursor INTO @Code 
SET @x = 0
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @x = @x + 1
	IF @x = 1 SET @Result = @Result + 'Choice Missing Next Question ('
	SET @Result = @Result + CAST(@Code AS VARCHAR(10))
	FETCH NEXT FROM Assess_cursor INTO @Code 
	IF @@FETCH_STATUS = 0 SET @Result = @Result + ',' ELSE SET @Result = @Result + ')~~'
END
CLOSE Assess_cursor
DEALLOCATE Assess_cursor

--30_NextQuestion Choices next question not refer to itself
DECLARE Assess_cursor CURSOR STATIC FOR 
SELECT aq.QuestionCode FROM AssessQuestion AS aq
JOIN AssessChoice AS ac ON aq.AssessQuestionID = ac.AssessQuestionID 
JOIN Assessment AS am ON aq.AssessmentID = am.AssessmentID 
WHERE aq.AssessmentID = @AssessmentID AND aq.NextType = 5 AND aq.QuestionType = 3
	  AND ac.NextQuestion = aq.QuestionCode 
OPEN Assess_cursor
FETCH NEXT FROM Assess_cursor INTO @Code 
SET @x = 0
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @x = @x + 1
	IF @x = 1 SET @Result = @Result + 'Choice Next Question Refer To Itselft ('
	SET @Result = @Result + CAST(@Code AS VARCHAR(10))
	FETCH NEXT FROM Assess_cursor INTO @Code 
	IF @@FETCH_STATUS = 0 SET @Result = @Result + ',' ELSE SET @Result = @Result + ')~~'
END
CLOSE Assess_cursor
DEALLOCATE Assess_cursor

--33_NextQuestion Questions must have a nextquestion
DECLARE Assess_cursor CURSOR STATIC FOR 
SELECT QuestionCode FROM AssessQuestion
WHERE AssessmentID = @AssessmentID AND NextType = 1 AND NextQuestion = 0
OPEN Assess_cursor
FETCH NEXT FROM Assess_cursor INTO @Code 
SET @x = 0
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @x = @x + 1
	IF @x = 1 SET @Result = @Result + 'Question Missing Next Question ('
	SET @Result = @Result + CAST(@Code AS VARCHAR(10))
	FETCH NEXT FROM Assess_cursor INTO @Code 
	IF @@FETCH_STATUS = 0 SET @Result = @Result + ',' ELSE SET @Result = @Result + ')~~'
END
CLOSE Assess_cursor
DEALLOCATE Assess_cursor

--36_Decision Questions must be one per page
DECLARE Assess_cursor CURSOR STATIC FOR 
SELECT aq.AssessmentID, am.ResultType, aq.Grp, COUNT(aq.AssessQuestionID) 
FROM AssessQuestion AS aq JOIN Assessment AS am ON aq.AssessmentID = am.AssessmentID 
GROUP BY aq.AssessmentID, am.ResultType, aq.Grp 
HAVING aq.AssessmentID = @AssessmentID AND am.ResultType = 3 AND COUNT(aq.AssessQuestionID) > 1
OPEN Assess_cursor
FETCH NEXT FROM Assess_cursor INTO @ID, @Type, @Code, @Cnt 
SET @x = 0
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @x = @x + 1
	IF @x = 1 SET @Result = @Result + 'More Than One Decision Tree Question Per Page ('
	SET @Result = @Result + CAST(@Code AS VARCHAR(10))
	FETCH NEXT FROM Assess_cursor INTO @ID, @Type, @Code, @Cnt 
	IF @@FETCH_STATUS = 0 SET @Result = @Result + ',' ELSE SET @Result = @Result + ')~~'
END
CLOSE Assess_cursor
DEALLOCATE Assess_cursor

--39_Decision Result Question must have a description
DECLARE Assess_cursor CURSOR STATIC FOR 
SELECT QuestionCode FROM AssessQuestion
WHERE AssessmentID = @AssessmentID AND QuestionType = 4 AND Description = ''
OPEN Assess_cursor
FETCH NEXT FROM Assess_cursor INTO @Code 
SET @x = 0
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @x = @x + 1
	IF @x = 1 SET @Result = @Result + 'Decision Tree Result Missing Description ('
	SET @Result = @Result + CAST(@Code AS VARCHAR(10))
	FETCH NEXT FROM Assess_cursor INTO @Code 
	IF @@FETCH_STATUS = 0 SET @Result = @Result + ',' ELSE SET @Result = @Result + ')~~'
END
CLOSE Assess_cursor
DEALLOCATE Assess_cursor

--42_Decision Questions must be type 3 or 4
DECLARE Assess_cursor CURSOR STATIC FOR 
SELECT aq.QuestionCode
FROM AssessQuestion AS aq JOIN Assessment AS am ON aq.AssessmentID = am.AssessmentID 
WHERE aq.AssessmentID = @AssessmentID AND am.ResultType = 3 AND aq.QuestionType!=3 AND aq.QuestionType!=4
OPEN Assess_cursor
FETCH NEXT FROM Assess_cursor INTO @Code 
SET @x = 0
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @x = @x + 1
	IF @x = 1 SET @Result = @Result + 'Decision Question Invalid Type ('
	SET @Result = @Result + CAST(@Code AS VARCHAR(10))
	FETCH NEXT FROM Assess_cursor INTO @Code 
	IF @@FETCH_STATUS = 0 SET @Result = @Result + ',' ELSE SET @Result = @Result + ')~~'
END
CLOSE Assess_cursor
DEALLOCATE Assess_cursor

--45_NonDecision Questions must not be type 4
DECLARE Assess_cursor CURSOR STATIC FOR 
SELECT aq.QuestionCode
FROM AssessQuestion AS aq JOIN Assessment AS am ON aq.AssessmentID = am.AssessmentID 
WHERE aq.AssessmentID = @AssessmentID AND am.ResultType != 3 AND  aq.QuestionType =4
OPEN Assess_cursor
FETCH NEXT FROM Assess_cursor INTO @Code 
SET @x = 0
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @x = @x + 1
	IF @x = 1 SET @Result = @Result + 'Non-Decision Question Invalid Type ('
	SET @Result = @Result + CAST(@Code AS VARCHAR(10))
	FETCH NEXT FROM Assess_cursor INTO @Code 
	IF @@FETCH_STATUS = 0 SET @Result = @Result + ',' ELSE SET @Result = @Result + ')~~'
END
CLOSE Assess_cursor
DEALLOCATE Assess_cursor

--48_Assessment FirstQuestionCode must be valid question
DECLARE Assess_cursor CURSOR STATIC FOR 
SELECT am.AssessmentID 
FROM Assessment AS am LEFT JOIN AssessQuestion AS aqq ON am.FirstQuestionCode = aqq.QuestionCode AND aqq.AssessmentID = @AssessmentID
WHERE am.AssessmentID = @AssessmentID AND am.FirstQuestionCode > 0 AND aqq.QuestionCode IS NULL 
OPEN Assess_cursor
FETCH NEXT FROM Assess_cursor INTO @Code 
SET @x = 0
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @x = @x + 1
	IF @x = 1 SET @Result = @Result + 'Invalid Assessment First Question # ('
	SET @Result = @Result + CAST(@Code AS VARCHAR(10))
	FETCH NEXT FROM Assess_cursor INTO @Code 
	IF @@FETCH_STATUS = 0 SET @Result = @Result + ',' ELSE SET @Result = @Result + ')~~'
END
CLOSE Assess_cursor
DEALLOCATE Assess_cursor

--51_Questions NextQuestion must be valid question
DECLARE Assess_cursor CURSOR STATIC FOR 
SELECT aq.QuestionCode 
FROM AssessQuestion AS aq LEFT JOIN AssessQuestion AS aqq ON aq.NextQuestion = aqq.QuestionCode AND aqq.AssessmentID = @AssessmentID
WHERE aq.AssessmentID = @AssessmentID AND aq.NextType = 1 AND aq.NextQuestion > 0 AND aqq.QuestionCode IS NULL 
OPEN Assess_cursor
FETCH NEXT FROM Assess_cursor INTO @Code 
SET @x = 0
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @x = @x + 1
	IF @x = 1 SET @Result = @Result + 'Invalid Question Next Question ('
	SET @Result = @Result + CAST(@Code AS VARCHAR(10))
	FETCH NEXT FROM Assess_cursor INTO @Code 
	IF @@FETCH_STATUS = 0 SET @Result = @Result + ',' ELSE SET @Result = @Result + ')~~'
END
CLOSE Assess_cursor
DEALLOCATE Assess_cursor

--54_Choices NextQuestion must be valid question
DECLARE Assess_cursor CURSOR STATIC FOR 
SELECT aq.QuestionCode 
FROM AssessQuestion AS aq 
JOIN AssessChoice AS ac ON ac.AssessQuestionID = aq.AssessQuestionID
LEFT JOIN AssessQuestion AS aqq ON ac.NextQuestion = aqq.QuestionCode AND aqq.AssessmentID = @AssessmentID
WHERE aq.AssessmentID = @AssessmentID AND ac.NextQuestion > 0 AND aqq.QuestionCode IS NULL 
OPEN Assess_cursor
FETCH NEXT FROM Assess_cursor INTO @Code 
SET @x = 0
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @x = @x + 1
	IF @x = 1 SET @Result = @Result + 'Invalid Choice Next Question ('
	SET @Result = @Result + CAST(@Code AS VARCHAR(10))
	FETCH NEXT FROM Assess_cursor INTO @Code 
	IF @@FETCH_STATUS = 0 SET @Result = @Result + ',' ELSE SET @Result = @Result + ')~~'
END
CLOSE Assess_cursor
DEALLOCATE Assess_cursor

GO