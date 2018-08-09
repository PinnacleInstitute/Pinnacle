EXEC [dbo].pts_CheckProc 'pts_SalesStep_Delete'
 GO

CREATE PROCEDURE [dbo].pts_SalesStep_Delete ( 
   @SalesStepID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE sls
FROM SalesStep AS sls
WHERE sls.SalesStepID = @SalesStepID

GO