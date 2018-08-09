EXEC [dbo].pts_CheckProc 'pts_Metric_ListMember'
GO

--EXEC pts_Metric_ListMember 6528, '1/11/13', '1/11/13'

CREATE PROCEDURE [dbo].pts_Metric_ListMember
   @MemberID int ,
   @FromDate datetime ,
   @ToDate datetime
AS

SET NOCOUNT ON

SELECT      met.MetricID, 
         met.MetricTypeID, 
         mtt.MetricTypeName AS 'MetricTypeName', 
         met.MetricDate, 
         met.Qty, 
         met.Qty * mtt.Pts 'Points',
         met.Note
FROM Metric AS met (NOLOCK)
LEFT OUTER JOIN MetricType AS mtt (NOLOCK) ON (met.MetricTypeID = mtt.MetricTypeID)
WHERE (met.MemberID = @MemberID)
 AND (met.MetricDate >= @FromDate)
 AND (met.MetricDate <= @ToDate)
 AND  met.IsGoal = 0

ORDER BY   met.MetricDate DESC, mtt.Seq

GO