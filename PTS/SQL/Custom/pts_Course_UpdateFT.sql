EXEC [dbo].pts_CheckProc 'pts_Course_UpdateFT'
GO

CREATE PROCEDURE [dbo].pts_Course_UpdateFT
   @CourseID int,
   @CourseName nvarchar (80),
   @TrainerName nvarchar (60),
   @Description nvarchar (1000),
   @Result int OUTPUT
AS

DECLARE @ID int

SELECT @ID = @CourseID FROM CourseFT WHERE CourseID = @CourseID

IF @ID IS NULL
BEGIN
	INSERT INTO CourseFT ( CourseID, FT ) VALUES ( @CourseID, @CourseName + ' ' + @TrainerName + ' ' + @Description )

	SET @Result = 1
END
IF @ID > 0
BEGIN
	UPDATE CourseFT
	SET FT = @CourseName + ' ' + @TrainerName + ' ' + @Description
	WHERE CourseID = @CourseID

	SET @Result = 2
END

GO