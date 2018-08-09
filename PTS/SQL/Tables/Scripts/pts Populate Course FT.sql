
DECLARE @CourseID int, @CourseName nvarchar(80), @TrainerName nvarchar(60), @Description nvarchar (1000), @Result int

DECLARE Course_cursor CURSOR STATIC FOR 
SELECT co.CourseID, co.CourseName, tr.CompanyName, co.Description from Course as co
LEFT JOIN CourseFT AS ft ON co.CourseID = ft.CourseID
LEFT JOIN Trainer AS tr ON co.TrainerID = tr.TrainerID
where ft.courseid IS NULL AND co.Status = 3

OPEN Course_cursor
FETCH NEXT FROM Course_cursor INTO @CourseID, @CourseName, @TrainerName, @Description 

WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_Course_UpdateFT @CourseID, @CourseName, @TrainerName, @Description, @Result OUTPUT

	FETCH NEXT FROM Course_cursor INTO @CourseID, @CourseName, @TrainerName, @Description 
END

CLOSE Course_cursor
DEALLOCATE Course_cursor

