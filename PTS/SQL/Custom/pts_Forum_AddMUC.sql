EXEC [dbo].pts_CheckProc 'pts_Forum_AddMUC'
GO

CREATE PROCEDURE [dbo].pts_Forum_AddMUC
   @ForumID int,
   @ForumName nvarchar(60) ,
   @Description nvarchar(500)

AS

SET         NOCOUNT ON

DECLARE @Now varchar(15), @NextID int

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
	WHERE idType = 23
	)

--insert the record
INSERT INTO mucRoom (
	roomID, 
	creationDate, 
	modificationDate, 
	name, 
	naturalName, 
	description, 
	canChangeSubject, 
	maxUsers, 
	publicRoom, 
	moderated, 
	invitationRequired, 
	canInvite, 
	password, 
	canDiscoverJID, 
	logEnabled, 
	subject, 
	rolesToBroadcast, 
	lastActiveDate, 
	inMemory,
	ForumID
	) 
VALUES (
	@NextID,
	@Now,
	@Now,
	Left(@ForumName, 45) + ' ' + LTRIM(RTRIM(CAST(@ForumID AS nvarchar(4)))),
	@ForumName,
	@Description,	
	1,
	0,
	1,
	0,
	0,
	0,
	'',
	0,
	0,
	@ForumName,
	7,
	@Now,
	1,
	@ForumID
	)

--update the unique id
UPDATE jiveID 
SET id = @NextID + 1
WHERE idType = 23 

GO