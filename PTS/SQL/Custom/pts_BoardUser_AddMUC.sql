EXEC [dbo].pts_CheckProc 'pts_BoardUser_AddMUC'
GO

CREATE PROCEDURE [dbo].pts_BoardUser_AddMUC
   @BoardUserID int,
   @AuthUserID int,
   @BoardUserName nvarchar(32),
   @BoardUserGroup int,
   @IsPublicName bit,
   @IsPublicEmail bit 

AS

SET         NOCOUNT ON

DECLARE @Now varchar(15), @NextID int, @email nvarchar(80), @password nvarchar(30), @logon nvarchar(80)

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

--get the next available unique id
SET @NextID = (
	SELECT id + 1
	FROM jiveID
	WHERE idType = 3
	)

SELECT @email = Email, @password = Password, @logon = Logon
FROM AuthUser
WHERE AuthUserID = @AuthUserID

--insert the jiveUserID record
INSERT INTO jiveUserID (
	userName,
	domainID,
	objectType,
	objectID
	)
	VALUES (
	@logon,
	1,
	0,
	@NextID
	)

--insert the jiveUser record
INSERT INTO jiveUser (
	userID,
	BoardUserID,
	password,
	name,
	nameVisible,
	email,
	emailVisible,
	creationDate,
	modificationDate
	) 
VALUES (
	@NextID,
	@BoardUserID,
	@password,
	@BoardUserName,
	@IsPublicName,
	@email,
	@IsPublicEmail,
	@Now,
	@Now
	)

IF @BoardUserGroup = 3 
BEGIN
--insert the mucAffiliation record
	INSERT INTO mucAffiliation (
	roomID,
	jid,
	affiliation
	)
	VALUES (
	0,
	@NextID,
	20
	)
END

--update the unique id
UPDATE jiveID 
SET id = @NextID + 1
WHERE idType = 3 

GO