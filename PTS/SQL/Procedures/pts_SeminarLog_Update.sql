EXEC [dbo].pts_CheckProc 'pts_SeminarLog_Update'
 GO

CREATE PROCEDURE [dbo].pts_SeminarLog_Update ( 
   @SeminarLogID int,
   @SeminarID int,
   @LogDate datetime,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE sel
SET sel.SeminarID = @SeminarID ,
   sel.LogDate = @LogDate
FROM SeminarLog AS sel
WHERE sel.SeminarLogID = @SeminarLogID

GO