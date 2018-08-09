EXEC [dbo].pts_CheckProc 'pts_Metric_ListGoal'
GO

CREATE PROCEDURE [dbo].pts_Metric_ListGoal
   @MemberID int
AS

SET NOCOUNT ON

SELECT      met.MetricID, 
         met.MetricTypeID, 
         mtt.MetricTypeName AS 'MetricTypeName', 
         met.MetricDate, 
         met.Qty, 
         met.Note

FROM Metric AS met (NOLOCK)
LEFT OUTER JOIN MetricType AS mtt (NOLOCK) ON (met.MetricTypeID = mtt.MetricTypeID)
WHERE met.MemberID = @MemberID AND met.IsGoal <> 0

ORDER BY mtt.Seq

GO