EXEC [dbo].pts_CheckProc 'pts_Metric_MemberTotal'
GO

--DECLARE @Qty int,@Points int,@Rank int
--EXEC pts_Metric_MemberTotal 6736, '1/21/13', '1/24/13', @Qty OUTPUT, @Points OUTPUT, @Rank OUTPUT
--PRINT 'Pnts: ' + CAST(@Points AS VARCHAR(10))
--PRINT 'Rank: ' + CAST(@Rank AS VARCHAR(10))

CREATE PROCEDURE [dbo].pts_Metric_MemberTotal
   @MemberID int ,
   @FromDate datetime ,
   @ToDate datetime ,
   @Qty int OUTPUT ,
   @Points int OUTPUT ,
   @MetricTypeID int OUTPUT
AS

SET NOCOUNT ON
DECLARE @mQty int, @mPoints int, @Rank int, @CompanyID int

SELECT @mQty = SUM(met.qty), @mPoints = SUM(met.qty*mtt.pts)
FROM Metric AS met
JOIN MetricType AS mtt ON met.MetricTypeID = mtt.MetricTypeID
WHERE met.MemberID = @MemberID
AND   met.MetricDate >= @FromDate
AND   met.MetricDate <= @ToDate
AND   met.IsGoal = 0

-- Get Ranking
SELECT @CompanyID = CompanyID FROM Member WHERE MemberID = @MemberID

SELECT @Rank = COUNT(*)
FROM
(
	SELECT met.MemberID, SUM(met.qty*mtt.pts) 'Points'
	FROM Metric AS met
	JOIN MetricType AS mtt ON met.MetricTypeID = mtt.MetricTypeID
	JOIN Member AS me ON met.MemberID = me.MemberID
	WHERE me.CompanyID = @CompanyID
	AND  met.MetricDate >= @FromDate
	AND  met.MetricDate <= @ToDate
	AND  met.IsGoal = 0
	GROUP BY met.MemberID
) AS tmp
WHERE tmp.Points > @mPoints

SET @Qty = ISNULL(@mQty, 0)
SET @Points = ISNULL(@mPoints, 0)
SET @MetricTypeID = ISNULL(@Rank+1, 0)

GO