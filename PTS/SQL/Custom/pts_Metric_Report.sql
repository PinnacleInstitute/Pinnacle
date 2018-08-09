EXEC [dbo].pts_CheckProc 'pts_Metric_Report'
GO
--10 - 6528 - 12/12/2012 - 5/31/2013 - 10,80,450,800
--EXEC pts_Metric_Report 41, 6528, '12/12/12', '5/31/13', 'month'
--EXEC pts_Metric_Report 45, 6591, '1/1/13', '12/31/13', 'month'

CREATE PROCEDURE [dbo].pts_Metric_Report
   @Rpt int ,
   @MemberID int ,
   @FromDate datetime ,
   @ToDate datetime ,
   @Unit nvarchar (40) 
AS

SET NOCOUNT ON
DECLARE @IsLeader int, @IsResult int, @GoalType int
DECLARE @Tracks varchar(100), @pts1 money, @pts2 money, @pts3 money, @pts4 money, @cnt int, @pos int, @pts int, @Days int

-- Add one day to the ToDate and get all before the toDate
SET @ToDate = DATEADD( day, 1, dbo.wtfn_DateOnly(@ToDate) )

-- 1 Activity Summary 
IF @Rpt = 1
BEGIN
	SELECT 	metric.Category AS 'MetricID' ,
			metric.Qty AS 'Qty', 
			'1-' + CAST(metric.Category AS VARCHAR(2)) AS 'Note',
			SUM(metric.Points) AS 'Points' 
	FROM (
		SELECT
			met.MetricID,
			0 AS 'Qty',
			CASE  
			WHEN mtt.IsResult = 1 AND mtt.IsLeader = 0 THEN 1 -- Personal Results
			WHEN mtt.IsResult = 1 AND mtt.IsLeader = 1 THEN 2 -- Leadership Results
			WHEN mtt.IsResult = 0 AND mtt.IsLeader = 0 THEN 3 -- Personal Activities 
			WHEN mtt.IsResult = 0 AND mtt.IsLeader = 1 THEN 4 -- Leadership Activities
			END AS 'Category',
			met.Qty * mtt.Pts AS 'Points'
		FROM METRIC AS met 
		JOIN MetricType AS mtt ON met.MetricTypeID = mtt.MetricTypeID
		WHERE met.MemberID = @MemberID AND met.MetricDate >= @FromDate AND met.MetricDate < @ToDate AND met.IsGoal = 0
	) AS metric
	GROUP BY metric.Qty, metric.Category
	ORDER BY metric.Category
END

-- 11 System Activity Summary
IF @Rpt = 11
BEGIN
	SELECT 	metric.Category AS 'MetricID' ,
			metric.Qty AS 'Qty', 
			'1-' + CAST(metric.Category AS VARCHAR(2)) AS 'Note',
			SUM(metric.Points) AS 'Points' 
	FROM (
		SELECT
			met.MetricID,
			0 AS 'Qty',
			CASE  
			WHEN mtt.IsResult = 1 AND mtt.IsLeader = 0 THEN 1 -- Personal Results
			WHEN mtt.IsResult = 1 AND mtt.IsLeader = 1 THEN 2 -- Leadership Results
			WHEN mtt.IsResult = 0 AND mtt.IsLeader = 0 THEN 3 -- Personal Activities 
			WHEN mtt.IsResult = 0 AND mtt.IsLeader = 1 THEN 4 -- Leadership Activities
			END AS 'Category',
			met.Qty * mtt.Pts AS 'Points'
		FROM METRIC AS met 
		JOIN MetricType AS mtt ON met.MetricTypeID = mtt.MetricTypeID
		JOIN Member AS me ON met.MemberID = me.MemberID
		WHERE me.GroupID = @MemberID AND met.MetricDate >= @FromDate AND met.MetricDate < @ToDate AND met.IsGoal = 0
	) AS metric
	GROUP BY metric.Qty, metric.Category
	ORDER BY metric.Category
END

-- 31 Team Activity Summary
IF @Rpt = 31
BEGIN
	SELECT 	metric.Category AS 'MetricID' ,
			metric.Qty AS 'Qty', 
			'1-' + CAST(metric.Category AS VARCHAR(2)) AS 'Note',
			SUM(metric.Points) AS 'Points' 
	FROM (
		SELECT
			met.MetricID,
			0 AS 'Qty',
			CASE
			WHEN mtt.IsResult = 1 AND mtt.IsLeader = 0 THEN 1 -- Personal Results
			WHEN mtt.IsResult = 1 AND mtt.IsLeader = 1 THEN 2 -- Leadership Results
			WHEN mtt.IsResult = 0 AND mtt.IsLeader = 0 THEN 3 -- Personal Activities 
			WHEN mtt.IsResult = 0 AND mtt.IsLeader = 1 THEN 4 -- Leadership Activities
			END AS 'Category',
			met.Qty * mtt.Pts AS 'Points'
		FROM METRIC AS met 
		JOIN MetricType AS mtt ON met.MetricTypeID = mtt.MetricTypeID
		JOIN MemberContest AS mec ON met.MemberID = mec.MemberID
		JOIN Contest AS con ON mec.ContestID = con.ContestID
		WHERE con.MemberID = @MemberID AND con.IsPrivate != 0 AND met.MetricDate >= @FromDate AND met.MetricDate < @ToDate AND met.IsGoal = 0
	) AS metric
	GROUP BY metric.Qty, metric.Category
	ORDER BY metric.Category
END

-- 2 Personal Summary
IF @Rpt = 2 OR @Rpt = 3
BEGIN
	IF @Rpt = 2 SET @IsLeader = 0 Else SET @IsLeader = 1

	SELECT 	metric.MetricTypeID AS 'MetricID' ,
			metric.IsResult AS 'Qty',
			metric.MetricTypeName AS 'Note',
			SUM(metric.Points) AS 'Points' 
	FROM (
		SELECT
			mtt.MetricTypeID,
			mtt.IsResult,
			mtt.MetricTypeName,
			met.Qty * mtt.Pts AS 'Points'
		FROM METRIC AS met 
		JOIN MetricType AS mtt ON met.MetricTypeID = mtt.MetricTypeID
		WHERE met.MemberID = @MemberID AND met.MetricDate >= @FromDate AND met.MetricDate < @ToDate AND mtt.IsLeader = @IsLeader AND met.IsGoal = 0
	) AS metric
	GROUP BY metric.MetricTypeID, metric.IsResult, metric.MetricTypeName
	ORDER BY Points
END

-- 12 System Personal Summary
IF @Rpt = 12 OR @Rpt = 13
BEGIN
	IF @Rpt = 12 SET @IsLeader = 0 Else SET @IsLeader = 1

	SELECT 	metric.MetricTypeID AS 'MetricID' ,
			metric.IsResult AS 'Qty',
			metric.MetricTypeName AS 'Note',
			SUM(metric.Points) AS 'Points' 
	FROM (
		SELECT
			mtt.MetricTypeID,
			mtt.IsResult,
			mtt.MetricTypeName,
			met.Qty * mtt.Pts AS 'Points'
		FROM METRIC AS met 
		JOIN MetricType AS mtt ON met.MetricTypeID = mtt.MetricTypeID
		JOIN Member AS me ON met.MemberID = me.MemberID
		WHERE me.GroupID = @MemberID AND met.MetricDate >= @FromDate AND met.MetricDate < @ToDate AND mtt.IsLeader = @IsLeader AND met.IsGoal = 0
	) AS metric
	GROUP BY metric.MetricTypeID, metric.IsResult, metric.MetricTypeName
	ORDER BY Points
END

-- 32 Team Personal Summary
IF @Rpt = 32 OR @Rpt = 33
BEGIN
	IF @Rpt = 12 SET @IsLeader = 0 Else SET @IsLeader = 1

	SELECT 	metric.MetricTypeID AS 'MetricID' ,
			metric.IsResult AS 'Qty',
			metric.MetricTypeName AS 'Note',
			SUM(metric.Points) AS 'Points' 
	FROM (
		SELECT
			mtt.MetricTypeID,
			mtt.IsResult,
			mtt.MetricTypeName,
			met.Qty * mtt.Pts AS 'Points'
		FROM METRIC AS met 
		JOIN MetricType AS mtt ON met.MetricTypeID = mtt.MetricTypeID
		JOIN MemberContest AS mec ON met.MemberID = mec.MemberID
		JOIN Contest AS con ON mec.ContestID = con.ContestID
		WHERE con.MemberID = @MemberID AND con.IsPrivate != 0 AND met.MetricDate >= @FromDate AND met.MetricDate < @ToDate AND mtt.IsLeader = @IsLeader AND met.IsGoal = 0
	) AS metric
	GROUP BY metric.MetricTypeID, metric.IsResult, metric.MetricTypeName
	ORDER BY Points
END

-- 4 Personal Progress
IF @Rpt = 4 OR @Rpt = 5
BEGIN
	IF @Rpt = 4 SET @IsLeader = 0 Else SET @IsLeader = 1
	 
	SELECT 	metric.category 'MetricID',
			metric.Qty AS 'Qty', 
			CAST(metric.Category AS VARCHAR(10)) AS 'Note',
			SUM(metric.Points) AS 'Points' 
	FROM (
		SELECT
			1 AS 'Qty',
			met.MetricDate 'MetricDate',
			CASE @Unit
			WHEN 'year' THEN 
				YEAR(met.MetricDate) 
			WHEN 'quarter' THEN 
				DATEPART( q, met.MetricDate )
			WHEN 'month' THEN 
				MONTH(met.MetricDate)
			WHEN 'week' THEN 
				DATEPART( wk, met.MetricDate )
			WHEN 'day' THEN 
				DAY(met.MetricDate)
			END AS 'Category',
			met.Qty * mtt.Pts AS 'Points'
		FROM METRIC AS met 
		JOIN MetricType AS mtt ON met.MetricTypeID = mtt.MetricTypeID
		WHERE met.MemberID = @MemberID AND met.MetricDate >= @FromDate AND met.MetricDate < @ToDate AND mtt.IsLeader = @IsLeader AND mtt.IsResult != 0 AND met.IsGoal = 0
	) AS metric
	GROUP BY metric.Qty, metric.Category
	UNION
	SELECT 	metric.category + 1000 'MetricID',
			metric.Qty AS 'Qty', 
			CAST(metric.Category AS VARCHAR(10)) AS 'Note',
			SUM(metric.Points) AS 'Points' 
	FROM (
		SELECT
			0 AS 'Qty',
			met.MetricDate 'MetricDate',
			CASE @Unit
			WHEN 'year' THEN 
				YEAR(met.MetricDate) 
			WHEN 'quarter' THEN 
				DATEPART( q, met.MetricDate )
			WHEN 'month' THEN 
				MONTH(met.MetricDate)
			WHEN 'week' THEN 
				DATEPART( wk, met.MetricDate )
			WHEN 'day' THEN 
				DAY(met.MetricDate)
			END AS 'Category',
			met.Qty * mtt.Pts AS 'Points'
		FROM METRIC AS met 
		JOIN MetricType AS mtt ON met.MetricTypeID = mtt.MetricTypeID
		WHERE met.MemberID = @MemberID AND met.MetricDate >= @FromDate AND met.MetricDate < @ToDate AND mtt.IsLeader = @IsLeader AND mtt.IsResult = 0 AND met.IsGoal = 0
	) AS metric
	GROUP BY metric.Qty, metric.Category
	ORDER BY 'MetricID'
END

-- 41-45 Goal Reports
IF @Rpt = 41 OR @Rpt = 42 OR @Rpt = 43 OR @Rpt = 44 OR @Rpt = 45
BEGIN
	SET @IsResult = 1
	SET @IsLeader = 1
	IF @Rpt = 42 OR @Rpt = 44 SET @IsResult = 0
	IF @Rpt = 41 OR @Rpt = 42 SET @IsLeader = 0
	IF @Rpt = 41 SET @GoalType = -1
	IF @Rpt = 42 SET @GoalType = -2
	IF @Rpt = 43 SET @GoalType = -3
	IF @Rpt = 44 SET @GoalType = -4
	IF @Rpt = 45 SET @GoalType = -5
	 
	SELECT 	metric.category 'MetricID',
			metric.Qty AS 'Qty', 
			CAST(metric.Category AS VARCHAR(10)) AS 'Note',
			SUM(metric.Points) AS 'Points' 
	FROM (
		SELECT
			1 AS 'Qty',
			met.MetricDate 'MetricDate',
			CASE @Unit
			WHEN 'year' THEN 
				YEAR(met.MetricDate) 
			WHEN 'quarter' THEN 
				DATEPART( q, met.MetricDate )
			WHEN 'month' THEN 
				MONTH(met.MetricDate)
			WHEN 'week' THEN 
				DATEPART( wk, met.MetricDate )
			WHEN 'day' THEN 
				DAY(met.MetricDate)
			END AS 'Category',
			met.Qty * mtt.Pts AS 'Points'
		FROM METRIC AS met 
		JOIN MetricType AS mtt ON met.MetricTypeID = mtt.MetricTypeID
		WHERE met.MemberID = @MemberID AND met.MetricDate >= @FromDate AND met.MetricDate < @ToDate AND met.IsGoal = 0
		AND ( @Rpt = 45 OR (mtt.IsLeader = @IsLeader AND mtt.IsResult = @IsResult) )
	) AS metric
	GROUP BY metric.Qty, metric.Category
	UNION
	SELECT 	MetricID AS 'MetricID',
		0 AS 'Qty', 
		CASE 
		WHEN MetricDate < @FromDate THEN
			CASE @Unit
			WHEN 'year' THEN YEAR( @FromDate ) 
			WHEN 'quarter' THEN DATEPART( q, @FromDate )
			WHEN 'month' THEN MONTH(@FromDate)
			WHEN 'week' THEN DATEPART( wk, @FromDate )
			WHEN 'day' THEN DAY(@FromDate)
			END
		ELSE	
			CASE @Unit
			WHEN 'year' THEN YEAR( MetricDate ) 
			WHEN 'quarter' THEN DATEPART( q, MetricDate )
			WHEN 'month' THEN MONTH(MetricDate)
			WHEN 'week' THEN DATEPART( wk, MetricDate )
			WHEN 'day' THEN DAY(MetricDate)
			END
		END AS 'Note',
		CASE 
		WHEN Note = '1' THEN
			CASE @Unit
			WHEN 'year' THEN Qty * 52
			WHEN 'quarter' THEN Qty * 13
			WHEN 'month' THEN Qty * 4 
			WHEN 'week' THEN Qty 
			WHEN 'day' THEN Qty / 7 
			END
		ELSE	
			CASE @Unit
			WHEN 'year' THEN Qty * 12
			WHEN 'quarter' THEN Qty * 3
			WHEN 'month' THEN Qty 
			WHEN 'week' THEN Qty / 4
			WHEN 'day' THEN Qty / 30 
			END
		END AS 'Points'
	FROM Metric
	WHERE MemberID = @MemberID AND MetricTypeID = @GoalType AND IsGoal != 0 AND MetricDate <= @ToDate
	ORDER BY 'MetricID'
END

-- 14 System Personal Progress
IF @Rpt = 14 OR @Rpt = 15
BEGIN
	IF @Rpt = 14 SET @IsLeader = 0 Else SET @IsLeader = 1
	 
	SELECT 	metric.category 'MetricID',
			metric.Qty AS 'Qty', 
			CAST(metric.Category AS VARCHAR(10)) AS 'Note',
			SUM(metric.Points) AS 'Points' 
	FROM (
		SELECT
			1 AS 'Qty',
			met.MetricDate 'MetricDate',
			CASE @Unit
			WHEN 'year' THEN 
				YEAR(met.MetricDate) 
			WHEN 'quarter' THEN 
				DATEPART( q, met.MetricDate )
			WHEN 'month' THEN 
				MONTH(met.MetricDate)
			WHEN 'week' THEN 
				DATEPART( wk, met.MetricDate )
			WHEN 'day' THEN 
				DAY(met.MetricDate)
			END AS 'Category',
			met.Qty * mtt.Pts AS 'Points'
		FROM METRIC AS met 
		JOIN MetricType AS mtt ON met.MetricTypeID = mtt.MetricTypeID
		JOIN Member AS me ON met.MemberID = me.MemberID
		WHERE me.GroupID = @MemberID AND met.MetricDate >= @FromDate AND met.MetricDate < @ToDate AND mtt.IsLeader = @IsLeader AND mtt.IsResult != 0 AND met.IsGoal = 0
	) AS metric
	GROUP BY metric.Qty, metric.Category
	UNION
	SELECT 	metric.category + 1000 'MetricID',
			metric.Qty AS 'Qty', 
			CAST(metric.Category AS VARCHAR(10)) AS 'Note',
			SUM(metric.Points) AS 'Points' 
	FROM (
		SELECT
			0 AS 'Qty',
			met.MetricDate 'MetricDate',
			CASE @Unit
			WHEN 'year' THEN 
				YEAR(met.MetricDate) 
			WHEN 'quarter' THEN 
				DATEPART( q, met.MetricDate )
			WHEN 'month' THEN 
				MONTH(met.MetricDate)
			WHEN 'week' THEN 
				DATEPART( wk, met.MetricDate )
			WHEN 'day' THEN 
				DAY(met.MetricDate)
			END AS 'Category',
			met.Qty * mtt.Pts AS 'Points'
		FROM METRIC AS met 
		JOIN MetricType AS mtt ON met.MetricTypeID = mtt.MetricTypeID
		JOIN Member AS me ON met.MemberID = me.MemberID
		WHERE me.GroupID = @MemberID AND met.MetricDate >= @FromDate AND met.MetricDate < @ToDate AND mtt.IsLeader = @IsLeader AND mtt.IsResult = 0 AND met.IsGoal = 0
	) AS metric
	GROUP BY metric.Qty, metric.Category
	ORDER BY metric.Category
END

-- 34 Team Personal Progress
IF @Rpt = 34 OR @Rpt = 35
BEGIN
	IF @Rpt = 14 SET @IsLeader = 0 Else SET @IsLeader = 1
	 
	SELECT 	metric.category 'MetricID',
			metric.Qty AS 'Qty', 
			CAST(metric.Category AS VARCHAR(10)) AS 'Note',
			SUM(metric.Points) AS 'Points' 
	FROM (
		SELECT
			1 AS 'Qty',
			met.MetricDate 'MetricDate',
			CASE @Unit
			WHEN 'year' THEN 
				YEAR(met.MetricDate) 
			WHEN 'quarter' THEN 
				DATEPART( q, met.MetricDate )
			WHEN 'month' THEN 
				MONTH(met.MetricDate)
			WHEN 'week' THEN 
				DATEPART( wk, met.MetricDate )
			WHEN 'day' THEN 
				DAY(met.MetricDate)
			END AS 'Category',
			met.Qty * mtt.Pts AS 'Points'
		FROM METRIC AS met 
		JOIN MetricType AS mtt ON met.MetricTypeID = mtt.MetricTypeID
		JOIN MemberContest AS mec ON met.MemberID = mec.MemberID
		JOIN Contest AS con ON mec.ContestID = con.ContestID
		WHERE con.MemberID = @MemberID AND con.IsPrivate != 0 AND met.MetricDate >= @FromDate AND met.MetricDate < @ToDate AND mtt.IsLeader = @IsLeader AND mtt.IsResult != 0 AND met.IsGoal = 0
	) AS metric
	GROUP BY metric.Qty, metric.Category
	UNION
	SELECT 	metric.category + 1000 'MetricID',
			metric.Qty AS 'Qty', 
			CAST(metric.Category AS VARCHAR(10)) AS 'Note',
			SUM(metric.Points) AS 'Points' 
	FROM (
		SELECT
			0 AS 'Qty',
			met.MetricDate 'MetricDate',
			CASE @Unit
			WHEN 'year' THEN 
				YEAR(met.MetricDate) 
			WHEN 'quarter' THEN 
				DATEPART( q, met.MetricDate )
			WHEN 'month' THEN 
				MONTH(met.MetricDate)
			WHEN 'week' THEN 
				DATEPART( wk, met.MetricDate )
			WHEN 'day' THEN 
				DAY(met.MetricDate)
			END AS 'Category',
			met.Qty * mtt.Pts AS 'Points'
		FROM METRIC AS met 
		JOIN MetricType AS mtt ON met.MetricTypeID = mtt.MetricTypeID
		JOIN MemberContest AS mec ON met.MemberID = mec.MemberID
		JOIN Contest AS con ON mec.ContestID = con.ContestID
		WHERE con.MemberID = @MemberID AND con.IsPrivate != 0 AND met.MetricDate >= @FromDate AND met.MetricDate < @ToDate AND mtt.IsLeader = @IsLeader AND mtt.IsResult = 0 AND met.IsGoal = 0
	) AS metric
	GROUP BY metric.Qty, metric.Category
	ORDER BY metric.Category
END

-- 10 System Tracks
IF @Rpt = 10
BEGIN

--	*** Get the Track Points ***********************************************
	IF @Unit = '' SET @Tracks = '10,100,250,500' ELSE SET @Tracks = @Unit
	--Remove spaces
	SET @Tracks = REPLACE ( @Tracks,' ','');
	SET @pts = 0 SET @pts1 = 0 SET @pts2 = 0 SET @pts3 = 0 SET @pts4 = 0 
	SET @cnt = 0
	WHILE @Tracks != ''
	BEGIN
		SET @pos = CHARINDEX(',', @Tracks)
		IF @pos > 0
		BEGIN
			SET @pts = CAST(SUBSTRING(@Tracks, 1, @pos-1) AS int)
			SET @Tracks = LTRIM(SUBSTRING(@Tracks, @pos+1, LEN(@Tracks)-@pos))
		END
		ELSE
		BEGIN
			SET @pts = CAST(@Tracks AS int)
			SET @Tracks = ''
		END
		SET @cnt = @cnt + 1
		IF @cnt = 1 SET @pts1 = @pts
		IF @cnt = 2 SET @pts2 = @pts
		IF @cnt = 3 SET @pts3 = @pts
		IF @cnt = 4 SET @pts4 = @pts
	END 
	--print @pts1 print @pts2 print @pts3 print @pts4

--	*** Adjust Points for Date Range *************************************
	SET @Days = DATEDIFF( day, @FromDate, @ToDate ) + 1
	IF @Days > 0
	BEGIN
		SET @pts1 = ROUND( (@pts1/30) * @Days, 0 )
		SET @pts2 = ROUND( (@pts2/30) * @Days, 0 )
		SET @pts3 = ROUND( (@pts3/30) * @Days, 0 )
		SET @pts4 = ROUND( (@pts4/30) * @Days, 0 )
	END	
	--print @Days print @pts1 print @pts2 print @pts3 print @pts4

--	*** Get Data *********************************************************
	SELECT 	member.Category AS 'MetricID' ,
			0 AS 'Qty', 
			'2-' + CAST(member.Category AS VARCHAR(2)) AS 'Note',
			COUNT(member.Category) AS 'Points' 
	FROM (
		SELECT 'Category' = 
			CASE  
			WHEN metric.pts <= @pts1 THEN 1
			WHEN metric.pts > @pts1 AND metric.pts <= @pts2 THEN 2
			WHEN metric.pts > @pts2 AND metric.pts <= @pts3 THEN 3
			WHEN metric.pts > @pts3 AND metric.pts <= @pts4 THEN 4
			WHEN metric.pts > @pts4 THEN 5
			END
		FROM (
			SELECT met.MemberID, SUM( met.Qty * mtt.Pts ) AS 'pts'
			FROM METRIC AS met 
			JOIN MetricType AS mtt ON met.MetricTypeID = mtt.MetricTypeID
			JOIN Member AS me ON met.MemberID = me.MemberID
			WHERE me.GroupID = @MemberID AND met.MetricDate >= @FromDate AND met.MetricDate < @ToDate AND met.IsGoal = 0
			GROUP BY met.MemberID
		) AS metric
	) AS member
	GROUP BY Category
	ORDER BY member.Category DESC
END 

-- 30 Team Tracks
IF @Rpt = 30
BEGIN

--	*** Get the Track Points ***********************************************
	IF @Unit = '' SET @Tracks = '10,100,250,500' ELSE SET @Tracks = @Unit
	--Remove spaces
	SET @Tracks = REPLACE ( @Tracks,' ','');
	SET @pts = 0 SET @pts1 = 0 SET @pts2 = 0 SET @pts3 = 0 SET @pts4 = 0 
	SET @cnt = 0
	WHILE @Tracks != ''
	BEGIN
		SET @pos = CHARINDEX(',', @Tracks)
		IF @pos > 0
		BEGIN
			SET @pts = CAST(SUBSTRING(@Tracks, 1, @pos-1) AS int)
			SET @Tracks = LTRIM(SUBSTRING(@Tracks, @pos+1, LEN(@Tracks)-@pos))
		END
		ELSE
		BEGIN
			SET @pts = CAST(@Tracks AS int)
			SET @Tracks = ''
		END
		SET @cnt = @cnt + 1
		IF @cnt = 1 SET @pts1 = @pts
		IF @cnt = 2 SET @pts2 = @pts
		IF @cnt = 3 SET @pts3 = @pts
		IF @cnt = 4 SET @pts4 = @pts
	END 
	--print @pts1 print @pts2 print @pts3 print @pts4

--	*** Adjust Points for Date Range *************************************
	SET @Days = DATEDIFF( day, @FromDate, @ToDate ) + 1
	IF @Days > 0
	BEGIN
		SET @pts1 = ROUND( (@pts1/30) * @Days, 0 )
		SET @pts2 = ROUND( (@pts2/30) * @Days, 0 )
		SET @pts3 = ROUND( (@pts3/30) * @Days, 0 )
		SET @pts4 = ROUND( (@pts4/30) * @Days, 0 )
	END	
	--print @Days print @pts1 print @pts2 print @pts3 print @pts4

--	*** Get Data *********************************************************
	SELECT 	member.Category AS 'MetricID' ,
			0 AS 'Qty', 
			'2-' + CAST(member.Category AS VARCHAR(2)) AS 'Note',
			COUNT(member.Category) AS 'Points' 
	FROM (
		SELECT 'Category' = 
			CASE  
			WHEN metric.pts <= @pts1 THEN 1
			WHEN metric.pts > @pts1 AND metric.pts <= @pts2 THEN 2
			WHEN metric.pts > @pts2 AND metric.pts <= @pts3 THEN 3
			WHEN metric.pts > @pts3 AND metric.pts <= @pts4 THEN 4
			WHEN metric.pts > @pts4 THEN 5
			END
		FROM (
			SELECT met.MemberID, SUM( met.Qty * mtt.Pts ) AS 'pts'
			FROM METRIC AS met 
			JOIN MetricType AS mtt ON met.MetricTypeID = mtt.MetricTypeID
			JOIN MemberContest AS mec ON met.MemberID = mec.MemberID
			JOIN Contest AS con ON mec.ContestID = con.ContestID
			WHERE con.MemberID = @MemberID AND con.IsPrivate != 0 AND met.MetricDate >= @FromDate AND met.MetricDate < @ToDate AND met.IsGoal = 0
			GROUP BY met.MemberID
		) AS metric
	) AS member
	GROUP BY Category
	ORDER BY member.Category DESC
END 

GO

