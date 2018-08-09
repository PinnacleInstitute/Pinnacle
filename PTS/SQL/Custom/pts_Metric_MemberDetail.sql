EXEC [dbo].pts_CheckProc 'pts_Metric_MemberDetail'
GO

--EXEC pts_Metric_MemberDetail 6528, 3, '1/4/2013', '1/12/2013'

CREATE PROCEDURE [dbo].pts_Metric_MemberDetail
   @MemberID int ,
   @MetricTypeID int ,
   @FromDate datetime ,
   @ToDate datetime
AS

SET NOCOUNT ON

SELECT   met.MetricID AS 'MetricID', 
         met.MetricDate AS 'MetricDate', 
         met.Qty AS 'Qty', 
         mtt.Pts * met.Qty AS 'Points',
         met.Note AS 'Note'
FROM Metric AS met (NOLOCK)
LEFT OUTER JOIN MetricType AS mtt (NOLOCK) ON (met.MetricTypeID = mtt.MetricTypeID)
WHERE (met.MemberID = @MemberID)
 AND met.MetricTypeID = @MetricTypeID
 AND met.MetricDate >= @FromDate
 AND met.MetricDate <= @ToDate
 AND met.IsGoal = 0
ORDER BY met.MetricDate DESC

GO