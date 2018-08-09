EXEC [dbo].pts_CheckProc 'pts_BoardUser_UpdateMUC'
GO

CREATE PROCEDURE [dbo].pts_BoardUser_UpdateMUC
   @BoardUserID int,
   @AuthUserID int,
   @BoardUserName nvarchar(32),
   @BoardUserGroup int,
   @IsPublicName bit,
   @IsPublicEmail bit 

AS

SET         NOCOUNT ON

DECLARE @Now varchar(15), @email nvarchar(80), @password nvarchar(30), @logon nvarchar(80), @userID int, @affil int

--get the current date in 0 padded, right aligned millisecond format
SET @Now = RIGHT('000000000000000' + CONVERT(VARCHAR(15), 
		CONVERT(BIGINT, 
			DATEDIFF(second, '19700101', CURRENT_TIMESTAMP)
		) * 1000 + DATEDIFF(millisecond,
			DATEADD(second,
				DATEDIFF(second, '19700101', CURRENT_TIMESTAMP),
				'19700101'),
			CURRENT_TIMESTAMP)
		), 15) 

SELECT @email = Email, @password = Password, @logon = Logon
FROM AuthUser
WHERE AuthUserID = @AuthUserID

SELECT @userID = userID
FROM jiveUser
WHERE BoardUserID = @BoardUserID

--update the jiveUserID record
UPDATE jiveUserID 
SET userName = @logon
WHERE objectID = @userID

--update the jiveUser record
UPDATE jiveUser
SET 	password = @password,
	name = @BoardUserName,
	nameVisible = @IsPublicName,
	email = @email,
	emailVisible = @IsPublicEmail,
	modificationDate = @Now
WHERE BoardUserID = @BoardUserID


-- update affiliate record
SET @affil = ISNULL((SELECT affiliation FROM mucAffiliation WHERE roomID = 0 AND jid = @userID), 0)

IF @BoardUserGroup = 3 AND @affil = 0
BEGIN
--insert the mucAffiliation record
	
	INSERT INTO mucAffiliation (
	roomID,
	jid,
	affiliation
	)
	VALUES (
	0,
	@userID,
	20
	)
END

IF @BoardUserID < 3 AND @affil > 0
BEGIN
	DELETE FROM mucAffiliation
	WHERE jid = @userID AND roomID = 0
END

GO