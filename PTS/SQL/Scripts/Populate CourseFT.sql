-- **************************************
-- Populate CourseFT
-- **************************************
declare @CourseID int, @ID int, @Count int
declare @CourseName nvarchar (80), @TrainerName nvarchar (60), @Description nvarchar (1000)

SET @Count = 0

DECLARE Course_cursor CURSOR FOR 
SELECT co.CourseID, co.CourseName, tr.CompanyName, co.Description   
FROM Course as co
join trainer as tr on co.trainerid = tr.trainerid
where co.Status = 3

OPEN Course_cursor
FETCH NEXT FROM Course_cursor INTO @CourseID, @CourseName, @TrainerName, @Description
WHILE @@FETCH_STATUS = 0
BEGIN
print @courseid
	SET @ID = 0
	SELECT @ID = CourseID FROM CourseFT WHERE CourseID = @CourseID

	IF @ID = 0
	BEGIN
		INSERT INTO CourseFT ( CourseID, FT ) VALUES ( @CourseID, @CourseName + ' ' + @TrainerName + ' ' + @Description )
	END
	IF @ID > 0
	BEGIN
		UPDATE CourseFT
		SET FT = @CourseName + ' ' + @TrainerName + ' ' + @Description
		WHERE CourseID = @CourseID
	END

	SET @Count = @Count + 1

	FETCH NEXT FROM Course_cursor INTO @CourseID, @CourseName, @TrainerName, @Description
END
CLOSE Course_cursor
DEALLOCATE Course_cursor

PRINT @Count
