EXEC [dbo].pts_CheckProc 'pts_AuthLog_LogAuthUser'
GO

CREATE PROCEDURE [dbo].pts_AuthLog_LogAuthUser
   @AuthUserID int ,
   @IP varchar(15) ,
   @Total int ,
   @result int OUTPUT
AS

-- result = 0 allowed access
-- result = -1 disallowed access
-- result > 0 too many access IPs

SET NOCOUNT ON

DECLARE @mNow datetime, @mID int, @mCnt int, @mStatus int, @mTotal int

SET @mNow = GETDATE()
IF @Total = 0
	SET @Total = 3

-- Status: 1=Allow, 2=Disallow, 3=Override

SELECT @mID = ISNULL(AuthLogID,0), @mStatus = Status FROM AuthLog (NOLOCK) WHERE AuthUserID = @AuthUserID AND IP = @IP

IF @mID > 0
BEGIN
	UPDATE AuthLog SET LastDate = @mNow, Total = Total + 1 WHERE AuthLogID = @mID

	IF @mStatus = 3  --Override Allow Access
		SET @result = 0
	ELSE
	BEGIN
		IF @mStatus = 2 --Disallow Access
			SET @result = -1
		ELSE
		BEGIN
			SELECT @mCnt = Count(*) FROM AuthLog WHERE AuthUserID = @AuthUserID AND Status = 1
			IF @mCnt > @Total
				SET @result = @mCnt --Too Many IPs
			ELSE
				SET @result = 0 --Allow Access
		END
	END
END
ELSE
BEGIN
	SELECT @mCnt = Count(*) FROM AuthLog WHERE AuthUserID = @AuthUserID AND Status = 1
	IF @mCnt >= @Total
	BEGIN
		SET @result = @mCnt + 1 --Too Many IPs
		SET @mStatus = 2 --Disallow
	END
	ELSE
	BEGIN
		SET @result = 0 --Allow Access
		SET @mStatus = 1 --Allowed
	END
	INSERT INTO AuthLog ( AuthUserID, IP, LogDate, LastDate, Total, Status ) 
	VALUES ( @AuthUserID, @IP, @mNow, @mNow, 1, @mStatus )
END			
GO
