EXEC [dbo].pts_CheckProc 'pts_AssessQuestion_ListQuestionText'
GO

CREATE PROCEDURE [dbo].pts_AssessQuestion_ListQuestionText
   @Courses varchar(50) 
AS

SET NOCOUNT ON

DECLARE @QIDs varchar (80), @QID1 int, @QID2 int, @QID3 int, @QID4 int, @QID5 int 
DECLARE @QID6 int, @QID7 int, @QID8 int, @QID9 int, @QID10 int 
DECLARE @x int, @cnt int, @ID int, @xspace int

SET @QIDs = @Courses
SET @QID1 = 0
SET @QID2 = 0
SET @QID3 = 0
SET @QID4 = 0
SET @QID5 = 0
SET @QID6 = 0
SET @QID7 = 0
SET @QID8 = 0
SET @QID9 = 0
SET @QID10 = 0

SET @cnt = 0
WHILE @QIDs != ''
BEGIN
	SET @cnt = @cnt + 1
	SET @x = CHARINDEX(',', @QIDs)
	SET @xspace = CHARINDEX(' ', @QIDs)
--	Found comma and space, use the first one found	
	IF @x > 0 AND @xspace > 0 IF @xspace < @x SET @x = @xspace
--	Found space only, use the space
	IF @x = 0 AND @xspace > 0 SET @x = @xspace
--	Found comma only, use the comma
	
	IF @x > 0
	BEGIN
		SET @ID = CAST(SUBSTRING(@QIDs, 1, @x-1) AS int)
		SET @QIDs = SUBSTRING(@QIDs, @x+1, LEN(@QIDs)-@x)
	END
	ELSE
	BEGIN
		SET @ID = CAST(@QIDs AS int)
		SET @QIDs = ''
	END
	IF @cnt = 1 SET @QID1 = @ID
	IF @cnt = 2 SET @QID2 = @ID
	IF @cnt = 3 SET @QID3 = @ID
	IF @cnt = 4 SET @QID4 = @ID
	IF @cnt = 5 SET @QID5 = @ID
	IF @cnt = 6 SET @QID6 = @ID
	IF @cnt = 7 SET @QID7 = @ID
	IF @cnt = 8 SET @QID8 = @ID
	IF @cnt = 9 SET @QID9 = @ID
	IF @cnt = 10 SET @QID10 = @ID
END 

SELECT   AssessQuestionID, 
         AssessmentID, 
         Question, 
         Description, 
         QuestionCode, 
         Grp, 
         Seq, 
         QuestionType, 
         MultiSelect, 
         NextQuestion, 
         RankMin, 
         RankMax, 
         NextType, 
         CustomCode, 
         MediaType, 
         MediaFile, 
         Courses
FROM AssessQuestion (NOLOCK)
WHERE AssessQuestionID IN (@QID1, @QID2, @QID3, @QID4, @QID5, @QID6, @QID7, @QID8, @QID9, @QID10)
ORDER BY Grp, Seq

GO