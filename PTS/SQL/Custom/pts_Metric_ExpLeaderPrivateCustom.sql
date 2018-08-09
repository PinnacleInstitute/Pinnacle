EXEC [dbo].pts_CheckProc 'pts_Metric_ExpLeaderPrivateCustom'
 GO

--EXEC pts_Metric_ExpLeaderPrivateCustom 16, '1/1/13', '1/1/14', 2
--select * from Contest

CREATE PROCEDURE [dbo].pts_Metric_ExpLeaderPrivateCustom ( 
   @ContestID int,
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

SELECT TOP 200 me.MemberID 'MetricID', SUM(met.qty*mtt.pts) 'Points',
 me.NameFirst + ' ' + me.NameLast + ', ' + me.Phone1 + ', ' + me.Email AS 'InputOptions' 
FROM Metric AS met
JOIN MetricType AS mtt ON met.MetricTypeID = mtt.MetricTypeID
JOIN Member AS me ON met.MemberID = me.MemberID
JOIN MemberContest AS mcn ON met.MemberID = mcn.MemberID
WHERE mcn.ContestID = @ContestID
AND   met.MetricDate >= @FromDate
AND   met.MetricDate <= @ToDate
AND  met.MetricTypeID IN (@Custom1,@Custom2,@Custom3,@Custom4,@Custom5)
AND   met.IsGoal = 0
GROUP BY me.MemberID, me.NameFirst, me.NameLast, me.Phone1, me.Email 
ORDER BY SUM(met.qty*mtt.pts) DESC

GO
