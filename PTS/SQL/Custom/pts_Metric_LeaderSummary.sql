EXEC [dbo].pts_CheckProc 'pts_Metric_LeaderSummary'
GO

CREATE PROCEDURE [dbo].pts_Metric_LeaderSummary
   @MemberID int ,
   @FromDate datetime ,
   @ToDate datetime ,
   @Rpt int
AS

SET NOCOUNT ON
DECLARE @NotResult int
-- Get all Activities where IsResult != @NotResult
-- Rpt 1. Results Only ... @NotResult != 0
-- Rpt 2. Activities Only ... @NotResult != 1
-- Rpt 3. Both ... @NotResult != 2
SET @NotResult = @Rpt - 1

SELECT mtt.MetricTypeID AS 'MetricID', 
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
AND  mtt.IsResult != @NotResult
AND  met.IsGoal = 0
GROUP BY mtt.MetricTypeID, mtt.MetricTypeID, mtt.Seq, mtt.MetricTypeName
ORDER BY mtt.Seq

GO