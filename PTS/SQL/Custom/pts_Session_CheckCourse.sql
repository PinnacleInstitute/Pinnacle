EXEC [dbo].pts_CheckProc 'pts_Session_CheckCourse'
GO

--DECLARE @sessionID int EXEC [dbo].pts_Session_CheckCourse 107, 39148, 1, @SessionID OUTPUT PRINT @SessionID

CREATE PROCEDURE [dbo].pts_Session_CheckCourse
   @CourseID int ,
   @MemberID int ,
   @UserID int ,
   @SessionID int OUTPUT
AS

DECLARE @Pre varchar (20) 
SET @SessionID = 0

SET NOCOUNT ON

-- check for course preprequisites 
SELECT @Pre = Pre FROM Course WHERE CourseID = @CourseID
IF @Pre <> ''
BEGIN
	DECLARE @ID int, @x int

	WHILE @Pre != ''
	BEGIN
--		-- get each prerequisite course #
		SET @ID = 0
		SET @x = CHARINDEX(',', @Pre)
		IF @x = 0 SET @x = CHARINDEX(' ', @Pre)
		IF @x > 0
		BEGIN
			SET @ID = CAST(SUBSTRING(@Pre, 1, @x-1) AS int)
			SET @Pre = SUBSTRING(@Pre, @x+1, LEN(@Pre)-@x)
		END
		ELSE
		BEGIN
			SET @ID = CAST(@Pre AS int)
			SET @Pre = ''
		END

--		-- check if the member has passed the prerequisite course #
--		-- If course has a quiz, status = 7, else status = 5
		IF @ID > 0
		BEGIN
			SET @SessionID = 0
			SELECT @SessionID = se.SessionID FROM Session AS se (NOLOCK)
			WHERE se.CourseID = @ID AND se.MemberID = @MemberID
			AND (se.Status = 5 OR se.Status = 7)

--			-- if they haven't, return the negated prerequisite course #
			IF @SessionID = 0
			BEGIN
				SET @SessionID = @ID * -1
				SET @Pre = ''
			END
		END
	END 

END

IF @SessionID >= 0
BEGIN
	SET @SessionID = 0
	SELECT @SessionID = se.SessionID FROM Session AS se (NOLOCK)
	WHERE se.CourseID = @CourseID AND se.MemberID = @MemberID AND se.IsInactive = 0
END

GO