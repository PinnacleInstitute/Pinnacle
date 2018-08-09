EXEC [dbo].pts_CheckProc 'pts_Metric_MemberSummary'
GO

--EXEC pts_Metric_MemberSummary 6528, '1/1/13', '2/1/13'

CREATE PROCEDURE [dbo].pts_Metric_MemberSummary
   @MemberID int ,
   @FromDate datetime ,
   @ToDate datetime
AS

SET NOCOUNT ON

SELECT   mtt.MetricTypeID AS 'MetricID', 
         mtt.MetricTypeID AS 'MetricTypeID', 
         mtt.Seq AS 'Seq', 
         mtt.MetricTypeName AS 'MetricTypeName',
         SUM(met.Qty) AS 'Qty', 
         SUM(mtt.Pts * met.Qty) AS 'Points'
FROM Metric AS met (NOLOCK)
LEFT OUTER JOIN MetricType AS mtt (NOLOCK) ON (met.MetricTypeID = mtt.MetricTypeID)
WHERE (met.MemberID = @MemberID)
AND (met.MetricDate >= @FromDate)
AND (met.MetricDate <= @ToDate)
AND  met.IsGoal = 0

GROUP BY mtt.MetricTypeID, mtt.MetricTypeID, mtt.Seq, mtt.MetricTypeName
ORDER BY mtt.Seq

GO