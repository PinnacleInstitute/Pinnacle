EXEC [dbo].pts_CheckProc 'pts_AuthLog_Delete'
 GO

CREATE PROCEDURE [dbo].pts_AuthLog_Delete ( 
   @AuthLogID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE aul
FROM AuthLog AS aul
WHERE aul.AuthLogID = @AuthLogID

GO