EXEC [dbo].pts_CheckProc 'pts_Assessment_CheckCourseFormula'
GO

CREATE PROCEDURE [dbo].pts_Assessment_CheckCourseFormula
 		@Formula varchar(50),
		@isError int OUTPUT
AS

SET         NOCOUNT ON

DECLARE @Token varchar(50), @x int
DECLARE @Operator varchar(10), @Value varchar(10)

SET @x = 0
SET @isError = 0

WHILE @Formula != ''
BEGIN
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
    SET @x = CHARINDEX(':', @Token)
	
   	IF @x > 0
    BEGIN
		IF LEFT(@Token ,4) = 'else' SET @Operator = LEFT(@Token ,4)
		ELSE 
		BEGIN
			SET @Operator = LEFT(@Token ,1)
--				Check if there is a value between > and :
			IF (@x-2) < 1 SET @isError = 1 
			ELSE SET @Value =  SUBSTRING(@Token ,2, @x-2)
--				Check if a value between > and : is numeric
			IF ISNUMERIC(@Value)= 0 SET @isError = 1 
		END

		IF @Operator = '<' AND @isError != 1 BEGIN SET @isError = 0 END
		ELSE IF @Operator = '>' AND @isError != 1 BEGIN  SET @isError = 0 END
		ELSE IF @Operator = '=' AND @isError != 1 BEGIN SET @isError = 0 END
		ELSE IF @Operator = 'else' AND @isError != 1 BEGIN SET @isError = 0 END
		ELSE BEGIN SET @isError = 1 END
	END
END	
GO	


