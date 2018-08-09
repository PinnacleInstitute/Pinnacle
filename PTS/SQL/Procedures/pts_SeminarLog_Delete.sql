EXEC [dbo].pts_CheckProc 'pts_SeminarLog_Delete'
 GO

CREATE PROCEDURE [dbo].pts_SeminarLog_Delete ( 
   @SeminarLogID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE sel
FROM SeminarLog AS sel
WHERE sel.SeminarLogID = @SeminarLogID

GO