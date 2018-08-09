EXEC [dbo].pts_CheckProc 'pts_MemberAssess_GetCourses'
GO

--DECLARE @Courses varchar (50) EXEC pts_MemberAssess_GetCourses 53, @Courses OUTPUT PRINT @Courses

CREATE PROCEDURE [dbo].pts_MemberAssess_GetCourses
   @MemberAssessID int ,
   @Courses varchar (100) OUTPUT
AS

SET NOCOUNT ON

DECLARE @AssessmentID int, @Result nvarchar (1000), @tmpCourses varchar(100), @AssessAnswer int
DECLARE @ResultType int, @AssessCourses varchar (50), @x int, @ID int

SET @Courses = ''

SELECT @AssessmentID = AssessmentID,  @Result = Result FROM MemberAssess WHERE MemberAssessID = @MemberAssessID
SELECT @ResultType = ResultType, @AssessCourses = Courses FROM Assessment WHERE AssessmentID = @AssessmentID

-- get course list from assessment
SET @x = CHARINDEX (':', @AssessCourses)
--	-- Accumulate courses from formula
IF @x > 0
BEGIN
    EXEC pts_AssessQuestion_FormulaAssessmentCourses @AssessCourses, @Result, @tmpCourses OUTPUT
    IF @tmpCourses != '' SET @Courses = @Courses + ' ' + @tmpCourses 	
END
---	-- Accumulate courses from non-formula
ELSE
    SET @Courses = @AssessCourses 	

--Process Decision Tree Assessments
IF @ResultType = 3
BEGIN
--	-- get question #s from the result 
	SET @x = CHARINDEX(';', @Result)
	IF @x > 0 SET @Result = SUBSTRING(@Result, 1, @x-1)

--	-- process each QuestionID from the result
	WHILE @Result != ''
	BEGIN
		SET @x = CHARINDEX(',', @Result)
		IF @x = 0 SET @x = CHARINDEX(' ', @Result)
		IF @x > 0
		BEGIN
			SET @ID = CAST(SUBSTRING(@Result, 1, @x-1) AS int)
			SET @Result = SUBSTRING(@Result, @x+1, LEN(@Result)-@x)
		END
		ELSE
		BEGIN
			SET @ID = CAST(@Result AS int)
			SET @Result = ''
		END

		IF @ID > 0
		BEGIN 
			SELECT @AssessCourses = Courses FROM AssessQuestion WHERE AssessQuestionID = @ID
			IF @AssessCourses != ''
			BEGIN
				IF @Courses != ''
					SET @Courses = @AssessCourses + ',' + @Courses
				ELSE
					SET @Courses = @AssessCourses
			END
		END
	END
END
-- ResultType not equal to 3
ELSE
BEGIN
--  -- Loop all answered questions   
    DECLARE AssessAnswer_cursor CURSOR STATIC FOR
    SELECT aq.Courses,aa.Answer FROM AssessAnswer AS aa
    JOIN AssessQuestion AS aq ON aa.AssessQuestionID = aq.AssessQuestionID
    WHERE (aa.MemberAssessID = @MemberAssessID) AND (aq.Courses != '') 
	
    OPEN AssessAnswer_cursor
    FETCH NEXT FROM AssessAnswer_cursor INTO @AssessCourses, @AssessAnswer
    SET @x = 0
    WHILE @@FETCH_STATUS = 0
    BEGIN
	SET @x = CHARINDEX (':', @AssessCourses)
--	-- Accumulate courses from formula
	IF @x > 0
	BEGIN
	    EXEC pts_AssessQuestion_FormulaBasedCourses @AssessCourses, @AssessAnswer, @tmpCourses OUTPUT
	    IF @tmpCourses != '' SET @Courses = @Courses + ' ' + @tmpCourses 	
	END
---	-- Accumulate courses from non-formula
	ELSE
	    SET @Courses = @Courses + ' ' + @AssessCourses 	
   
         FETCH NEXT FROM AssessAnswer_cursor INTO @AssessCourses, @AssessAnswer
    END
    CLOSE AssessAnswer_cursor
    DEALLOCATE AssessAnswer_cursor

--  -- Loop all assesschoices 
    DECLARE AssessChoice_cursor CURSOR STATIC FOR
    SELECT ac.Courses FROM AssessAnswer AS aa
    JOIN AssessChoice AS ac ON aa.AssessChoiceID = ac.AssessChoiceID
    WHERE (aa.MemberAssessID = @MemberAssessID) AND (ac.Courses != '') 
	
    OPEN AssessChoice_cursor
    FETCH NEXT FROM AssessChoice_cursor INTO @AssessCourses
    SET @x = 0
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @Courses = @Courses + ' ' + @AssessCourses 	
	FETCH NEXT FROM AssessChoice_cursor INTO @AssessCourses
   END
   CLOSE AssessChoice_cursor
   DEALLOCATE AssessChoice_cursor

END


GO