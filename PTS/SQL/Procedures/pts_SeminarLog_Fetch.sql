EXEC [dbo].pts_CheckProc 'pts_SeminarLog_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_SeminarLog_Fetch ( 
   @SeminarLogID int,
   @SeminarID int OUTPUT,
   @LogDate datetime OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @SeminarID = sel.SeminarID ,
   @LogDate = sel.LogDate
FROM SeminarLog AS sel (NOLOCK)
WHERE sel.SeminarLogID = @SeminarLogID

GO