EXEC [dbo].pts_CheckProc 'pts_SalesArea_Delete'
 GO

CREATE PROCEDURE [dbo].pts_SalesArea_Delete ( 
   @SalesAreaID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE sla
FROM SalesArea AS sla
WHERE sla.SalesAreaID = @SalesAreaID

GO