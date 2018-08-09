EXEC [dbo].pts_CheckProc 'pts_Session_SetStatus'
GO

--DECLARE @MemberID int 
--EXEC pts_Session_SetStatus 52071, '', @MemberID
--select grade from session where sessionid = 2064

CREATE PROCEDURE [dbo].pts_Session_SetStatus
   @SessionID int ,
   @Feedback nvarchar (2000) ,
   @MemberID int OUTPUT
AS

SET NOCOUNT ON

DECLARE @Cnt int, @TotalCnt int, @TotalWeight int, @MinStatus int, @OldStatus int, @NewStatus int
DECLARE @CourseID int, @PassingGrade money, @Grade money 
DECLARE @StartDate datetime, @CompleteDate datetime , @Now datetime 
DECLARE @Time int, @Times decimal (10, 8)
DECLARE @MemberAssessID int, @ExamID int, @ExamWeight money, @ExamPts int, @HomeworkPts int

SET @Now = GETDATE()
SET @ExamPts = 0
SET @HomeworkPts = 0 
SET @Grade = 0 

-- 1 = Registered
-- 2 = Started
-- 3 = Dropped
-- 5 = Completed
-- 6 = Quized
-- 7 = Certified

-- Get the start and complete dates, and course # for the session
SELECT @StartDate = StartDate, @CompleteDate = CompleteDate, @OldStatus = Status, 
		@MemberID = MemberID, @CourseID = CourseID FROM Session WHERE SessionID = @SessionID

SET @NewStatus = @OldStatus

-- Get the total number of lesson already started, and the total time and times, ignore lessons with length=0
SELECT @Cnt = Count(sl.SessionLessonID), @Time = ISNULL(SUM(sl.Time),0), @Times = ISNULL(SUM(sl.Times),0) 
FROM SessionLesson as sl
LEFT JOIN Lesson AS le ON sl.LessonID = le.LessonID
WHERE sl.SessionID = @SessionID AND le.LessonLength > 0
AND   ( @Feedback = '' OR  @Feedback LIKE '%,' + CONVERT(nvarchar(10), le.seq) + ',%'  )


-- Get the total number of active lessons in the course, ignore lessons with length=0
SELECT @TotalCnt = Count(LessonID) FROM Lesson 
WHERE  CourseID = @CourseID AND Status = 2 AND LessonLength > 0 
AND    ( @Feedback = '' OR  @Feedback LIKE '%,' + CONVERT(nvarchar(10), seq) + ',%'  )


-- save the total time and average number of times
IF @TotalCnt > 0 SET @Times = @Times / @TotalCnt
UPDATE Session SET [Time] = @Time, Times = @Times  WHERE SessionID = @SessionID

-- If we haven't started all the lessons, set status to Started (2)
IF @Cnt < @TotalCnt
BEGIN
	SET @NewStatus = 2
	IF @StartDate = 0
		UPDATE Session SET Status = @NewStatus, StartDate = @Now WHERE SessionID = @SessionID
	ELSE
		UPDATE Session SET Status = @NewStatus WHERE SessionID = @SessionID
END 


-- If we have started all the lessons
IF @Cnt >= @TotalCnt
BEGIN
	
-- Check the completion Status of all Session Lessons
	SELECT @Cnt = Count(sl.SessionLessonID) 
	FROM SessionLesson as sl
	LEFT JOIN Lesson AS le ON sl.LessonID = le.LessonID
	WHERE sl.SessionID = @SessionID AND sl.Status < 2 AND le.LessonLength > 0
	AND   ( @Feedback = '' OR  @Feedback LIKE '%,' + CONVERT(nvarchar(10), le.seq) + ',%'  )
	
-- If we found lessons that are not completed, set status to Started (2)
	IF @Cnt > 0
	BEGIN
		SET @NewStatus = 2
		IF @StartDate = 0
			UPDATE Session SET Status = @NewStatus, StartDate = @Now WHERE SessionID = @SessionID
		ELSE
			UPDATE Session SET Status = @NewStatus WHERE SessionID = @SessionID
	END 
-- If we didn't find any lessons that are not completed
	IF @Cnt = 0
	BEGIN
-- Get the total number of Lessons that have quizes that apply to the final grade
		SELECT @TotalCnt = COUNT(LessonID), @TotalWeight = ISNULL(SUM(QuizWeight),0) FROM Lesson  
		WHERE CourseID = @CourseID AND Quiz > 1 AND QuizWeight > 0
		AND   ( @Feedback = '' OR  @Feedback LIKE '%,' + CONVERT(nvarchar(10), seq) + ',%'  )
--print 'TotalCnt: ' + cast(@TotalCnt as varchar(10))
	
-- Get the total number of session quizes that have been completed, that apply to the final grade
-- and get the calculated grade and lowest lesson status
		SELECT @Cnt = COUNT(le.LessonID), @Grade = ISNULL(SUM(le.QuizWeight * sl.QuizScore)/100,0), @MinStatus = ISNULL(MIN(sl.Status),0)
		FROM Lesson AS le JOIN SessionLesson AS sl ON le.LessonID = sl.LessonID 
		WHERE le.CourseID = @CourseID AND sl.SessionID = @SessionID
		AND sl.Status >= 2 AND le.Quiz > 1 AND le.QuizWeight > 0
		AND   ( @Feedback = '' OR  @Feedback LIKE '%,' + CONVERT(nvarchar(10), le.seq) + ',%'  )
--print 'Cnt: ' + cast(@Cnt as varchar(10))

-- Get the total homework points of homework that has been submitted, that apply to the final grade
		SELECT @HomeworkPts = ISNULL(SUM(hw.Weight * att.Score)/100,0), @TotalWeight = @TotalWeight + ISNULL(SUM(hw.Weight),0)
		FROM Attachment AS att 
		JOIN SessionLesson AS sl ON att.ParentType = 24 AND att.ParentID = sl.SessionLessonID 
		JOIN Homework AS hw ON att.RefID = hw.HomeworkID
		WHERE sl.SessionID = @SessionID AND hw.Weight > 0

-- If the course has a final exam, Get the total points for the taken assessment
		DECLARE @MemberAssess int
		SET @MemberAssess = 0
		SELECT @ExamID = ExamID, @ExamWeight = ExamWeight FROM Course WHERE CourseID = @CourseID
		IF @ExamID > 0 
		BEGIN
			EXEC pts_MemberAssess_CheckAssessment @ExamID, @MemberID, 1, @MemberAssessID OUTPUT
			IF @MemberAssessID > 0 
			BEGIN
				SELECT @ExamPts = Score * ( @ExamWeight / 100 ), @TotalWeight = @TotalWeight + @ExamWeight
				FROM MemberAssess as ma
				WHERE MemberAssessID = @MemberAssessID
			END
		END

-- calculate the total of all grade points
		SET @Grade = @Grade + @HomeworkPts + @ExamPts
	
-- IF their are no final quizes and no Grade, set the Status to Completed (5)
		IF @TotalCnt = 0 AND @Grade = 0
		BEGIN
			SET @NewStatus = 5
			IF @CompleteDate = 0
				UPDATE Session SET Status = @NewStatus, CompleteDate = @Now WHERE SessionID = @SessionID
			ELSE
				UPDATE Session SET Status = @NewStatus WHERE SessionID = @SessionID
		END 
		
-- IF all the necessary quizes havent been completed yet, set the Status to Started (2)
		IF @Cnt < @TotalCnt
		BEGIN
			SET @NewStatus = 2
			IF @StartDate = 0
				UPDATE Session SET Status = @NewStatus, StartDate = @Now WHERE SessionID = @SessionID
			ELSE
				UPDATE Session SET Status = @NewStatus WHERE SessionID = @SessionID
		END 
		
-- If we found all necessary quizes completed
		IF @Cnt >= @TotalCnt
		BEGIN
-- If the lowest lesson status is complete (2) and no grade, then set Session Status to Complete (5)
			IF @MinStatus = 2 AND @Grade = 0
			BEGIN
				SET @NewStatus = 5
				IF @CompleteDate = 0
					UPDATE Session SET Status = @NewStatus, CompleteDate = @Now WHERE SessionID = @SessionID
				ELSE
					UPDATE Session SET Status = @NewStatus WHERE SessionID = @SessionID
			END 
	
-- If the lowest lesson status is quized (3), then calculate grade and status
			IF @MinStatus > 2 OR @Grade > 0
			BEGIN
-- Get the Course PassingGrade, if PassingGrade = 0, then no final grade
				SELECT @PassingGrade = PassingGrade FROM Course WHERE CourseID = @CourseID
		
-- If the course doesn't have a grade (PassingGrade=0), set status to complete (5)
				IF @PassingGrade = 0
				BEGIN
					SET @NewStatus = 5
					IF @CompleteDate = 0
						UPDATE Session SET Status = @NewStatus, CompleteDate = @Now WHERE SessionID = @SessionID
					ELSE
						UPDATE Session SET Status = @NewStatus WHERE SessionID = @SessionID
				END 
		
-- If the course has a grade, lookup the quiz scores
				IF @PassingGrade > 0
				BEGIN
-- Adjust for the totalweight of all final quizes not equaling 100
					IF @TotalWeight <> 100 AND @TotalWeight > 0
					BEGIN
						DECLARE @Factor decimal (10,6)
						SET @Factor = 100 / cast(@TotalWeight as decimal (10,6))
						SET @Grade = @Grade * @Factor
					END
-- IF the final grade is below the passing grade, save grade and set status to quized (failed)
					IF @Grade < @PassingGrade
					BEGIN
						SET @NewStatus = 6
						UPDATE Session SET Grade = @Grade, Status = @NewStatus WHERE SessionID = @SessionID
					END	
		
-- IF the final grade is a passing grade, save grade and set status to Certified (passed)
					IF @Grade >= @PassingGrade
					BEGIN
						SET @NewStatus = 7
						UPDATE Session SET Grade = @Grade, Status = @NewStatus WHERE SessionID = @SessionID
					END	
				END
			END
		END
	END
END
-- Only Return MemberID if newly completed
IF @OldStatus > 3 OR @NewStatus < 5
	SET @MemberID = 0

GO
