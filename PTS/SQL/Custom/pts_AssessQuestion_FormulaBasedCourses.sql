EXEC [dbo].pts_CheckProc 'pts_AssessQuestion_FormulaBasedCourses'
GO

--DECLARE @Courses varchar (50) EXEC pts_AssessQuestion_FormulaBasedCourses '1,2;<3:1,2,4,6,7,8,10;else:11',5, @Courses OUTPUT PRINT 'Courses ' + @Courses


CREATE PROCEDURE pts_AssessQuestion_FormulaBasedCourses
	@Formula varchar(50),
	@AssessAnswer int,
	@Courses varchar(100) OUTPUT
AS
SET NOCOUNT ON


DECLARE @x int, @Position int, @Token varchar(50),@Operator varchar(10), @Value int,
	 @Course varchar(100), @isSet int

SET @Courses = ''
SET @isSet = 0

SET @x = CHARINDEX(':',@Formula)
IF @x = 0
BEGIN
	SET @Courses = @Formula 
	SET @Formula = ''	
END

WHILE @Formula != ''
BEGIN
--  -- Get Each Token ( ex. (=,<,>,else)a:1,2,3)	
    SET @x = CHARINDEX(';',@Formula)
    IF @x > 0
    BEGIN
        SET @Token = SUBSTRING(@Formula,1,@x-1)
		SET @Formula = SUBSTRING(@Formula, @x+1, LEN(@Formula) - @x)
    END
    ELSE
    BEGIN
		SET @Token = @Formula
		SET @Formula = ''
    END
--  -- GET (Operator and number:) and get courses base on comparison			
    SET @x = CHARINDEX(':', @Token)
    IF @x = 0  SET @Courses = @Courses + ' ' + @Token
   
	IF @x > 0
    BEGIN
--      -- Get the ELSE operator
		IF LEFT(@Token ,4) = 'else'
	   	    SET @Operator = LEFT(@Token ,4)
		ELSE
		BEGIN
	   	    SET @Operator = LEFT(@Token ,1)
		    SET @Value = CAST( SUBSTRING(@Token ,2, @x-2) AS int )
		END
		SET @Course = SUBSTRING(@Token ,@x+1,LEN(@Token)-@x)
			
--		-- Compare the rank or priority answer with the right operand value. Then get courses
		IF @Operator = '<'
		BEGIN
		    IF @AssessAnswer < @Value 
			BEGIN 	
				SET @Courses = @Courses + ' ' + @Course 
				SET @isSet = 1
			END
		END	
		ELSE IF @Operator = '>'
		BEGIN
		    IF @AssessAnswer > @Value 
			BEGIN
				SET @Courses = @Courses + ' ' + @Course
				SET @isSet = 1
			END
		END	
		ELSE IF @Operator = '='
		BEGIN
		    IF @AssessAnswer = @Value 
			BEGIN
				SET @Courses = @Courses + ' ' + @Course
				SET @isSet = 1
			END
		END	
		ELSE IF @Operator = 'else'
		BEGIN
		    IF @isSet = 0
			BEGIN
				 SET @Courses = @Courses + ' ' + @Course
			END
		END	
	END
END	

