EXEC [dbo].pts_CheckProc 'pts_Metric_LeaderGroupPoints'
 GO
--DECLARE @MaxRows int EXEC pts_Metric_LeaderGroupPoints '', '', @MaxRows, 0, '2/1/13', '2/20/13', 1, 1
--DECLARE @MaxRows int EXEC pts_Metric_LeaderGroupPoints '', '', @MaxRows, 6528, '1/1/13', '1/31/13', 1, 1
--DECLARE @MaxRows int EXEC pts_Metric_LeaderGroupPoints '', '00000000300000006811', @MaxRows, 6528, '1/1/13', '1/31/13', 1, 1

CREATE PROCEDURE [dbo].pts_Metric_LeaderGroupPoints ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @GroupID int,
   @FromDate datetime,
   @ToDate datetime,
   @Rpt int,
   @UserID int
      )
AS

SET NOCOUNT ON
DECLARE @NotResult int
-- Get all Activities where IsResult != @NotResult
-- Rpt 1. Results Only ... @NotResult != 0
-- Rpt 2. Activities Only ... @NotResult != 1
-- Rpt 3. Both ... @NotResult != 2
SET @NotResult = @Rpt - 1

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
	AND  mtt.IsResult != @NotResult
	AND  met.IsGoal = 0
	GROUP BY met.MemberID, me.NameFirst + ' ' + me.NameLast
	ORDER BY SUM(met.qty*mtt.pts) DESC
) AS tmp
WHERE dbo.wtfn_FormatNumber(tmp.Points, 10) + dbo.wtfn_FormatNumber(tmp.MemberID, 10) <= @BookMark
ORDER BY 'Bookmark' DESC

GO

