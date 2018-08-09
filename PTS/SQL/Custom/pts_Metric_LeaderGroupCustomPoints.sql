EXEC [dbo].pts_CheckProc 'pts_Metric_LeaderGroupCustomPoints'
 GO
--DECLARE @MaxRows int EXEC pts_Metric_LeaderGroupCustomPoints '', '', @MaxRows, 0, '2/1/13', '2/20/13', 1, 1
--DECLARE @MaxRows int EXEC pts_Metric_LeaderGroupCustomPoints '', '', @MaxRows, 6528, '1/1/13', '1/31/13', 1, 1
--DECLARE @MaxRows int EXEC pts_Metric_LeaderGroupCustomPoints '', '00000000300000006811', @MaxRows, 6528, '1/1/13', '1/31/13', 1, 1

CREATE PROCEDURE [dbo].pts_Metric_LeaderGroupCustomPoints ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @GroupID int,
   @FromDate datetime,
   @ToDate datetime,
   @Custom1 int,
   @Custom2 int,
   @Custom3 int,
   @Custom4 int,
   @Custom5 int,
   @UserID int
      )
AS

SET NOCOUNT ON

SET @MaxRows = 20

IF @Bookmark = '' BEGIN SET @Bookmark = '9999999999' END

SELECT TOP 21
   dbo.wtfn_FormatNumber(tmp.Points, 10) + dbo.wtfn_FormatNumber(tmp.MemberID, 10) 'BookMark' ,
   tmp.MemberID 'MetricID' ,
   tmp.MemberName 'MemberName' ,
   tmp.Points 'Points'
FROM
(
	SELECT TOP 200 met.MemberID 'MemberID', me.NameFirst + ' ' + me.NameLast 'MemberName', SUM(met.qty*mtt.pts) 'Points'
	FROM Metric AS met
	JOIN MetricType AS mtt ON met.MetricTypeID = mtt.MetricTypeID
	JOIN Member AS me ON met.MemberID = me.MemberID
	WHERE  me.GroupID = @GroupID
	AND  met.MetricDate >= @FromDate
	AND  met.MetricDate <= @ToDate
	AND   met.MetricTypeID IN (@Custom1,@Custom2,@Custom3,@Custom4,@Custom5)
	AND  met.IsGoal = 0
	GROUP BY met.MemberID, me.NameFirst + ' ' + me.NameLast
	ORDER BY SUM(met.qty*mtt.pts) DESC
) AS tmp
WHERE dbo.wtfn_FormatNumber(tmp.Points, 10) + dbo.wtfn_FormatNumber(tmp.MemberID, 10) <= @BookMark
ORDER BY 'Bookmark' DESC

GO

