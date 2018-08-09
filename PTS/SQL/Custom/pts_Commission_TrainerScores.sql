EXEC [dbo].pts_CheckProc 'pts_Commission_TrainerScores'
GO

--TEST---------------------------------------------------------
--DECLARE @Count int 
--EXEC pts_Commission_TrainerScores @Count OUTPUT
--PRINT CAST(@Count AS VARCHAR)

CREATE PROCEDURE [dbo].pts_Commission_TrainerScores
   @Count int OUTPUT
AS

SET NOCOUNT ON

DECLARE @SessionID int, 
	@MemberAssessID int, 
	@Rating int, 
	@CourseRating int, 
	@Type float, 
	@Level float, 
	@Apply float, 
	@Recommend1 bit, 
	@Recommend2 bit, 
	@Recommend3 bit, 
	@ScoreFactor float, 
	@TypeLevelWeight float, 
	@ApplyRecWeight float, 
	@Score int,
	@Now datetime

SET @Now = GETDATE()
SET @Count = 0

--Constants
DECLARE @TYPE_PERSONAL float,
	@TYPE_ACADEMIC float,
	@TYPE_PROFESSIONAL float,
	@TYPE_TECHNICAL float,
	@LEVEL_BEGINNER float,
	@LEVEL_INTERMEDIATE float,
	@LEVEL_ADVANCED float,
	@LEVEL_EXPERT float,
	@APPLY_48HR int,
	@APPLY_WEEK int,
	@APPLY_MONTH int,
	@APPLY_NONE int,
	@REC_PEER int,
	@REC_SUB int,
	@REC_SUP int

SET @TYPE_PERSONAL = 1.0
SET @TYPE_ACADEMIC = 1.25
SET @TYPE_PROFESSIONAL = 1.5
SET @TYPE_TECHNICAL = 2.0
SET @LEVEL_BEGINNER = 1.0
SET @LEVEL_INTERMEDIATE = 1.5
SET @LEVEL_ADVANCED = 2.0
SET @LEVEL_EXPERT = 4.0
SET @APPLY_48HR = 6
SET @APPLY_WEEK = 4
SET @APPLY_MONTH = 2
SET @APPLY_NONE = 0
SET @REC_PEER = 2
SET @REC_SUB = 2
SET @REC_SUP = 2


--**********************************************************************************************************
--Process all complete sessions without a trainer score
DECLARE Session_cursor CURSOR LOCAL STATIC FOR 
SELECT 	se.SessionID, 
	se.TotalRating, 
	co.Rating, 
	CASE co.CourseType
		WHEN 1 THEN @TYPE_PERSONAL
		WHEN 2 THEN @TYPE_ACADEMIC
		WHEN 3 THEN @TYPE_PROFESSIONAL
		WHEN 4 THEN @TYPE_TECHNICAL
		ELSE 1
	END,
	CASE co.CourseLevel
		WHEN 1 THEN @LEVEL_BEGINNER
		WHEN 2 THEN @LEVEL_INTERMEDIATE
		WHEN 3 THEN @LEVEL_ADVANCED
		WHEN 4 THEN @LEVEL_EXPERT
		ELSE 1
	END,
	CASE se.Apply
		WHEN 1 THEN @APPLY_48HR
		WHEN 2 THEN @APPLY_WEEK
		WHEN 3 THEN @APPLY_MONTH
		WHEN 4 THEN @APPLY_NONE
		ELSE 0
	END,
	se.Recommend1,
	se.Recommend2,
	se.Recommend3,
	co.ScoreFactor
FROM Session AS se 
JOIN Course AS co ON se.CourseID = co.CourseID
WHERE co.CompanyID = 0 
AND co.IsPaid = 1 
AND se.TrainerScore = 0 
AND se.CompleteDate != 0  
AND se.CommStatus < 2

OPEN Session_cursor
FETCH NEXT FROM Session_cursor INTO @SessionID, @Rating, @CourseRating, @Type, @Level, @Apply, @Recommend1, @Recommend2, @Recommend3, @ScoreFactor

WHILE @@FETCH_STATUS = 0
BEGIN
	IF @Rating = 0 SET @Rating = @CourseRating
	IF @Rating = 0 SET @Rating = 6
	IF @ScoreFactor = 0 SET @ScoreFactor = 1

--	calculate the course type weight
	SET @TypeLevelWeight = @Type * @Level
--PRINT 'Type Level Weight:' + CAST(@TypeLevelWeight AS VARCHAR)

--	calculate the apply / recommend
	SET @ApplyRecWeight = @Apply
	IF @Recommend1 = 1 SET @ApplyRecWeight = @ApplyRecWeight + @REC_PEER
	IF @Recommend2 = 1 SET @ApplyRecWeight = @ApplyRecWeight + @REC_SUB
	IF @Recommend3 = 1 SET @ApplyRecWeight = @ApplyRecWeight + @REC_SUP
	IF @ApplyRecWeight = 0 SET @ApplyRecWeight = 1

--PRINT 'Apply Recommend Weight:' + CAST(@ApplyRecWeight AS VARCHAR) 

-- 	Calculate the Trainer Score for this class ---------------------------------------------
	SET @Score = @TypeLevelWeight * @ApplyRecWeight * @Rating * @ScoreFactor

--PRINT CAST(@Score AS VARCHAR) + ', ' + CAST(@TypeLevelWeight AS VARCHAR) + ', ' + CAST(@ApplyRecWeight AS VARCHAR) + ', ' + CAST(@Rating AS VARCHAR) + ', ' + CAST(@ScoreFactor AS VARCHAR) + ', ' + CAST(@SessionID AS VARCHAR) 

	UPDATE Session SET TrainerScore = @Score WHERE SessionID = @SessionID
	SET @Count = @Count + 1

	FETCH NEXT FROM Session_cursor INTO @SessionID, @Rating, @CourseRating, @Type, @Level, @Apply, @Recommend1, @Recommend2, @Recommend3, @ScoreFactor
END
CLOSE Session_cursor
DEALLOCATE Session_cursor

--**********************************************************************************************************
--Process all complete member assessments without a trainer score
DECLARE MemberAssess_cursor CURSOR LOCAL STATIC FOR 
SELECT 	ma.MemberAssessID, 
	am.Rating, 
	CASE am.AssessType
		WHEN 1 THEN @TYPE_PERSONAL
		WHEN 2 THEN @TYPE_ACADEMIC
		WHEN 3 THEN @TYPE_PROFESSIONAL
		WHEN 4 THEN @TYPE_TECHNICAL
		ELSE 1
	END,
	CASE am.AssessLevel
		WHEN 1 THEN @LEVEL_BEGINNER
		WHEN 2 THEN @LEVEL_INTERMEDIATE
		WHEN 3 THEN @LEVEL_ADVANCED
		WHEN 4 THEN @LEVEL_EXPERT
		ELSE 1
	END,
	am.ScoreFactor
FROM MemberAssess AS ma 
JOIN Assessment AS am ON ma.AssessmentID = am.AssessmentID
WHERE am.CompanyID = 0 
AND am.IsPaid = 1 
AND ma.TrainerScore = 0 
AND ma.CompleteDate != 0

OPEN MemberAssess_cursor
FETCH NEXT FROM MemberAssess_cursor INTO @MemberAssessID, @Rating, @Type, @Level, @ScoreFactor

SET @ApplyRecWeight = 6

WHILE @@FETCH_STATUS = 0
BEGIN
	IF @Rating = 0 SET @Rating = 1
	IF @ScoreFactor = 0 SET @ScoreFactor = 1

--	calculate the course type weight
	SET @TypeLevelWeight = @Type * @Level
--PRINT 'Type Level Weight:' + CAST(@TypeLevelWeight AS VARCHAR)

-- 	Calculate the Trainer Score for this class ---------------------------------------------
	SET @Score = @TypeLevelWeight * @ApplyRecWeight * @Rating * @ScoreFactor

--PRINT CAST(@Score AS VARCHAR) + ', ' + CAST(@TypeLevelWeight AS VARCHAR) + ', ' + CAST(@ApplyRecWeight AS VARCHAR) + ', ' + CAST(@Rating AS VARCHAR) + ', ' + CAST(@ScoreFactor AS VARCHAR) + ', ' + CAST(@MemberAssessID AS VARCHAR) 

	UPDATE MemberAssess SET TrainerScore = @Score WHERE MemberAssessID = @MemberAssessID
	SET @Count = @Count + 1

	FETCH NEXT FROM MemberAssess_cursor INTO @MemberAssessID, @Rating, @Type, @Level, @ScoreFactor
END
CLOSE MemberAssess_cursor
DEALLOCATE MemberAssess_cursor

GO
