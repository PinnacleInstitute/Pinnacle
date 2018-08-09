EXEC [dbo].pts_CheckProc 'pts_AuthLog_Update'
 GO

CREATE PROCEDURE [dbo].pts_AuthLog_Update ( 
   @AuthLogID int,
   @AuthUserID int,
   @IP varchar (15),
   @LogDate datetime,
   @LastDate datetime,
   @Total int,
   @Status int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE aul
SET aul.AuthUserID = @AuthUserID ,
   aul.IP = @IP ,
   aul.LogDate = @LogDate ,
   aul.LastDate = @LastDate ,
   aul.Total = @Total ,
   aul.Status = @Status
FROM AuthLog AS aul
WHERE aul.AuthLogID = @AuthLogID

GO