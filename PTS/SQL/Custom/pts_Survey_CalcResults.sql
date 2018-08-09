EXEC [dbo].pts_CheckProc 'pts_Survey_CalcResults'
 GO

--Calculate all bonuses and overrides for this sales order
CREATE PROCEDURE [dbo].pts_Survey_CalcResults ( 
	@SurveyID int, 
	@Results int OUTPUT 
      )
AS

SET NOCOUNT ON

DECLARE	@total int, @SurveyQuestionID int

-- Count the number of surveys taken
SELECT @Results = COUNT(DISTINCT MemberID) 
FROM SurveyAnswer AS sa JOIN SurveyQuestion AS sq ON sa.SurveyQuestionID = sq.SurveyQuestionID
WHERE sq.SurveyID = @SurveyID

DECLARE SurveyQuestion_Cursor CURSOR LOCAL STATIC FOR 
SELECT SurveyQuestionID FROM SurveyQuestion WHERE SurveyID = @SurveyID

OPEN SurveyQuestion_Cursor

FETCH NEXT FROM SurveyQuestion_Cursor INTO @SurveyQuestionID

WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT @total = COUNT(*) FROM SurveyAnswer WHERE SurveyQuestionID = @SurveyQuestionID AND SurveyChoiceID > 0
	Update SurveyQuestion Set Total = @total Where SurveyQuestionID = @SurveyQuestionID

	DECLARE	@SurveyChoiceID int

	DECLARE SurveyChoice_Cursor CURSOR FOR 
	SELECT SurveyChoiceID FROM SurveyChoice WHERE SurveyQuestionID = @SurveyQuestionID

	OPEN SurveyChoice_Cursor

	FETCH NEXT FROM SurveyChoice_Cursor INTO @SurveyChoiceID

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @total = COUNT(*) FROM SurveyAnswer WHERE SurveyChoiceID = @SurveyChoiceID
		Update SurveyChoice Set Total = @total Where SurveyChoiceID = @SurveyChoiceID
		
		FETCH NEXT FROM SurveyChoice_Cursor INTO @SurveyChoiceID
	END

	CLOSE SurveyChoice_Cursor
	DEALLOCATE SurveyChoice_Cursor
	
	FETCH NEXT FROM SurveyQuestion_Cursor INTO @SurveyQuestionID
END

CLOSE SurveyQuestion_Cursor
DEALLOCATE SurveyQuestion_Cursor

GO
