
SET NOCOUNT ON

DECLARE	@ID int, @CourseID int, @CourseName nvarchar(80), @Description nvarchar(1000), @TrainerName nvarchar(60)

DECLARE Course_cursor CURSOR FOR 
SELECT  cs.CourseID, cs.CourseName, cs.Description, tr.CompanyName
FROM Course as cs JOIN Trainer as tr ON cs.TrainerID = tr.TrainerID
--WHERE cs.Status = 3

OPEN Course_cursor

FETCH NEXT FROM Course_cursor INTO @CourseID, @CourseName, @Description, @TrainerName

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @ID = 0

	SELECT @ID = @CourseID FROM CourseFT WHERE CourseID = @CourseID
print cast(@ID as varchar(10))

	IF @ID = 0
	BEGIN
		INSERT INTO CourseFT ( CourseID, FT ) VALUES ( @CourseID, @CourseName + ' ' + @TrainerName + ' ' + @Description )
print 'Insert'
	END
	IF @ID > 0
	BEGIN
		UPDATE CourseFT SET FT = @CourseName + ' ' + @TrainerName + ' ' + @Description WHERE CourseID = @CourseID
print 'Update'
	END
	
	FETCH NEXT FROM Course_cursor INTO @CourseID, @CourseName, @Description, @TrainerName
END

CLOSE Course_cursor
DEALLOCATE Course_cursor

