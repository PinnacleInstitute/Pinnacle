EXEC [dbo].pts_CheckProc 'pts_Metric_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Metric_Delete ( 
   @MetricID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE met
FROM Metric AS met
WHERE met.MetricID = @MetricID

GO