EXEC [dbo].pts_CheckProc 'pts_AuthLog_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_AuthLog_Fetch ( 
   @AuthLogID int,
   @AuthUserID int OUTPUT,
   @IP varchar (15) OUTPUT,
   @LogDate datetime OUTPUT,
   @LastDate datetime OUTPUT,
   @Total int OUTPUT,
   @Status int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @AuthUserID = aul.AuthUserID ,
   @IP = aul.IP ,
   @LogDate = aul.LogDate ,
   @LastDate = aul.LastDate ,
   @Total = aul.Total ,
   @Status = aul.Status
FROM AuthLog AS aul (NOLOCK)
WHERE aul.AuthLogID = @AuthLogID

GO