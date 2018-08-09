
DECLARE @ForumID int, 
	@ForumName nvarchar(60), 
	@Description nvarchar(500), 
	@RoomID int

-- populate rooms

DECLARE MUCCursor CURSOR STATIC LOCAL FOR
SELECT ForumID, ForumName, Description FROM Forum

OPEN MUCCursor

FETCH NEXT FROM MUCCursor
INTO @ForumID, @ForumName, @Description

WHILE (@@FETCH_STATUS = 0) 
BEGIN

	SET @RoomID = ISNULL((
		SELECT roomID
		FROM mucRoom
		WHERE [name] = @ForumName + ' ' + LTRIM(RTRIM(CAST(@ForumID AS nvarchar(10))))
		), 0)

	IF @RoomID = 0 
	BEGIN
		PRINT CAST(@ForumID AS VARCHAR(10))
		EXEC pts_Forum_AddMUC @ForumID, @ForumName, @Description
	END
	
	FETCH NEXT FROM MUCCursor
	INTO @ForumID, @ForumName, @Description
END

CLOSE MUCCursor
DEALLOCATE MUCCursor

-- populate users

DECLARE @BoardUserID int,
	@AuthUserID int,
	@BoardUserName nvarchar(32),
	@BoardUserGroup int,
	@IsPublicName bit,
	@IsPublicEmail bit,
	@userID int

DECLARE MUCCursor CURSOR STATIC LOCAL FOR
SELECT BoardUserID, AuthUserID, BoardUserName, @BoardUserGroup, IsPublicName, IsPublicEmail FROM BoardUser

OPEN MUCCursor

FETCH NEXT FROM MUCCursor
INTO @BoardUserID, @AuthUserID, @BoardUserName, @BoardUserGroup, @IsPublicName, @IsPublicEmail

WHILE (@@FETCH_STATUS = 0) 
BEGIN

	SET @userID = ISNULL((
		SELECT userID
		FROM jiveUser
		WHERE BoardUserID = @BoardUserID), 0)

	IF @userID = 0 
	BEGIN
		PRINT 'BoardUserID:' + CAST(@BoardUserID AS VARCHAR(10))
		EXEC pts_BoardUser_AddMUC @BoardUserID, @AuthUserID, @BoardUserName, @BoardUserGroup, @IsPublicName, @IsPublicEmail
	END
	
	FETCH NEXT FROM MUCCursor
	INTO @BoardUserID, @AuthUserID, @BoardUserName, @BoardUserGroup, @IsPublicName, @IsPublicEmail
END

CLOSE MUCCursor
DEALLOCATE MUCCursor
