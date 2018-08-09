EXEC [dbo].pts_CheckProc 'pts_Metric_MemberPrivateCustom'
 GO
--DECLARE @MaxRows int EXEC pts_Metric_MemberPrivateCustom 7, 'sandy', '1/1/13', '12/20/13', 3

CREATE PROCEDURE [dbo].pts_Metric_MemberPrivateCustom ( 
   @ContestID int,
   @MemberName nvarchar (60),
   @FromDate datetime,
   @ToDate datetime,
   @Custom1 int,
   @Custom2 int,
   @Custom3 int,
   @Custom4 int,
   @Custom5 int
      )
AS

SET NOCOUNT ON

SELECT TOP 20 met.MemberID 'MetricID', me.NameFirst + ' ' + me.NameLast 'MemberName', SUM(met.qty*mtt.pts) 'Points'
FROM Metric AS met
JOIN MetricType AS mtt ON met.MetricTypeID = mtt.MetricTypeID
JOIN Member AS me ON met.MemberID = me.MemberID
JOIN MemberContest AS mcn ON met.MemberID = mcn.MemberID
WHERE mcn.ContestID = @ContestID
AND  met.MetricDate >= @FromDate
AND  met.MetricDate <= @ToDate
AND  met.MetricTypeID IN (@Custom1,@Custom2,@Custom3,@Custom4,@Custom5)
AND  met.IsGoal = 0
AND  ISNULL(LTRIM(RTRIM(me.NameLast)) +  ', '  + LTRIM(RTRIM(me.NameFirst)), '') LIKE '%' + @MemberName + '%'
GROUP BY met.MemberID, me.NameFirst + ' ' + me.NameLast
ORDER BY SUM(met.qty*mtt.pts) DESC

GO

