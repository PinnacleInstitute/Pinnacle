EXEC [dbo].pts_CheckProc 'pts_Member_CustomList'
GO

--EXEC pts_Member_CustomList 14, 102, 4
--EXEC pts_Member_CustomList 17, 93, 0

CREATE PROCEDURE [dbo].pts_Member_CustomList
   @CompanyID int ,
   @Status int ,
   @Level int
AS

SET NOCOUNT ON

IF @Status != 3 AND @Status < 80 OR @Status > 104
BEGIN
	IF @CompanyID = 1 EXEC pts_Member_CustomList_1 @Status, @Level
	IF @CompanyID = 5 EXEC pts_Member_CustomList_5 @Status, @Level
	IF @CompanyID = 6 EXEC pts_Member_CustomList_6 @Status, @Level
	IF @CompanyID = 7 EXEC pts_Member_CustomList_7 @Status, @Level
	IF @CompanyID = 8 EXEC pts_Member_CustomList_8 @Status, @Level
	IF @CompanyID = 9 EXEC pts_Member_CustomList_9 @Status, @Level
	IF @CompanyID = 11 EXEC pts_Member_CustomList_11 @Status, @Level
	IF @CompanyID = 14 EXEC pts_Member_CustomList_14 @Status, @Level
	IF @CompanyID = 17 EXEC pts_Member_CustomList_17 @Status, @Level
	IF @CompanyID = 20 EXEC pts_Member_CustomList_20 @Status, @Level
	IF @CompanyID = 21 EXEC pts_Member_CustomList_21 @Status, @Level
END

-- @Status 90 - 104 reserved for standard reports

--	Get orphaned members
IF @Status = 3
BEGIN
	Select me.MemberID, me.SponsorID AS 'Status', 0 AS 'Level', 
	me.NameFirst + ' ' + me.NameLast AS 'Signature' 
	FROM Member AS me
	LEFT OUTER JOIN Member AS sp ON me.SponsorID = sp.MemberID
	WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 5 AND me.Level = 1 AND me.SponsorID > 0
	AND ( sp.MemberID IS NULL OR sp.Status > 5 )
END

-- Get Member Lost Bonuses >= @Level
IF @Status = 80
BEGIN
	Select me.MemberID 'MemberID', Status AS 'Status', me.Title 'Level',
	CAST(me.Retail AS VARCHAR(20)) + ' - ' + me.NameFirst + ' ' + me.NameLast  + ' - #' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.email  AS 'Signature' 
	FROM Member AS me
	WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 4 AND me.Retail > 0 AND me.Retail >= @Level
	ORDER BY me.Retail DESC
END

--	Get referral orphaned members
IF @Status = 90
BEGIN
	Select me.MemberID, me.SponsorID AS 'Status', 0 AS 'Level', 
	me.NameFirst + ' ' + me.NameLast AS 'Signature' 
	FROM Member AS me
	LEFT OUTER JOIN Member AS sp ON me.ReferralID = sp.MemberID
	WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 5 AND me.Level = 1 AND me.ReferralID > 0
	AND ( sp.MemberID IS NULL OR sp.Status > 5 )
END

--	Get binary orphaned members
IF @Status = 91
BEGIN
	Select me.MemberID, me.Sponsor3ID AS 'Status', 0 AS 'Level', 
	me.NameFirst + ' ' + me.NameLast AS 'Signature' 
	FROM Member AS me
	LEFT OUTER JOIN Member AS sp ON me.Sponsor3ID = sp.MemberID
	WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 5 AND me.Level = 1 AND me.Sponsor3ID > 0
	AND ( sp.MemberID IS NULL OR sp.Status > 5 )
END

--	Check Binary Inegrity
IF @Status = 92
BEGIN
	Select me.MemberID, me.Sponsor3ID AS 'Status', 0 AS 'Level', 
	me.NameFirst + ' ' + me.NameLast + ' (' + CAST(me.Sponsor3ID AS VARCHAR(10)) + ':' + CAST(me.Pos AS VARCHAR(10)) + ')' AS 'Signature' 
	FROM Member AS me
	JOIN Member AS sp ON me.Sponsor3ID = sp.MemberID
	WHERE me.CompanyID = 14
	AND 2 < (SELECT COUNT(*) FROM Member WHERE Sponsor3ID = sp.MemberID)
END

--	Get sponsor orphaned members
IF @Status = 93
BEGIN
	Select me.MemberID, me.SponsorID AS 'Status', 0 AS 'Level', 
	me.NameFirst + ' ' + me.NameLast AS 'Signature' 
	FROM Member AS me
	LEFT OUTER JOIN Member AS sp ON me.SponsorID = sp.MemberID
	WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND me.Level = 1
	AND ( sp.MemberID IS NULL OR sp.Status > 5 )
	ORDER BY me.SponsorID
END

-- Get Country Members
IF @Status = 97
BEGIN
	IF @CompanyID = 9
		EXEC pts_Member_CustomList_9 @Status, @Level
	ELSE
	BEGIN	
		Select CountryID 'MemberID', Cnt AS 'Status', 0 'Level', CountryName AS 'Signature' 
		FROM (
			SELECT TOP 1000 co.CountryID, co.CountryName, COUNT(me.MemberID) AS 'Cnt'
			FROM Member AS me
			join Address AS ad ON me.MemberID = ad.OwnerID
			join Country AS co ON ad.CountryID = co.CountryID
			WHERE me.CompanyID = @CompanyID	AND me.Status >=1 AND me.Status <=4 AND ad.AddressType = 2
			GROUP BY co.CountryID, co.CountryName
			ORDER BY COUNT(me.MemberID) DESC
		) AS tmp
	END
END

-- Get Top Earners
IF @Status = 98
BEGIN
	Select MemberID 'MemberID', CAST(Amt AS Int) AS 'Status', 0 'Level', NameFirst + ' ' + NameLast AS 'Signature' 
	FROM (
		SELECT TOP 50 me.MemberID, me.NameFirst, me.NameLast, SUM(co.Total) 'Amt'
		FROM Member AS me
		JOIN Commission AS co ON me.MemberID = co.OwnerID
		WHERE me.CompanyID = @CompanyID AND me.Status >=1 AND me.Status <=4 
		AND me.MemberID <> 7164
		GROUP BY me.MemberID, me.NameFirst, me.NameLast
		ORDER BY SUM(co.Total) DESC
	) AS tmp
END

-- Get Top Recruiters
IF @Status = 99
BEGIN
	IF @CompanyID = 9
		EXEC pts_Member_CustomList_9 @Status, @Level
	ELSE
	BEGIN	
		Select MemberID 'MemberID', Cnt AS 'Status', 0 'Level', NameFirst + ' ' + NameLast AS 'Signature' 
		FROM (
			SELECT TOP 50 re.MemberID, re.NameFirst, re.NameLast, COUNT(me.MemberID) 'Cnt'
			FROM Member AS me
			JOIN Member AS re ON me.ReferralID = re.MemberID
			WHERE me.CompanyID = @CompanyID AND me.Status >=1 AND me.Status <=4 
			GROUP BY re.MemberID, re.NameFirst, re.NameLast
			ORDER BY COUNT(me.MemberID) DESC
		) AS tmp
	END
END

-- Get Members with bad payments
IF @Status = 100
BEGIN
	IF @CompanyID = 9
	BEGIN
		EXEC pts_Member_CustomList_9 @Status, @Level
	END	
	ELSE
	BEGIN	
		Select pa.PaymentID 'MemberID', me.Status AS 'Status', me.MemberID 'Level',
		me.NameFirst + ' ' + me.NameLast  + ' - #' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.email + ' - ' + CAST(pa.amount AS VARCHAR(10)) + ' - ' + CAST(pa.paydate AS VARCHAR(30)) + ' - ' + CAST(pa.notes AS VARCHAR(500)) AS 'Signature' 
		FROM Payment AS pa
		JOIN Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID
		WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 4 AND me.Billing = 3 AND pa.Status = @Level
		ORDER BY pa.PayDate DESC, pa.PaymentID DESC
	END
END

-- Get bad payment in @Level
IF @Status = 101
BEGIN
	IF @CompanyID = 9
		EXEC pts_Member_CustomList_9 @Status, @Level
	ELSE
	BEGIN	
		Select pa.PaymentID 'MemberID', me.Status AS 'Status', me.MemberID 'Level',
		me.NameFirst + ' ' + me.NameLast  + ' - #' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.email + ' - ' + CAST(pa.amount AS VARCHAR(10)) + ' - ' + CAST(pa.paydate AS VARCHAR(30)) + ' - ' + CAST(pa.notes AS VARCHAR(500)) AS 'Signature' 
		FROM Payment AS pa
		JOIN Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID
		WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 4 AND me.Billing = 3
		AND pa.PaymentID = @Level
	END
END

-- Get Members with bad payments (SalesOrders)
IF @Status = 102
BEGIN
	Select pa.PaymentID 'MemberID', me.Status AS 'Status', me.MemberID 'Level',
	me.Role + ' - ' + me.NameFirst + ' ' + me.NameLast  + ' - #' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.email + ' - ' + CAST(pa.amount AS VARCHAR(10)) + ' - ' + CAST(pa.paydate AS VARCHAR(30)) + ' - ' + CAST(pa.notes AS VARCHAR(500)) AS 'Signature' 
	FROM Payment AS pa
	JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
	JOIN Member AS me ON so.MemberID = me.MemberID
	WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 4 AND me.Billing = 3 AND pa.Status = @Level
	ORDER BY pa.PayDate DESC, pa.PaymentID DESC
END

-- Get bad payment in @Level (SalesOrders)
IF @Status = 103
BEGIN
	Select pa.PaymentID 'MemberID', me.Status AS 'Status', me.MemberID 'Level',
	me.NameFirst + ' ' + me.NameLast  + ' - #' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.email + ' - ' + CAST(pa.amount AS VARCHAR(10)) + ' - ' + CAST(pa.paydate AS VARCHAR(30)) + ' - ' + CAST(pa.notes AS VARCHAR(500)) AS 'Signature' 
	FROM Payment AS pa
	JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
	JOIN Member AS me ON so.MemberID = me.MemberID
	WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 4 AND me.Billing = 3
	AND pa.PaymentID = @Level
	ORDER BY pa.PayDate DESC, pa.PaymentID DESC
END

-- Get cash payments to be processed
IF @Status = 104
BEGIN
--	Get Member cash payments
	IF @Level = 0
	BEGIN
		Select pa.PaymentID 'MemberID', me.Status AS 'Status', me.MemberID 'Level',
		me.NameFirst + ' ' + me.NameLast  + ' - #' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.email + ' - ' + CAST(pa.amount AS VARCHAR(10)) + ' - ' + CAST(pa.paydate AS VARCHAR(30)) + ' - ' + CAST(pa.notes AS VARCHAR(500)) AS 'Signature' 
		FROM Payment AS pa
		JOIN Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID
		WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND me.Billing = 3 AND pa.PayType = 7 AND pa.Status < 3
		ORDER BY pa.PayDate DESC, pa.PaymentID DESC
	END

--	Get Salesorder cash payments
	IF @Level != 0
	BEGIN
		Select pa.PaymentID 'MemberID', me.Status AS 'Status', me.MemberID 'Level',
		me.NameFirst + ' ' + me.NameLast  + ' - #' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.email + ' - ' + CAST(pa.amount AS VARCHAR(10)) + ' - ' + CAST(pa.paydate AS VARCHAR(30)) + ' - ' + CAST(pa.notes AS VARCHAR(500)) AS 'Signature' 
		FROM Payment AS pa
		JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
		JOIN Member AS me ON so.MemberID = me.MemberID
		WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND me.Billing = 3 AND pa.PayType = 7 AND pa.Status < 3
		ORDER BY pa.PayDate DESC, pa.PaymentID DESC
	END
END

GO
