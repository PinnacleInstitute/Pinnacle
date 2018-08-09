EXEC [dbo].pts_CheckProc 'pts_Assessment_ListAssessmentText'
GO

--EXEC pts_Assessment_ListAssessmentText '1,2'

CREATE PROCEDURE [dbo].pts_Assessment_ListAssessmentText
   @Assessments varchar (50)
AS

SET NOCOUNT ON

DECLARE @AssessIDs varchar (50), @AssessID1 int, @AssessID2 int, @AssessID3 int, @AssessID4 int, @AssessID5 int 
DECLARE @AssessID6 int, @AssessID7 int, @AssessID8 int, @AssessID9 int, @AssessID10 int 
DECLARE @x int, @cnt int, @ID int, @xspace int

SET @AssessIDs = @Assessments
SET @AssessID1 = 0
SET @AssessID2 = 0
SET @AssessID3 = 0
SET @AssessID4 = 0
SET @AssessID5 = 0
SET @AssessID6 = 0
SET @AssessID7 = 0
SET @AssessID8 = 0
SET @AssessID9 = 0
SET @AssessID10 = 0

SET @cnt = 0
WHILE @AssessIDs != ''
BEGIN
	SET @cnt = @cnt + 1
	SET @x = CHARINDEX(',', @AssessIDs)
	SET @xspace = CHARINDEX(' ', @AssessIDs)
--	Found comma and space, use the first one found	
	IF @x > 0 AND @xspace > 0 IF @xspace < @x SET @x = @xspace
--	Found space only, use the space
	IF @x = 0 AND @xspace > 0 SET @x = @xspace
--	Found comma only, use the comma

	IF @x > 0
	BEGIN
		SET @ID = CAST(SUBSTRING(@AssessIDs, 1, @x-1) AS int)
		SET @AssessIDs = SUBSTRING(@AssessIDs, @x+1, LEN(@AssessIDs)-@x)
	END
	ELSE
	BEGIN
		SET @ID = CAST(@AssessIDs AS int)
		SET @AssessIDs = ''
	END
	IF @cnt = 1 SET @AssessID1 = @ID
	IF @cnt = 2 SET @AssessID2 = @ID
	IF @cnt = 3 SET @AssessID3 = @ID
	IF @cnt = 4 SET @AssessID4 = @ID
	IF @cnt = 5 SET @AssessID5 = @ID
	IF @cnt = 6 SET @AssessID6 = @ID
	IF @cnt = 7 SET @AssessID7 = @ID
	IF @cnt = 8 SET @AssessID8 = @ID
	IF @cnt = 9 SET @AssessID9 = @ID
	IF @cnt = 10 SET @AssessID10 = @ID
END 

SELECT AssessmentID, 
       AssessmentName, 
       AssessmentType, 
       Description, 
       AssessDate, 
       CompanyID, 
       Takes, 
       Delay, 
       IsCertify
FROM Assessment (NOLOCK)
WHERE (Status = 2)
AND AssessmentID IN (@AssessID1, @AssessID2, @AssessID3, @AssessID4, @AssessID5, @AssessID6, @AssessID7, @AssessID8, @AssessID9, @AssessID10)

GO