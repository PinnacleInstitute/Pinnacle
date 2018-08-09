EXEC [dbo].pts_CheckProc 'pts_BoardUser_Chat_SetData'
GO

CREATE PROCEDURE [dbo].pts_BoardUser_Chat_SetData
   @BoardUserName nvarchar(80),
   @Namespace varchar(128),
   @Tag varchar(128),
   @XMLData text
AS

SET         NOCOUNT ON

DECLARE @iXMLData int
EXEC sp_xml_preparedocument @iXMLData OUTPUT, @XMLData

--Note: ignoring @Tag for now
IF (@Namespace = 'jabber:iq:auth')
BEGIN
	DECLARE @Pass AS varchar(30)
	
	SET @Pass = (SELECT [password] 
		FROM OPENXML(@iXMLData,'/',2)
		WITH ([password] varchar(30))
	)

--PRINT @Pass

--	UPDATE BoardUser 
--	SET 	BoardUserPass = @Pass   
--	WHERE      (BoardUserName = @BoardUserName)

--last user state
END
ELSE IF (@Namespace = 'jabber:iq:last')
BEGIN
	DECLARE @DateTime AS datetime,
		@Status AS varchar(30)
	
	SET @DateTime = CURRENT_TIMESTAMP
	SET @Status = (SELECT [last] 
		FROM OPENXML(@iXMLData,'/',2)
		WITH ([last] varchar(30))
	)

--PRINT @Status

	UPDATE BoardUser  
	SET 	ChatLastStatus = @Status,
		ChatLastDateTime = @DateTime
	WHERE      (BoardUserName = @BoardUserName)

END
GO