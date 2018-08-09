EXEC [dbo].pts_CheckProc 'pts_Question_InitLabels'
 GO

CREATE PROCEDURE [dbo].pts_Question_InitLabels (
	@Count int OUTPUT
	)
AS

SET NOCOUNT ON

DECLARE @mCount int,
	@mEntityID int,
	@mAttributeID int,
	@mID int

-- Set the Entity ID
SET     @mEntityID = 17

-- Declare all the fields from the Question that we will need
DECLARE	@QuestionID int, @Question nvarchar(1000), @Answer nvarchar(2000)

-- Declare all the fields from the Label Languages that we will need
DECLARE	@LanguageCode nvarchar(5)

-- Setup a Cursor for All Weddings to Process
DECLARE Question_cursor CURSOR FOR 
SELECT 	pr.QuestionID, pr.Question, pr.Answer
FROM    Question AS pr (NOLOCK)

OPEN Question_cursor

FETCH NEXT FROM Question_cursor INTO @QuestionID, @Question, @Answer

SET @mID = 0
SET @mCount = 0

WHILE @@FETCH_STATUS = 0
BEGIN
--Process Question 
	SET @mAttributeID = 1705
	DECLARE Language_cursor CURSOR FOR 
	SELECT 	ll.LanguageCode
	FROM    LabLang AS ll (NOLOCK)
	
	OPEN Language_cursor
	FETCH NEXT FROM Language_cursor 
	INTO @LanguageCode

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @mID = 0
		SELECT @mID = LabelID
		FROM   Label 
		WHERE  EntityID = @mEntityID
		AND    LanguageCode = @LanguageCode
		AND    AttributeID = @mAttributeID
		AND    ItemID = @QuestionID

		IF @mID = 0 
		BEGIN
			EXEC pts_Label_Add @mID OUTPUT, @mEntityID, @mAttributeID, @QuestionID, @LanguageCode, @Question, 1
			SET @mCount = @mCount + 1
		END		

		FETCH NEXT FROM Language_cursor 
		INTO @LanguageCode
	END
	CLOSE Language_cursor
	DEALLOCATE Language_cursor

--Process Answer
	SET @mAttributeID = 1706
	DECLARE Language_cursor CURSOR FOR 
	SELECT 	ll.LanguageCode
	FROM    LabLang AS ll (NOLOCK)
	
	OPEN Language_cursor
	FETCH NEXT FROM Language_cursor 
	INTO @LanguageCode

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @mID = 0
		SELECT @mID = LabelID
		FROM   Label 
		WHERE  EntityID = @mEntityID
		AND    LanguageCode = @LanguageCode
		AND    AttributeID = @mAttributeID
		AND    ItemID = @QuestionID

		IF @mID = 0 
		BEGIN
			EXEC pts_Label_Add @mID OUTPUT, @mEntityID, @mAttributeID, @QuestionID, @LanguageCode, @Answer, 1
			SET @mCount = @mCount + 1
		END		

		FETCH NEXT FROM Language_cursor 
		INTO @LanguageCode
	END
	CLOSE Language_cursor
	DEALLOCATE Language_cursor

	FETCH NEXT FROM Question_cursor INTO @QuestionID, @Question, @Answer
END

CLOSE Question_cursor
DEALLOCATE Question_cursor

Set @Count = @mCount
GO

