EXEC [dbo].pts_CheckProc 'pts_SeminarLog_Add'
 GO

CREATE PROCEDURE [dbo].pts_SeminarLog_Add ( 
   @SeminarLogID int OUTPUT,
   @SeminarID int,
   @LogDate datetime,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO SeminarLog (
            SeminarID , 
            LogDate
            )
VALUES (
            @SeminarID ,
            @LogDate            )

SET @mNewID = @@IDENTITY

SET @SeminarLogID = @mNewID

GO