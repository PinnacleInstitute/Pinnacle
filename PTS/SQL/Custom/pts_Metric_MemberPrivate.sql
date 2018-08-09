EXEC [dbo].pts_CheckProc 'pts_Metric_MemberPrivate'
 GO
--DECLARE @MaxRows int EXEC pts_Metric_MemberPrivate 7, 'sandy', '1/1/13', '12/20/13', 3

CREATE PROCEDURE [dbo].pts_Metric_MemberPrivate ( 
   @ContestID int,
   @MemberName nvarchar (60),
   @FromDate datetime,
   @ToDate datetime,
   @Rpt int
      )
AS

SET NOCOUNT ON
DECLARE @NotResult int
-- Get all Activities where IsResult != @NotResult
-- Rpt 1. Results Only ... @NotResult != 0
-- Rpt 2. Activities Only ... @NotResult != 1
-- Rpt 3. Both ... @NotResult != 2
SET @NotResult = @Rpt - 1

SELECT TOP 20 met.MemberID 'MetricID', me.NameFirst + ' ' + me.NameLast 'MemberName', SUM(met.qty*mtt.pts) 'Points'
FROM Metric AS met
JOIN MetricType AS mtt ON met.MetricTypeID = mtt.MetricTypeID
JOIN Member AS me ON met.MemberID = me.MemberID
JOIN MemberContest AS mcn ON met.MemberID = mcn.MemberID
WHERE mcn.ContestID = @ContestID
AND  met.MetricDate >= @FromDate
AND  met.MetricDate <= @ToDate
AND  mtt.IsResult != @NotResult
AND  met.IsGoal = 0
AND  ISNULL(LTRIM(RTRIM(me.NameLast)) +  ', '  + LTRIM(RTRIM(me.NameFirst)), '') LIKE '%' + @MemberName + '%'
GROUP BY met.MemberID, me.NameFirst + ' ' + me.NameLast
ORDER BY SUM(met.qty*mtt.pts) DESC

GO

