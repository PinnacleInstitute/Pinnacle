EXEC [dbo].pts_CheckProc 'pts_Metric_LeaderSummaryCustom'
GO

CREATE PROCEDURE [dbo].pts_Metric_LeaderSummaryCustom
   @MemberID int ,
   @FromDate datetime ,
   @ToDate datetime ,
   @Custom1 int,
   @Custom2 int,
   @Custom3 int,
   @Custom4 int,
   @Custom5 int
AS

SET NOCOUNT ON

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
AND  met.MetricTypeID IN (@Custom1,@Custom2,@Custom3,@Custom4,@Custom5)
AND  met.IsGoal = 0
GROUP BY mtt.MetricTypeID, mtt.MetricTypeID, mtt.Seq, mtt.MetricTypeName
ORDER BY mtt.Seq

GO