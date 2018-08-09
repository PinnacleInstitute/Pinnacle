EXEC [dbo].pts_CheckProc 'pts_AssessQuestion_SumResultFormula'
GO

CREATE PROCEDURE [dbo].pts_AssessQuestion_SumResultFormula
   @AssessmentID int,
   @MemberAssessID int ,
   @Grp int , 
   @Formula varchar(100) ,
   @NextQuestion  int OUTPUT
AS

SET NOCOUNT ON

DECLARE @x int,@Position int, @isValueNumber int,@isQuestionNumber int, @Token varchar(100), @Operator varchar(10)
DECLARE @Sum int

SET @NextQuestion = 0

SELECT @Sum = SUM(aa.answer) + SUM(ISNULL(ac.points,0)) FROM AssessAnswer AS aa
LEFT JOIN AssessQuestion AS aq ON aa.AssessQuestionID = aq.AssessQuestionID
LEFT JOIN AssessChoice AS ac ON aa.AssessChoiceID = ac.AssessChoiceID
WHERE (MemberAssessID = @MemberAssessID) and (aq.Grp = @Grp)

WHILE @Formula != ''
BEGIN
--	Get Each Token ((=,<,>,else)a:b)
	SET @x = CHARINDEX(';', @Formula)
	IF @x > 0
	BEGIN
		SET @Token = SUBSTRING(@Formula, 1, @x-1)
		SET @Formula = SUBSTRING(@Formula, @x+1, LEN(@Formula)-@x)
	END
	ELSE
	BEGIN
		SET @Token = @Formula
		SET @Formula = ''
	END
--	Get Each Token Name (operator and number:)
	SET @x = CHARINDEX(':', @Token)
	IF @x > 0
	BEGIN
--		Get the operator 		
		SET @Operator = SUBSTRING(LOWER(@Token), 1,1)
		IF  @Operator = 'e'
	        BEGIN
		    SET @Position = CHARINDEX('else',@Token)
		    IF @Position > 0
			SET @Operator = 'else'
 		END
	   	
--		Validate if Value and NextQuestion are numbers
		SET @isValueNumber = ISNUMERIC( SUBSTRING(@Token, 2,@x-2))
		SET @isQuestionNumber = ISNUMERIC( SUBSTRING(@Token, @x+1,LEN(@Token)-@x))

--		Compare sum and value. Then get the next question		
		IF  @Operator = '<' 
		BEGIN
			IF @isValueNumber > 0 and @isQuestionNumber > 0
			BEGIN  
			      IF @Sum < CAST( SUBSTRING(@Token, 2,@x-2)as int )
				SET @NextQuestion = CAST (SUBSTRING(@Token, @x+1, LEN(@Token)-@x)as int)
			END
		END 
		ELSE IF @Operator = '>'
		BEGIN
			IF @isValueNumber > 0 and @isQuestionNumber > 0
			BEGIN
			   IF @Sum > CAST( SUBSTRING(@Token, 2,@x-2)as int )
				SET @NextQuestion = CAST (SUBSTRING(@Token, @x+1, LEN(@Token)-@x)as int)
			END
		END		    
		ELSE IF @Operator = '=' 
		BEGIN		
			IF @isValueNumber > 0 and @isQuestionNumber > 0
			BEGIN
			   IF @Sum = CAST( SUBSTRING(@Token, 2,@x-2)as int )
				SET @NextQuestion = CAST (SUBSTRING(@Token, @x+1, LEN(@Token)-@x)as int)
			END	
	   	END
 		ELSE IF @Operator = 'else' 
      		BEGIN
			IF @NextQuestion = 0 
			BEGIN
			  IF @isQuestionNumber > 0
			     SET @NextQuestion = CAST ( SUBSTRING(@Token, @x+1, LEN(@Token)-@x)as int)
			     BREAK
			END
		END 
		ELSE
		BEGIN   	
         		SET @NextQuestion = 0
        		BREAK
--END OF IF/ELSE		
		END 
--END OF TOKEN	
	END 	
--END OF FORUMLA	
END 

--GET NEXT QUESTION ID
SET     @NextQuestion = ISNULL((SELECT AssessQuestionID
	FROM  AssessQuestion
	WHERE  (AssessmentID = @AssessmentID)  and (QuestionCode = @NextQuestion)),0)

GO