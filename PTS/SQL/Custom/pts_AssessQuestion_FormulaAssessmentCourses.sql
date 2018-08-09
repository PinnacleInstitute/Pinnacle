EXEC [dbo].pts_CheckProc 'pts_AssessQuestion_FormulaAssessmentCourses'
GO

--DECLARE @Courses varchar (50) EXEC pts_AssessQuestion_FormulaAssessmentCourses 'A[>8:1,2,4,6,7,8,10]C[12;<50:33]', 'A=20;C=30',  @Courses OUTPUT 
--PRINT 'Courses ' + @Courses

CREATE PROCEDURE pts_AssessQuestion_FormulaAssessmentCourses
	@Formula nvarchar(50),
	@Result nvarchar (1000),
	@Courses varchar(100) OUTPUT
AS
SET NOCOUNT ON

DECLARE @x int, @Token varchar(50),@Label varchar(10), @valuecourses varchar(50), @StartToken varchar(50), 
       @Score int, @openbracket int, @closebracket int, @Course varchar(100)

SET @Courses = ''

-- Single Result
SET @x = CHARINDEX('=',@Result)
IF @x = 0
BEGIN
	SET @x = CHARINDEX(':',@Formula)
	IF @x > 0
	BEGIN
		SET @Score = CAST( @Result AS int)
		EXEC pts_AssessQuestion_FormulaBasedCourses @Formula, @Score, @Course OUTPUT
		SET @Courses = @Course 
	END
	ELSE
	BEGIN
		SET @Courses = @Formula 
	END
	SET @Formula = ''	
END


--- Multiple results
WHILE @Formula != ''
BEGIN
--  -- Get Each Token ( ex. C>a:1,2,3)	
    SET @openbracket = CHARINDEX('[',@Formula)
    SET @closebracket = CHARINDEX(']',@Formula)

    IF @openbracket > 0 AND @closebracket > 0
    BEGIN
        SET @Token = SUBSTRING(@Formula,1,@closebracket-1)
		SET @Formula = SUBSTRING(@Formula, @closebracket+1, LEN(@Formula) - @closebracket)
    END
    ELSE
    BEGIN
		SET @Formula = ''
    END

--  Get the label, and valuecourses
    SET @Label = SUBSTRING(@Token,1,@openbracket-1) + CAST('=' AS varchar(1))
	SET @valuecourses = SUBSTRING(@Token,@openbracket+1,LEN(@Token)-@openbracket)
--  Search the label ins assessment result	
	SET @x = CHARINDEX(@Label,@Result)
 	IF @x > 0
	BEGIN
		SET @StartToken = SUBSTRING(@Result,@x,(LEN(@Result)+ 1) -@x)
		SET @x = CHARINDEX(';',@StartToken)
		IF @x > 0
		BEGIN			
			SET @x = @x-1 
			SET @Score = SUBSTRING(@StartToken,LEN(@Label) + 1,@x-LEN(@Label))
		END
		ELSE
			SET @Score = SUBSTRING(@StartToken,LEN(@Label) + 1,LEN(@StartToken)-LEN(@Label) )
	
		 EXEC pts_AssessQuestion_FormulaBasedCourses @valuecourses, @Score, @Course OUTPUT
		 SET @Courses = @Courses + ' ' + @Course 	
	END    
END	

