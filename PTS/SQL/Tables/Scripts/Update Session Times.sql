update sl
set sl.time = le.lessonlength * 60, sl.times=1
from sessionlesson as sl
join lesson as le on sl.lessonid = le.lessonid
where sl.status > 1

SET NOCOUNT ON

DECLARE	@SessionID int, @CourseID int
DECLARE @Cnt int, @TotalCnt int
DECLARE @Time int, @Times decimal (10, 8)

DECLARE Member_Cursor CURSOR FOR 
SELECT SessionID
FROM Session

OPEN Member_Cursor

FETCH NEXT FROM Member_Cursor INTO @SessionID


WHILE @@FETCH_STATUS = 0
BEGIN

SET @Time = 0
SET @Times = 0
-- Get the CourseID from the Session
SELECT @CourseID = CourseID FROM Session WHERE SessionID = @SessionID

SELECT @Cnt = Count(SessionLessonID), @Time = SUM([Time]), @Times = SUM(Times) 
FROM SessionLesson WHERE SessionID = @SessionID

-- Get the total number of active lessons in the course
SELECT @TotalCnt = Count(LessonID) FROM Lesson WHERE CourseID = @CourseID AND Status = 2

-- save the total time and average number of times
IF @TotalCnt > 0 SET @Times = @Times / @TotalCnt
--print CAST(@SessionID AS varchar(10)) + ', ' + CAST(ISNULL(@Time,0) AS varchar(10)) + ', ' + CAST(ISNULL(@Times,0) AS varchar(10)) 
UPDATE Session SET [Time] = ISNULL(@Time,0), Times = ISNULL(@Times,0)  WHERE SessionID = @SessionID
	
	FETCH NEXT FROM Member_Cursor INTO @SessionID
END

CLOSE Member_Cursor
DEALLOCATE Member_Cursor

