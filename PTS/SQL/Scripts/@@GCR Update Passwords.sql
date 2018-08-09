-- Set Password for all GCR Users

DECLARE @AuthUserID int, @Password varchar(10)

-------------------------------------------------
-- Reset All GCR Members
-------------------------------------------------
DECLARE AuthUser_cursor CURSOR LOCAL STATIC FOR 
select AuthUserID from Member Where CompanyID = 17
OPEN AuthUser_cursor
FETCH NEXT FROM AuthUser_cursor INTO @AuthUserID
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_System_GetPassword @Password OUTPUT
--	UPDATE AuthUser SET Password = @Password WHERE AuthUserID = @AuthUserID
	FETCH NEXT FROM AuthUser_cursor INTO @AuthUserID
END
CLOSE AuthUser_cursor
DEALLOCATE AuthUser_cursor

-------------------------------------------------
-- Reset All GCR Admins/Managers Passwords
-------------------------------------------------
DECLARE AuthUser_cursor CURSOR LOCAL STATIC FOR 
select AuthUserID from Org where companyid = 17
OPEN AuthUser_cursor
FETCH NEXT FROM AuthUser_cursor INTO @AuthUserID
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_System_GetPassword @Password OUTPUT
--	UPDATE AuthUser SET Password = @Password WHERE AuthUserID = @AuthUserID
	FETCH NEXT FROM AuthUser_cursor INTO @AuthUserID
END
CLOSE AuthUser_cursor
DEALLOCATE AuthUser_cursor

------------------------------------
-- Reset All Employee Passwords
------------------------------------
DECLARE AuthUser_cursor CURSOR LOCAL STATIC FOR 
select AuthUserID from Employee
OPEN AuthUser_cursor
FETCH NEXT FROM AuthUser_cursor INTO @AuthUserID
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_System_GetPassword @Password OUTPUT
--	UPDATE AuthUser SET Password = @Password WHERE AuthUserID = @AuthUserID
	FETCH NEXT FROM AuthUser_cursor INTO @AuthUserID
END
CLOSE AuthUser_cursor
DEALLOCATE AuthUser_cursor

GO
