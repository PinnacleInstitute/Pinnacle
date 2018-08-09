EXEC [dbo].pts_CheckProc 'pts_Business_Reports'
GO

CREATE PROCEDURE [dbo].pts_Business_Reports
   @Rpt int ,
   @R1 nvarchar (50) ,
   @R2 nvarchar (50) ,
   @R3 nvarchar (50) ,
   @R4 nvarchar (50) ,
   @R5 nvarchar (50)
AS

-- -----------------------------------------
-- Custom Reports
-- -----------------------------------------
-- 1. Company Member Status
-- 2. Company Member Visits
-- 3. Member Contact Status
-- 4. Member Prospect Status
-- 5. Contact /  Prospect Type
-- 6. Company Member Level
-- -----------------------------------------

SET NOCOUNT ON
DECLARE @CompanyID int, @MemberID int, @FromDate datetime, @ToDate datetime, @Type int, @Option int

-- -----------------------------------------
-- 1. Company Member Status
--EXEC pts_Business_Reports 1, '13', '9/25/04', '9/25/09', '', ''
-- -----------------------------------------
IF @Rpt = 1
BEGIN
	SET @CompanyID = CAST(@R1 AS int)
	SET @FromDate = CAST(@R2 AS datetime)
	SET @ToDate = CAST(@R3 AS datetime)

	SELECT 	Status 'BusinessID', 
		Status 'R1', 
		COUNT(*) 'R2',
		'' 'R3', '' 'R4', '' 'R5', '' 'R6', '' 'R7', '' 'R8', '' 'R9', '' 'R10'
	FROM 	Member 
	WHERE	EnrollDate >= @FromDate
	AND	dbo.wtfn_DateOnly(EnrollDate) <= @ToDate
	AND	CompanyID = @CompanyID
	GROUP BY Status
	ORDER BY Status
END

-- -----------------------------------------
-- 2. Company Member Visits
--EXEC pts_Business_Reports 2, '13', '', '', '', ''
-- -----------------------------------------
IF @Rpt = 2
BEGIN
	SET @CompanyID = CAST(@R1 AS int)

	SELECT 	me.Amount 'BusinessID', 
		me.Amount 'R1', 
		COUNT(*) 'R2',
		'' 'R3', '' 'R4', '' 'R5', '' 'R6', '' 'R7', '' 'R8', '' 'R9', '' 'R10'
	FROM (
		SELECT
			MemberID,
			CASE  
			WHEN VisitDate = 0 THEN 32
			WHEN DATEDIFF(dd, VisitDate, CURRENT_TIMESTAMP) <= 1 THEN 1
			WHEN DATEDIFF(dd, VisitDate, CURRENT_TIMESTAMP) <= 3 THEN 3
			WHEN DATEDIFF(wk, VisitDate, CURRENT_TIMESTAMP) <= 1 THEN 7
			WHEN DATEDIFF(wk, VisitDate, CURRENT_TIMESTAMP) <= 2 THEN 14
			WHEN DATEDIFF(m, VisitDate, CURRENT_TIMESTAMP) <= 1 THEN 30
			ELSE 31
			END AS 'Amount'
		FROM 	Member
		WHERE	(@CompanyID = 0 OR CompanyID = @CompanyID)
		AND ( Status > 0 )
		AND ( Status < 4 )
		) AS me
	GROUP BY me.Amount
	ORDER BY me.Amount
END

-- -----------------------------------------
-- 3. Member Contact Status
--EXEC pts_Business_Reports 3, '84', '9/25/04', '9/25/10', '', ''
-- -----------------------------------------
IF @Rpt = 3
BEGIN
	SET @MemberID = CAST(@R1 AS int)
	SET @FromDate = CAST(@R2 AS datetime)
	SET @ToDate = CAST(@R3 AS datetime)

	SELECT 	Status 'BusinessID', 
		Status 'R1', 
		COUNT(*) 'R2',
		'' 'R3', '' 'R4', '' 'R5', '' 'R6', '' 'R7', '' 'R8', '' 'R9', '' 'R10'
	FROM 	Lead 
	WHERE	LeadDate >= @FromDate
	AND	LeadDate <= @ToDate
	AND	MemberID = @MemberID
	GROUP BY Status
	ORDER BY Status
END


-- -----------------------------------------
-- 4. Member Prospect Status
--EXEC pts_Business_Reports 4, '84', '9/25/04', '9/25/10', '', ''
-- -----------------------------------------
IF @Rpt = 4
BEGIN
	SET @MemberID = CAST(@R1 AS int)
	SET @FromDate = CAST(@R2 AS datetime)
	SET @ToDate = CAST(@R3 AS datetime)

	SELECT 	pr.Status 'BusinessID', 
		pr.Status 'R1', 
		COUNT(*) 'R2',
		'' 'R3', '' 'R4', '' 'R5', '' 'R6', '' 'R7', '' 'R8', '' 'R9', '' 'R10'
	FROM (
		SELECT
			ProspectID,
			CASE  
			WHEN Status > 5 THEN 2
			ELSE Status
			END AS 'Status'
		FROM 	Prospect
		WHERE	CreateDate >= @FromDate
		AND	CreateDate <= @ToDate
		AND	MemberID = @MemberID
		) AS pr
	GROUP BY pr.Status
	ORDER BY pr.Status
END

-- -----------------------------------------
-- 5. Contact /  Prospect Type
--EXEC pts_Business_Reports 5, '5', '7', '3', '9/25/04', '9/25/10'
-- -----------------------------------------
IF @Rpt = 5
BEGIN
	SET @MemberID = CAST(@R1 AS int)
	SET @Type = CAST(@R2 AS int)
	SET @Option = CAST(@R3 AS int)
	SET @FromDate = CAST(@R4 AS datetime)
	SET @ToDate = CAST(@R5 AS datetime)

	DECLARE @Tmp100 TABLE(
	   BusinessID int ,
	   R1 nvarchar (50),
	   R2 nvarchar (50),
	   R3 nvarchar (50)
	)

	IF @Option = 1 OR @Option = 3
	BEGIN
		INSERT INTO @Tmp100
		SELECT 	Status 'BusinessID', 
			'Contact' 'R1', 
			Status 'R2', 
			COUNT(*) 'R3'
		FROM 	Lead 
		WHERE	LeadDate >= @FromDate
		AND	LeadDate <= @ToDate
		AND	MemberID = @MemberID
		AND     ProspectTypeID = @Type
		GROUP BY Status
	END
	IF @Option = 2 OR @Option = 3
	BEGIN
		INSERT INTO @Tmp100
		SELECT 	pr.Status * 10 'BusinessID', 
			'Prospect' 'R1', 
			pr.Status 'R2', 
			COUNT(*) 'R3'
		FROM (
			SELECT
				ProspectID,
				CASE  
				WHEN Status > 5 THEN 2
				ELSE Status
				END AS 'Status'
			FROM 	Prospect
			WHERE	CreateDate >= @FromDate
			AND	CreateDate <= @ToDate
			AND	MemberID = @MemberID
			AND     ProspectTypeID = @Type
			) AS pr
		GROUP BY pr.Status
	END
	SELECT BusinessID, R1, R2, R3, '' 'R4', '' 'R5', '' 'R6', '' 'R7', '' 'R8', '' 'R9', '' 'R10'
	FROM @Tmp100
	ORDER BY R1, R2
END

-- -----------------------------------------
-- 6. Company Member Level
--EXEC pts_Business_Reports 6, '1', '9/25/04', '9/25/09', '', ''
-- -----------------------------------------
IF @Rpt = 6
BEGIN
	SET @CompanyID = CAST(@R1 AS int)
	SET @FromDate = CAST(@R2 AS datetime)
	SET @ToDate = CAST(@R3 AS datetime)

	SELECT 	Level 'BusinessID', 
		Level 'R1', 
		COUNT(*) 'R2',
		'' 'R3', '' 'R4', '' 'R5', '' 'R6', '' 'R7', '' 'R8', '' 'R9', '' 'R10'
	FROM 	Member 
	WHERE	EnrollDate >= @FromDate
	AND	dbo.wtfn_DateOnly(EnrollDate) <= @ToDate
	AND	CompanyID = @CompanyID
	AND Status <= 3
	GROUP BY Level
	ORDER BY Level
END

-- -----------------------------------------
-- 7 Top Activity Tracker Points
--EXEC pts_Business_Reports 7, '7', '6/1/2013', '7/1/2013', '100', '2'
-- -----------------------------------------
IF @Rpt = 7
BEGIN
	DECLARE @Points int, @Result int
	SET @CompanyID = CAST(@R1 AS int)
	SET @FromDate = CAST(@R2 AS datetime)
	SET @ToDate = CAST(@R3 AS datetime)
	SET @Points = CAST(@R4 AS int)
	SET @Result = CAST(@R5 AS int)

	SELECT 	me.MemberID 'BusinessID', 
		me.NameFirst 'R1', 
		me.NameLast 'R2', 
		me.Phone1 'R3', 
		me.Email 'R4', 
		SUM(met.qty*mtt.pts) 'R5', 
		'' 'R6', 
		'' 'R7',
		'' 'R8',
		'' 'R9',
		'' 'R10'
	FROM Metric AS met
	JOIN MetricType AS mtt ON met.MetricTypeID = mtt.MetricTypeID
	JOIN Member AS me ON met.MemberID = me.MemberID
	WHERE  me.CompanyID = @CompanyID
	AND  met.MetricDate >= @FromDate
	AND  met.MetricDate <= @ToDate
	AND  mtt.IsResult != @Result
	AND  met.IsGoal = 0
	GROUP BY me.MemberID, me.NameFirst, me.NameLast, me.Phone1, me.Email
	HAVING SUM(met.qty*mtt.pts) >= @Points 
	ORDER BY SUM(met.qty*mtt.pts) DESC
END

-- -----------------------------------------
-- 8 Member Countries
--EXEC pts_Business_Reports 8, '9', '1/1/2013', '5/1/2013', '', ''
-- -----------------------------------------
IF @Rpt = 8
BEGIN
	SET @CompanyID = CAST(@R1 AS int)
	SET @FromDate = CAST(@R2 AS datetime)
	SET @ToDate = CAST(@R3 AS datetime)

	SELECT 	co.CountryID 'BusinessID', 
		co.CountryName 'R1', 
		CAST( COUNT(me.MemberID) AS VARCHAR(10) ) 'R2', 
		'' 'R3', 
		'' 'R4', 
		'' 'R5', 
		'' 'R6', 
		'' 'R7',
		'' 'R8',
		'' 'R9',
		'' 'R10'
	FROM  Member AS me
	CROSS APPLY
		( SELECT TOP 1 CountryID FROM ADDRESS WHERE OwnerType=4 AND OwnerID = me.MemberID) AS ad 
	JOIN Country AS co ON ad.CountryID = co.CountryID
	WHERE me.CompanyID = @CompanyID 
	AND   me.Status >= 0 AND me.Status <= 5
	AND   dbo.wtfn_DateOnly(me.EnrollDate) >= @FromDate
	AND	  dbo.wtfn_DateOnly(me.EnrollDate) <= @ToDate
	GROUP BY co.CountryID, co.CountryName
	ORDER BY COUNT(me.MemberID) DESC
END

-- -----------------------------------------
-- 200 StrongIncome New Members
--EXEC pts_Business_Reports 200, '7', '1/31/2013', '1/31/2013', '', ''
-- -----------------------------------------
IF @Rpt = 200
BEGIN
	SET @CompanyID = CAST(@R1 AS int)
	SET @FromDate = CAST(@R2 AS datetime)
	SET @ToDate = CAST(@R3 AS datetime)

	SELECT 	me.MemberID 'BusinessID', 
		me.NameFirst 'R1', 
		me.NameLast 'R2', 
		me.Phone1 'R3', 
		me.Email 'R4', 
		ISNULL(ad.City,'') 'R5', 
		ISNULL(ad.State,'') 'R6', 
		me.EnrollDate 'R7',
		'' 'R8',
		'' 'R9',
		'' 'R10'
	FROM  Member AS me
	CROSS APPLY
		( SELECT TOP 1 City, State FROM ADDRESS WHERE OwnerType=4 AND OwnerID = me.MemberID AND AddressType = 2 AND IsActive = 1) AS ad 
	WHERE me.CompanyID = @CompanyID 
	AND   me.Status = 1
	AND   dbo.wtfn_DateOnly(me.EnrollDate) >= @FromDate
	AND	  dbo.wtfn_DateOnly(me.EnrollDate) <= @ToDate
	ORDER BY me.Enrolldate, me.NameLast, me.NameFirst
END

-- -----------------------------------------
-- 201 StrongIncome Activity - Attend Events
--EXEC pts_Business_Reports 201, '7', '1/5/2013', '2/4/2013', '10', ''
-- -----------------------------------------
IF @Rpt = 201
BEGIN
	DECLARE @Event int
	SET @CompanyID = CAST(@R1 AS int)
	SET @FromDate = CAST(@R2 AS datetime)
	SET @ToDate = CAST(@R3 AS datetime)
	SET @Event = CAST(@R4 AS int)

	SELECT 	met.MetricID 'BusinessID', 
		me.NameFirst 'R1', 
		me.NameLast 'R2', 
		me.Phone1 'R3', 
		me.Email 'R4', 
		met.InputValues 'R5', 
		met.Note 'R6', 
		'' 'R7',
		'' 'R8',
		'' 'R9',
		'' 'R10'
	FROM Metric AS met
	JOIN MetricType AS mtt ON met.MetricTypeID = mtt.MetricTypeID
	JOIN Member AS me ON met.MemberID = me.MemberID
	WHERE  me.CompanyID = @CompanyID
	AND  met.MetricDate >= @FromDate
	AND  met.MetricDate <= @ToDate
	AND  met.MetricTypeID = @Event
	ORDER BY met.InputValues, met.Note, me.NameLast, me.NameFirst
END

GO

