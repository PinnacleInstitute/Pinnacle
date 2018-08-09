EXEC [dbo].pts_CheckProc 'pts_BoardUser_Chat_GetData'
GO

CREATE PROCEDURE [dbo].pts_BoardUser_Chat_GetData
   @BoardUserName nvarchar(80),
   @Namespace varchar(128),
   @Tag varchar(128)
AS

SET         NOCOUNT ON

--Note: ignoring @Tag for now

SELECT    CASE
	WHEN (@Namespace = 'jabber:iq:auth') 
	THEN ('<password xmlns="jabber:iq:auth">'+au.[Password]+'</password>')
	WHEN (@Namespace = 'preferences:general') 
	THEN '<query xmlns="jabber:iq:private"><JAJC xmlns="preferences:general" /></query>'
	WHEN (@Namespace = 'jabber:iq:last') 
	THEN ('<last time="'+CAST(mbu.ChatLastDateTime AS varchar(30))+'">'+mbu.ChatLastStatus+'</last>')
	END
	AS 'XMLData'  
FROM      BoardUser AS mbu (NOLOCK)
LEFT OUTER JOIN AuthUser AS au ON (mbu.AuthUserID = au.AuthUserID)
WHERE      (mbu.BoardUserName = @BoardUserName)

--Return data as 'XMLData'
GO