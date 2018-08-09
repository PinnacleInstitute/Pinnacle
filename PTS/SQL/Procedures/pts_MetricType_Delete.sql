EXEC [dbo].pts_CheckProc 'pts_MetricType_Delete'
 GO

CREATE PROCEDURE [dbo].pts_MetricType_Delete ( 
   @MetricTypeID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE mtt
FROM MetricType AS mtt
WHERE mtt.MetricTypeID = @MetricTypeID

GO