-- Set UserCode for all AuthUsers

DECLARE @AuthUserID int, @UserCode varchar(10)

DECLARE AuthUser_cursor CURSOR LOCAL STATIC FOR 
select AuthUserID from AuthUser 
OPEN AuthUser_cursor
FETCH NEXT FROM AuthUser_cursor INTO @AuthUserID
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_System_GetPassword @UserCode OUTPUT
	UPDATE AuthUser SET UserCode = @UserCode WHERE AuthUserID = @AuthUserID
	FETCH NEXT FROM AuthUser_cursor INTO @AuthUserID
END
CLOSE AuthUser_cursor
DEALLOCATE AuthUser_cursor

GO
