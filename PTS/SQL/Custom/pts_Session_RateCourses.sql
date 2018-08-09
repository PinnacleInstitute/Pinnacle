EXEC [dbo].pts_CheckProc 'pts_Session_RateCourses'
GO

--EXEC pts_Session_RateCourses

CREATE PROCEDURE [dbo].pts_Session_RateCourses

AS

SET NOCOUNT ON

DECLARE @CourseID int, @Rating int, @Cnt int

-----------------------------------------------------------------------------------------
-- Reset all Course rating info to zero
-----------------------------------------------------------------------------------------
UPDATE Course SET Rating = 0, RatingCnt = 0, Classes = 0

-----------------------------------------------------------------------------------------
-- Set all Completed Session ratings to 6 (average) if no score is specified
-----------------------------------------------------------------------------------------
UPDATE Session SET Rating1 = 3, Rating2 = 3, Rating3 = 3, Rating4 = 3, TotalRating = 6
WHERE TotalRating = 0 AND CompleteDate > 0

-----------------------------------------------------------------------------------------
-- Update rating and total number of classes in rating for each Course
-----------------------------------------------------------------------------------------
DECLARE @FromDate datetime, @ToDate datetime

SET @ToDate = GETDATE()
SET @FromDate = DATEADD(month, -6, @ToDate)

DECLARE Session_cursor CURSOR LOCAL STATIC FOR 
SELECT CourseID, ROUND(AVG(CAST(TotalRating AS FLOAT)),0), COUNT(SessionID)
FROM Session 
WHERE TotalRating > 0 
AND   CompleteDate >= @FromDate
AND   CompleteDate <= @ToDate
GROUP BY courseid

OPEN Session_cursor
FETCH NEXT FROM Session_cursor INTO @CourseID, @Rating, @Cnt

WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE Course SET Rating = @Rating, RatingCnt = @Cnt WHERE CourseID = @CourseID 
	FETCH NEXT FROM Session_cursor INTO @CourseID, @Rating, @Cnt
END
CLOSE Session_cursor
DEALLOCATE Session_cursor

-----------------------------------------------------------------------------------------
-- Update total number of completed classes for each Course
-----------------------------------------------------------------------------------------

DECLARE Session_cursor CURSOR LOCAL STATIC FOR 
SELECT CourseID, COUNT(SessionID)
FROM Session 
WHERE CompleteDate > 0
GROUP BY courseid

OPEN Session_cursor
FETCH NEXT FROM Session_cursor INTO @CourseID, @Cnt

WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE Course SET Classes = @Cnt WHERE CourseID = @CourseID 
	FETCH NEXT FROM Session_cursor INTO @CourseID, @Cnt
END
CLOSE Session_cursor
DEALLOCATE Session_cursor

GO
