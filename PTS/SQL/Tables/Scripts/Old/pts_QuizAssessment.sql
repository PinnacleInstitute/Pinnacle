DECLARE @LessonID int, @AssessmentID int

-- Set these to the QuizID to be copied from and the AssessmentID to be copied to
SET @LessonID = 2353  
SET @AssessmentID = 7

DECLARE @QuizQuestionID int, @Question nvarchar(1000), @Seq int, @Points int, @MediaType int, @MediaFile varchar (80)
DECLARE @Choice nvarchar (200)

DECLARE QuizQuestion_cursor CURSOR LOCAL STATIC FOR 
SELECT QuizQuestionID, Question, Seq, Points, MediaType, MediaFile
FROM QuizQuestion WHERE LessonID = @LessonID

OPEN QuizQuestion_cursor
FETCH NEXT FROM QuizQuestion_cursor INTO @QuizQuestionID, @Question, @Seq, @Points, @MediaType, @MediaFile

WHILE @@FETCH_STATUS = 0
BEGIN
	DECLARE @NewAssessQuestionID int
	INSERT INTO AssessQuestion ( AssessmentID, Question, Seq, Points, MediaType, MediaFile, Status, QuestionType )
		VALUES ( @AssessmentID, @Question, @Seq, @Points, @MediaType, @MediaFile, 1, 3 )
	SET @NewAssessQuestionID = @@IDENTITY

	DECLARE QuizChoice_cursor CURSOR LOCAL STATIC FOR 
	SELECT  QuizChoiceText, Seq
	FROM QuizChoice WHERE QuizQuestionID = @QuizQuestionID

	OPEN QuizChoice_cursor
	FETCH NEXT FROM QuizChoice_cursor INTO @Choice, @Seq
	WHILE @@FETCH_STATUS = 0
	BEGIN
		INSERT INTO AssessChoice ( AssessQuestionID, Choice, Seq )
			VALUES ( @NewAssessQuestionID, @Choice, @Seq )

		FETCH NEXT FROM QuizChoice_cursor INTO @Choice, @Seq
	END
	CLOSE QuizChoice_cursor
	DEALLOCATE QuizChoice_cursor

	FETCH NEXT FROM QuizQuestion_cursor INTO @QuizQuestionID, @Question, @Seq, @Points, @MediaType, @MediaFile
END
CLOSE QuizQuestion_cursor
DEALLOCATE QuizQuestion_cursor



GO