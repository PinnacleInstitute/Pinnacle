EXEC [dbo].pts_CheckProc 'pts_Course_ListTextCourses'
GO

--EXEC pts_Course_ListTextCourses '660 660, 660,660,658, 657, 655, 653, 651, 650, 648, 646'

CREATE PROCEDURE [dbo].pts_Course_ListTextCourses
   @CourseName varchar (80)
AS

SET NOCOUNT ON

DECLARE @CourseIDs varchar (80), @CourseID1 int, @CourseID2 int, @CourseID3 int, @CourseID4 int, @CourseID5 int 
DECLARE @CourseID6 int, @CourseID7 int, @CourseID8 int, @CourseID9 int, @CourseID10 int 
DECLARE @x int, @cnt int, @ID int, @xspace int

SET @CourseIDs = @CourseName
SET @CourseID1 = 0
SET @CourseID2 = 0
SET @CourseID3 = 0
SET @CourseID4 = 0
SET @CourseID5 = 0
SET @CourseID6 = 0
SET @CourseID7 = 0
SET @CourseID8 = 0
SET @CourseID9 = 0
SET @CourseID10 = 0

SET @cnt = 0
WHILE @CourseIDs != ''
BEGIN
	SET @x = CHARINDEX(',', @CourseIDs)
	SET @xspace = CHARINDEX(' ', @CourseIDs)
--	Found comma and space, use the first one found	
	IF @x > 0 AND @xspace > 0 IF @xspace < @x SET @x = @xspace
--	Found space only, use the space
	IF @x = 0 AND @xspace > 0 SET @x = @xspace
--	Found comma only, use the comma

	IF @x > 0
	BEGIN
		SET @ID = CAST(SUBSTRING(@CourseIDs, 1, @x-1) AS int)
		SET @CourseIDs = LTRIM(SUBSTRING(@CourseIDs, @x+1, LEN(@CourseIDs)-@x))
	END
	ELSE
	BEGIN
		SET @ID = CAST(@CourseIDs AS int)
		SET @CourseIDs = ''
	END
	IF @ID!=@CourseID1 AND @ID!=@CourseID2 AND @ID!=@CourseID3 AND @ID!=@CourseID4 AND @ID!=@CourseID5 AND
	   @ID!=@CourseID6 AND @ID!=@CourseID7 AND @ID!=@CourseID8 AND @ID!=@CourseID9 AND @ID!=@CourseID10
	BEGIN
		SET @cnt = @cnt + 1
		IF @cnt = 1 SET @CourseID1 = @ID
		IF @cnt = 2 SET @CourseID2 = @ID
		IF @cnt = 3 SET @CourseID3 = @ID
		IF @cnt = 4 SET @CourseID4 = @ID
		IF @cnt = 5 SET @CourseID5 = @ID
		IF @cnt = 6 SET @CourseID6 = @ID
		IF @cnt = 7 SET @CourseID7 = @ID
		IF @cnt = 8 SET @CourseID8 = @ID
		IF @cnt = 9 SET @CourseID9 = @ID
		IF @cnt = 10 SET @CourseID10 = @ID
	END 
END 

SELECT cs.CourseID, 
       cs.CourseName, 
       tr.CompanyName AS 'TrainerName', 
       cs.TrainerID, 
       cs.CourseLength, 
       cs.Rating, 
       cs.RatingCnt,
       cs.Classes,
       cs.Language, 
       cs.Description, 
       cs.Video, 
       cs.Audio, 
       cs.Quiz, 
       cs.CourseDate,
	CASE  
	WHEN CourseID = @CourseID1 THEN 1
	WHEN CourseID = @CourseID2 THEN 2
	WHEN CourseID = @CourseID3 THEN 3
	WHEN CourseID = @CourseID4 THEN 4
	WHEN CourseID = @CourseID5 THEN 5
	WHEN CourseID = @CourseID6 THEN 6
	WHEN CourseID = @CourseID7 THEN 7
	WHEN CourseID = @CourseID8 THEN 8
	WHEN CourseID = @CourseID9 THEN 9
	WHEN CourseID = @CourseID10 THEN 10
	END AS 'Amount'
FROM Course AS cs (NOLOCK)
LEFT OUTER JOIN Trainer AS tr (NOLOCK) ON (cs.TrainerID = tr.TrainerID)
WHERE cs.Status = 3
AND cs.CourseID IN (@CourseID1, @CourseID2, @CourseID3, @CourseID4, @CourseID5, @CourseID6, @CourseID7, @CourseID8, @CourseID9, @CourseID10)
ORDER BY Amount
GO