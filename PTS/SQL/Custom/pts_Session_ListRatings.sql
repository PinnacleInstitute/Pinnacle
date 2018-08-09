EXEC [dbo].pts_CheckProc 'pts_Session_ListRatings'
GO

CREATE PROCEDURE [dbo].pts_Session_ListRatings
   @CourseID int ,
   @UserID int
AS

SET NOCOUNT ON

IF @UserID = 1
BEGIN
	SELECT TOP 100 se.SessionID, 
	         LTRIM(RTRIM(se.NameFirst)) +  ' '  + LTRIM(RTRIM(se.NameLast)) AS 'StudentName', 
	         se.CompleteDate, 
	         se.Rating1, 
	         se.Rating2, 
	         se.Rating3, 
	         se.Rating4, 
	         se.TotalRating, 
	         se.Feedback,
	         se.Apply,
	         se.Recommend1,
	         se.Recommend2,
	         se.Recommend3
	FROM Session AS se (NOLOCK)
	WHERE (se.CourseID = @CourseID)
	AND   (se.CompleteDate > 0)
	ORDER BY se.CompleteDate DESC
END
IF @UserID = 2
BEGIN
	SELECT TOP 100 se.SessionID, 
	         LTRIM(RTRIM(se.NameFirst)) +  ' '  + LTRIM(RTRIM(se.NameLast)) AS 'StudentName', 
	         se.CompleteDate, 
	         se.Rating1, 
	         se.Rating2, 
	         se.Rating3, 
	         se.Rating4, 
	         se.TotalRating, 
	         se.Feedback,
	         se.Apply,
	         se.Recommend1,
	         se.Recommend2,
	         se.Recommend3
	FROM Session AS se (NOLOCK)
	WHERE (se.CourseID = @CourseID)
	AND   (se.CompleteDate > 0)
	AND   (se.TotalRating > 0) 
	ORDER BY se.CompleteDate DESC
END
IF @UserID = 3
BEGIN
	SELECT TOP 100 se.SessionID, 
	         LTRIM(RTRIM(se.NameFirst)) +  ' '  + LTRIM(RTRIM(se.NameLast)) AS 'StudentName', 
	         se.CompleteDate, 
	         se.Rating1, 
	         se.Rating2, 
	         se.Rating3, 
	         se.Rating4, 
	         se.TotalRating, 
	         se.Feedback,
	         se.Apply,
	         se.Recommend1,
	         se.Recommend2,
	         se.Recommend3
	FROM Session AS se (NOLOCK)
	WHERE (se.CourseID = @CourseID)
	AND   (se.CompleteDate > 0)
	AND   (se.Feedback != '') 
	ORDER BY se.CompleteDate DESC
END

IF @UserID = 4
BEGIN
	SELECT TOP 100 se.SessionID, 
	         LTRIM(RTRIM(se.NameFirst)) +  ' '  + LTRIM(RTRIM(se.NameLast)) AS 'StudentName', 
	         se.CompleteDate, 
	         se.Rating1, 
	         se.Rating2, 
	         se.Rating3, 
	         se.Rating4, 
	         se.TotalRating, 
	         se.Feedback,
	         se.Apply,
	         se.Recommend1,
	         se.Recommend2,
	         se.Recommend3
	FROM Session AS se (NOLOCK)
	WHERE (se.CourseID = @CourseID)
	AND   (se.CompleteDate > 0)
	AND   (se.TotalRating < 6) 
	ORDER BY se.CompleteDate DESC
END

GO