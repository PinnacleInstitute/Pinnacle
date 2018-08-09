EXEC [dbo].pts_CheckProc 'pts_AuthLog_LogLead'
GO

--DECLARE @result int EXEC pts_AuthLog_LogLead '192.36.21.4', 1, @result OUTPUT PRINT @result
--select * from AuthLog order by AuthLogID desc
--delete AuthLog where AuthUserID = -1 AND LogDate < dbo.wtfn_DateOnly(GETDATE())
--select * from authlog where status = 37720
--delete authlog where status = 37720

CREATE PROCEDURE [dbo].pts_AuthLog_LogLead
   @IP varchar(15) ,
   @AuthUserID int ,
   @result int OUTPUT
AS

-- Lead Page IP Monitoring
-- Check for an IP address accessing multiple Member's lead pages on the same day
-- result = member to access 

SET NOCOUNT ON

DECLARE @MemberID int, @mNow datetime, @mToday datetime, @mID int, @Total int
SET @mNow = GETDATE()
SET @mToday = dbo.wtfn_DateOnly( @mNow )

SELECT @mID = ISNULL(AuthLogID,0), @MemberID = Status, @Total = Total FROM AuthLog (NOLOCK) WHERE AuthUserID = -1 AND IP = @IP AND dbo.wtfn_DateOnly( LogDate ) = @mToday

IF @mID > 0
BEGIN
	UPDATE AuthLog SET LastDate = @mNow, Total = Total + 1 WHERE AuthLogID = @mID
	IF @Total < 3 SET @MemberID = @AuthUserID
END
ELSE
BEGIN
	SET @MemberID = @AuthUserID
	INSERT INTO AuthLog ( AuthUserID, IP, LogDate, LastDate, Total, Status ) 
	VALUES ( -1, @IP, @mNow, @mNow, 1, @MemberID )
END

SET @result = @MemberID

GO
