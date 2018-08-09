EXEC [dbo].pts_CheckProc 'pts_AuthLog_Add'
 GO

CREATE PROCEDURE [dbo].pts_AuthLog_Add ( 
   @AuthLogID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO AuthLog (
            AuthUserID , 
            IP , 
            LogDate , 
            LastDate , 
            Total , 
            Status
            )
VALUES (
            @AuthUserID ,
            @IP ,
            @LogDate ,
            @LastDate ,
            @Total ,
            @Status            )

SET @mNewID = @@IDENTITY

SET @AuthLogID = @mNewID

GO