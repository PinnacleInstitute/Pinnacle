EXEC [dbo].pts_CheckProc 'pts_AuthLog_LogIP'
GO

--DECLARE @result int EXEC pts_AuthLog_LogIP '1.1.1.1', @result OUTPUT PRINT @result

CREATE PROCEDURE [dbo].pts_AuthLog_LogIP
   @IP varchar(15) ,
   @result int OUTPUT
AS

-- result = 0 allowed access
-- result = -1 disallowed access

SET NOCOUNT ON

DECLARE @mID int

SET @result = 0

SELECT @mID = ISNULL(AuthLogID,0) FROM AuthLog (NOLOCK) WHERE AuthUserID = 0 AND IP = @IP AND Status = 2

IF @mID > 0 SET @result = -1 

GO
