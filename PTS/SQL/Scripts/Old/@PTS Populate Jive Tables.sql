
DECLARE @Logon nvarchar(30),
	@Name nvarchar(100), 
	@Password nvarchar(32),
	@Email nvarchar(100),
	@IsPublicEmail int,
	@IsPublicName int,
	@IsAdmin int,
	@UserGroup int,
	@mNow datetime,
	@NextID int

SET	@mNow = GETDATE()
SET	@NextID = (SELECT [id] FROM jiveID WHERE idType = 3)


DECLARE Board_cursor CURSOR FOR 
SELECT au.Logon,
	bu.BoardUserName AS 'Name', 
	au.[Password],
	au.Email,
	bu.IsPublicName,
	bu.IsPublicEmail,
	bu.BoardUserGroup AS 'UserGroup'
FROM BoardUser AS bu
JOIN AuthUser AS au ON (bu.AuthUserID = au.AuthUserID)

OPEN Board_cursor
FETCH NEXT FROM Board_cursor INTO @Logon, @Name, @Password, @Email, @IsPublicName, @IsPublicEmail, @UserGroup

WHILE @@FETCH_STATUS = 0
BEGIN

	/* Insert the userID record - objectType is 0 for users, 1 for chat bots
		objectID corresponds to the userID or chatbotID*/
	INSERT INTO jiveUserID 
		(username, domainID, objectType, objectID) 
		VALUES (@Logon, 1, 0, @NextID);

	/* Insert the user record - userID is incremented manually */
	INSERT INTO jiveUser 
		(userID, [name], [password], nameVisible, email, emailVisible, creationDate, modificationDate) 
		VALUES (@NextID, @Name, @Password, @IsPublicName, @Email, @IsPublicEmail, @mNow, @mNow)

	IF @UserGroup > 1
	BEGIN
		SET @IsAdmin = 1
	END
	ELSE
	BEGIN
		SET @IsAdmin = 0
	END

	/* Make the administrator an admin member of the Administrators group - hardcoded :( */
	INSERT INTO jiveGroupUser 
		(groupID, userID, administrator) 
		VALUES (@UserGroup, @NextID, @IsAdmin); 

	SET	@NextID = @NextID + 1

	FETCH NEXT FROM Board_cursor INTO @Logon, @Name, @Password, @Email, @IsPublicName, @IsPublicEmail, @UserGroup
END

CLOSE Board_cursor
DEALLOCATE Board_cursor

--update the id
UPDATE jiveID SET [id] = @NextID WHERE idType = 3
