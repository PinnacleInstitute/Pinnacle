EXEC [dbo].pts_CheckProc 'pts_Commission_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Commission_Delete ( 
   @CommissionID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE co
FROM Commission AS co
WHERE co.CommissionID = @CommissionID

GO