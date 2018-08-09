EXEC [dbo].pts_CheckProc 'pts_MemberAssess_CalcMaster'
GO

--DECLARE @Courses varchar (50) EXEC pts_MemberAssess_GetCourses 53, @Courses OUTPUT PRINT @Courses

CREATE PROCEDURE [dbo].pts_MemberAssess_CalcMaster
   @MemberAssessID int ,
   @Status int OUTPUT
AS

SET NOCOUNT ON

DECLARE @AssessmentID int, @MemberID int, @Assessments varchar(50), @AssessmentType int
SELECT @AssessmentID = AssessmentID, @MemberID = MemberID FROM MemberAssess WHERE MemberAssessID = @MemberAssessID
SELECT @Assessments = Assessments, @AssessmentType = AssessmentType FROM Assessment WHERE AssessmentID = @AssessmentID

SET @Status = 0

IF @AssessmentType = 3
BEGIN
	DECLARE @AssessIDs varchar (50), @cnt int, @Result nvarchar(100)
	DECLARE @x int, @ID int, @xspace int

	SET @Result = ''	
	SET @AssessIDs = @Assessments
	WHILE @AssessIDs != ''
	BEGIN
		SET @x = CHARINDEX(',', @AssessIDs)
		SET @xspace = CHARINDEX(' ', @AssessIDs)
--		Found comma and space, use the first one found	
		IF @x > 0 AND @xspace > 0 IF @xspace < @x SET @x = @xspace
--		Found space only, use the space
		IF @x = 0 AND @xspace > 0 SET @x = @xspace
--		Found comma only, use the comma
	
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

		IF @ID > 0 
		BEGIN
			SET @cnt = 0
			SELECT @cnt = COUNT(*) FROM MemberAssess 
			WHERE MemberID = @MemberID AND AssessmentID = @ID AND Status = 1
			IF @cnt = 0
			BEGIN
				IF @Result != '' SET @Result = @Result + ', '
				SET @Result = @Result + CAST(@ID AS VARCHAR(10))
			END			
		END
	END 
	
	IF @Result = ''
		SET @Status = 1
	ELSE
		SET @Status = 2

	UPDATE MemberAssess SET Status = @Status, Result = @Result WHERE MemberAssessID = @MemberAssessID
END
	
GO