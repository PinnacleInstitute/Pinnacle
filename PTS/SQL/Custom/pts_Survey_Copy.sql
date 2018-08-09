EXEC [dbo].pts_CheckProc 'pts_Survey_Copy'
 GO

--Create a copy of the specified SurveyID for the specified OrgID
CREATE PROCEDURE [dbo].pts_Survey_Copy ( 
	@SurveyID int, 
	@OrgID int, 
	@UserID int,
	@Result int OUTPUT 
      )
AS

SET NOCOUNT ON
SET @Result = 0

DECLARE @NewSurveyID int, @SurveyName nvarchar (60), @Description nvarchar (500), @StartDate datetime, @EndDate datetime 

SELECT @SurveyName = ISNULL(SurveyName,''), @Description = Description, @StartDate = StartDate, @EndDate = EndDate 
FROM Survey WHERE SurveyID = @SurveyID

IF @SurveyName != ''
BEGIN
	SET @Result = 1
	EXEC pts_Survey_Add @NewSurveyID OUTPUT, @OrgID, @SurveyName, @Description, 0, @StartDate, @EndDate, @UserID  

	DECLARE	@SurveyQuestionID int, @NewSurveyQuestionID int, @Question nvarchar (1000), @Seq int, @IsText bit
	
	DECLARE SurveyQuestion_Cursor CURSOR LOCAL STATIC FOR 
	SELECT SurveyQuestionID, Question, Seq, IsText FROM SurveyQuestion WHERE SurveyID = @SurveyID
	
	OPEN SurveyQuestion_Cursor
	
	FETCH NEXT FROM SurveyQuestion_Cursor INTO @SurveyQuestionID, @Question, @Seq, @IsText 
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
--		SurveyQuestionID, SurveyID, Question, Seq, IsText, Total, Status, UserID
		EXEC pts_SurveyQuestion_Add @NewSurveyQuestionID OUTPUT, @NewSurveyID, @Question, @Seq, @IsText, 0, 1, @UserID
	
		DECLARE	@SurveyChoiceID int, @Choice nvarchar (500)

		DECLARE SurveyChoice_Cursor CURSOR FOR 
		SELECT Choice, Seq FROM SurveyChoice WHERE SurveyQuestionID = @SurveyQuestionID
	
		OPEN SurveyChoice_Cursor
	
		FETCH NEXT FROM SurveyChoice_Cursor INTO @Choice, @Seq
	
		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC pts_SurveyChoice_Add @SurveyChoiceID OUTPUT, @NewSurveyQuestionID, @Choice, @Seq, 0, @UserID
			FETCH NEXT FROM SurveyChoice_Cursor INTO @Choice, @Seq
		END
	
		CLOSE SurveyChoice_Cursor
		DEALLOCATE SurveyChoice_Cursor
		
		FETCH NEXT FROM SurveyQuestion_Cursor INTO @SurveyQuestionID, @Question, @Seq, @IsText 
	END
	
	CLOSE SurveyQuestion_Cursor
	DEALLOCATE SurveyQuestion_Cursor
END

GO
