DECLARE @ID int, @Result int

DECLARE Project_cursor CURSOR LOCAL STATIC FOR 
SELECT  ProjectID FROM Project WHERE ParentID = 0

OPEN Project_cursor
FETCH NEXT FROM Project_cursor INTO @ID

WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_Project_UpdateHierarchy @ID, @Result

	FETCH NEXT FROM Project_cursor INTO @ID
END

CLOSE Project_cursor
DEALLOCATE Project_cursor
