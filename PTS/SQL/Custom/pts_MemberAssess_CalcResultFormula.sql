EXEC [dbo].pts_CheckProc 'pts_MemberAssess_CalcResultFormula'
GO

CREATE PROCEDURE [dbo].pts_MemberAssess_CalcResultFormula
   @MemberAssessID int ,
   @Formula varchar(100) ,
   @Result nvarchar (1000) OUTPUT
AS

SET NOCOUNT ON

DECLARE @x int, @Token varchar(100), @Nam varchar(100), @Dat varchar(100), @Num varchar(10)
DECLARE @Groups varchar(100), @Codes varchar(100), @Total int
DECLARE @Percent int

SET @Result = ''

WHILE @Formula != ''
BEGIN

--	Get Each Token (name:Q1+Q2+G3)
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

--	Get Each Token Name (name:)
	SET @x = CHARINDEX(':', @Token)
	IF @x > 0
	BEGIN
		SET @Nam = SUBSTRING(@Token, 1, @x-1)
		SET @Dat = SUBSTRING(@Token, @x+1, LEN(@Token)-@x)
		SET @Groups = ''
		SET @Codes = ''
		SET @Total = 0
		SET @Percent = 0
--		Process the Question Codes and Groups (Q1+Q2+P3)

		WHILE @Dat != ''
		BEGIN
--			Get Each Question Code or Group (Q1+)

			SET @x = CHARINDEX('+', @Dat)
			IF @x > 0
			BEGIN
				SET @Num = SUBSTRING(@Dat, 1, @x-1)
				SET @Dat = SUBSTRING(@Dat, @x+1, LEN(@Dat)-@x)
			END
			ELSE
			BEGIN
				SET @Num = @Dat
				SET @Dat = ''
			END

			IF @Num != ''
			BEGIN
				IF LEFT(@Num,1) = 'P' SET @Groups = @Groups + '~' + SUBSTRING(@Num, 2, LEN(@Num)-1)
				ELSE IF LEFT(@Num,1) = 'Q' SET @Codes = @Codes + '~' + SUBSTRING(@Num, 2, LEN(@Num)-1)
				ELSE IF LEFT(@Num,1) = '%' SET @Percent = CAST(SUBSTRING(@Num, 2, LEN(@Num)-1) AS INT)
				ELSE SET @Codes = @Codes + '~' + @Num
			END
		END
		IF @Groups != ''
			SET @Groups = @Groups + '~'
		IF @Codes != ''
			SET @Codes = @Codes + '~'

--		Get SUM of specified Question Groups and Codes
		IF @Groups != '' AND @Codes != ''
		BEGIN
			SELECT @Total = SUM(aa.answer) + SUM(ISNULL(ac.points,0)) FROM AssessAnswer AS aa
			LEFT JOIN AssessQuestion AS aq ON aa.AssessQuestionID = aq.AssessQuestionID
			LEFT JOIN AssessChoice AS ac ON aa.AssessChoiceID = ac.AssessChoiceID
			WHERE MemberAssessID = @MemberAssessID
			AND ( @Groups LIKE '%~' + CAST(grp AS VARCHAR(5)) + '~%' 
			OR    @Codes LIKE '%~' + CAST(questioncode AS VARCHAR(5)) + '~%' )
		END
		ELSE IF @Groups != ''
		BEGIN
			SELECT @Total = SUM(aa.answer) + SUM(ISNULL(ac.points,0)) FROM AssessAnswer AS aa
			LEFT JOIN AssessQuestion AS aq ON aa.AssessQuestionID = aq.AssessQuestionID
			LEFT JOIN AssessChoice AS ac ON aa.AssessChoiceID = ac.AssessChoiceID
			WHERE MemberAssessID = @MemberAssessID
			AND @Groups LIKE '%~' + CAST(grp AS VARCHAR(5)) + '~%' 
		END
		ELSE IF @Codes != ''
		BEGIN
			SELECT @Total = SUM(aa.answer) + SUM(ISNULL(ac.points,0)) FROM AssessAnswer AS aa
			LEFT JOIN AssessQuestion AS aq ON aa.AssessQuestionID = aq.AssessQuestionID
			LEFT JOIN AssessChoice AS ac ON aa.AssessChoiceID = ac.AssessChoiceID
			WHERE MemberAssessID = @MemberAssessID
			AND @Codes LIKE '%~' + CAST(questioncode AS VARCHAR(5)) + '~%' 
		END

--		Build the Result String
		IF @Total IS NULL SET @Total = 0
		IF @Result != '' SET @Result = @Result + '; '
		IF @Percent > 0 SET @Total = @Total / (CAST(@Percent AS FLOAT)/100)
		SET @Result = @Result + @Nam + '=' + CAST(@Total as varchar(10))
	END
END

GO