EXEC [dbo].pts_CheckProc 'pts_Msg_MemberMsgs'
GO

CREATE PROCEDURE [dbo].pts_Msg_MemberMsgs
   @MemberID int ,
   @MsgDate datetime ,
   @Num int
AS

SET NOCOUNT ON

DECLARE @NewOnly int, @IsMsgs int
SET @NewOnly = @Num
SET @IsMsgs = 1

IF @NewOnly = 1
BEGIN
	SELECT @IsMsgs = IsMsgs FROM Member WHERE MemberID = @MemberID
	IF @IsMsgs = 1
		UPDATE Member SET IsMsgs = 0 WHERE MemberID = @MemberID
END 

IF @IsMsgs = 1
BEGIN
	SELECT mg.MsgID, 
	       mg.MsgDate, 
	       mg.Subject, 
	       mg.Message, 
	       LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)) AS 'UserName'
	FROM   Msg AS mg (NOLOCK)
	LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (mg.AuthUserID = au.AuthUserID)
	WHERE  mg.OwnerType = 4
	 AND   mg.OwnerID = @MemberID
	 AND   mg.MsgDate > @MsgDate
	ORDER BY mg.MsgDate DESC, mg.MsgID DESC
END
ELSE
BEGIN
--	-- Return an Empty Set
	SELECT 0 AS 'MsgID', 
	       0 AS 'MsgDate', 
	       '' AS 'Subject', 
	       '' AS 'Message', 
	       '' AS 'UserName'
	WHERE 1=2
END

GO