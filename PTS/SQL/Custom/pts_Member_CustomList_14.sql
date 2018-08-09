EXEC [dbo].pts_CheckProc 'pts_Member_CustomList_14'
GO

--EXEC pts_Member_CustomList_14 113, 1
--EXEC pts_Member_CustomList_14 106, 10860
--EXEC pts_Member_CustomList_14 200, 1

CREATE PROCEDURE [dbo].pts_Member_CustomList_14
   @Status int ,
   @Level int
AS

SET NOCOUNT ON
DECLARE @CompanyID int, @MemberID int, @Date datetime
SET @CompanyID = 14
SET @MemberID = @Level

-- Get All Member List
IF @Status = 105
BEGIN
	Select ad.AddressID 'MemberID', 0 'Status', 0 'Level', 
	'"' + CAST(me.MemberID AS VARCHAR(10)) + '","' + CAST(me.ReferralID AS VARCHAR(10)) + '","' + CAST(me.Status AS VARCHAR(10)) + '","' + CAST(me.Level AS VARCHAR(10)) + '","' + me.NameFirst + '","' + me.NameLast + '","' + me.Email + '","' + me.Phone1 + '","' + ad.Street1 + '","' + ad.Street2 + '","' + ad.City + '","' + ad.State + '","' + ad.Zip + '","' + co.CountryName  + '"' AS 'Signature' 
	FROM Member AS me
	JOIN Address AS ad ON me.MemberID = ad.OwnerID
	JOIN Country AS co ON ad.CountryID = co.CountryID
	WHERE me.CompanyID = @CompanyID	
	AND ad.AddressType = 2 AND ad.IsActive <> 0
	ORDER BY me.EnrollDate 
END

-- Get Enroller Member List
IF @Status = 106
BEGIN
	WITH Members (CompanyID, MemberID, ReferralID, Status, Level, NameFirst, NameLast, Email, Phone1, Levels)
	AS
	(
--		Anchor member definition
		SELECT me.CompanyID, me.MemberID, me.ReferralID, me.Status, me.Level, me.NameFirst, me.NameLast, me.Email, me.Phone1, 0 AS Levels 
		FROM Member AS me
		WHERE MemberID = @MemberID
		UNION ALL
--		Recursive member definition
		SELECT me.CompanyID, me.MemberID, me.ReferralID, me.Status, me.Level, me.NameFirst, me.NameLast, me.Email, me.Phone1, Levels + 1
		FROM Member AS me
		INNER JOIN Members AS ms
			ON me.ReferralID = ms.MemberID
	)
--	Statement that executes the CTE
	Select ad.AddressID 'MemberID', 0 'Status', 0 'Level', 
	'"' + CAST(me.MemberID AS VARCHAR(10)) + '","' + CAST(me.ReferralID AS VARCHAR(10)) + '","' + CAST(me.Status AS VARCHAR(10)) + '","' + CAST(me.Level AS VARCHAR(10)) + '","' + me.NameFirst + '","' + me.NameLast + '","' + me.Email + '","' + me.Phone1 + '","' + ad.Street1 + '","' + ad.Street2 + '","' + ad.City + '","' + ad.State + '","' + ad.Zip + '","' + co.CountryName  + '"' AS 'Signature' 
	FROM Members AS me
	JOIN Address AS ad ON me.MemberID = ad.OwnerID
	JOIN Country AS co ON ad.CountryID = co.CountryID
	WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 4
	AND ad.AddressType = 2 AND ad.IsActive <> 0
	AND me.Levels <= 10000
	ORDER BY me.MemberID 
	OPTION (MAXRECURSION 0) 
END

-- Get Binary Member List
IF @Status = 107
BEGIN
	WITH Members (CompanyID, MemberID, Sponsor3ID, Status, Level, NameFirst, NameLast, Email, Phone1, Levels, AuthUserID)
	AS
	(
--		Anchor member definition
		SELECT me.CompanyID, me.MemberID, me.Sponsor3ID, me.Status, me.Level, me.NameFirst, me.NameLast, me.Email, me.Phone1, 0 AS Levels, me.AuthUserID
		FROM Member AS me
		WHERE MemberID = @MemberID
		UNION ALL
--		Recursive member definition
		SELECT me.CompanyID, me.MemberID, me.Sponsor3ID, me.Status, me.Level, me.NameFirst, me.NameLast, me.Email, me.Phone1, Levels + 1, me.AuthUserID
		FROM Member AS me
		INNER JOIN Members AS ms
			ON me.Sponsor3ID = ms.MemberID
	)
--	Statement that executes the CTE
	Select ad.AddressID 'MemberID', 0 'Status', 0 'Level', 
	'"' + CAST(me.MemberID AS VARCHAR(10)) + '","' + CAST(me.Sponsor3ID AS VARCHAR(10)) + '","' + CAST(me.Status AS VARCHAR(10)) + '","' + CAST(me.Level AS VARCHAR(10)) + '","' + me.NameFirst + '","' + me.NameLast + '","' + me.Email + '","' + me.Phone1 + '","' + ad.Street1 + '","' + ad.Street2 + '","' + ad.City + '","' + ad.State + '","' + ad.Zip + '","' + co.CountryName + '","' + au.Logon + '","' + au.password  + '"' AS 'Signature' 
	FROM Members AS me
	JOIN Address AS ad ON me.MemberID = ad.OwnerID
	JOIN Country AS co ON ad.CountryID = co.CountryID
	JOIN AuthUser AS au ON me.AuthUserID = au.AuthUserID
	WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 4
	AND ad.AddressType = 2 AND ad.IsActive <> 0
	AND me.Levels <= 10000
	ORDER BY me.MemberID 
	OPTION (MAXRECURSION 0) 
END

-- Get All Member Missing Billing Method
IF @Status = 108
BEGIN
	Select me.MemberID 'MemberID', Status 'Status', Title 'Level', 
	'#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast + ' - ' + me.Email + ' - ' + me.Phone1 + ' - ' + CAST(me.EnrollDate AS VARCHAR(20)) + ' - ' + CAST(me.VisitDate AS VARCHAR(20)) AS 'Signature' 
	FROM Member AS me
	WHERE me.CompanyID = @CompanyID	
	AND Status = 1 AND Billing = 3 AND BillingID = 0
	ORDER BY me.EnrollDate 
END

-- Get All Member without an Approved payment in the last 2 months
IF @Status = 109
BEGIN
	SET @Date = DATEADD(m,-2,GETDATE())
	
	Select me.MemberID 'MemberID', Status 'Status', Title 'Level', 
	'#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast + ' - ' + me.Email + ' - ' + me.Phone1 + ' - ' + CAST(me.EnrollDate AS VARCHAR(20)) + ' - ' + CAST(me.VisitDate AS VARCHAR(20)) AS 'Signature' 
	FROM Member AS me
	WHERE me.CompanyID = @CompanyID	
	AND Status = 1 AND Billing = 3 AND BillingID <> 0
	AND 0 = (
		SELECT COUNT(*) FROM Payment AS pa
		JOIN SalesOrder AS so ON pa.OwnerID = so.SalesOrderID 
		WHERE so.MemberID = me.MemberID AND pa.Status = 3 AND pa.PaidDate > @Date
	)
	ORDER BY me.EnrollDate 
END

-- Get All Members without an Active mailing address
IF @Status = 110
BEGIN
	Select me.MemberID 'MemberID', Status 'Status', Title 'Level', 
	'#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast + ' - ' + me.Email + ' - ' + me.Phone1 + ' - ' + CAST(me.EnrollDate AS VARCHAR(20)) + ' - ' + CAST(me.VisitDate AS VARCHAR(20)) AS 'Signature' 
	FROM Member AS me
	WHERE me.CompanyID = @CompanyID	
	AND Status = 1 
	AND 0 = (
		SELECT COUNT(*) FROM Address WHERE OwnerType = 4 AND OwnerID = me.MemberID AND AddressType = 2 AND IsActive <> 0
	)
	ORDER BY me.EnrollDate 
END

-- Get Members with new bad payments (SalesOrders)
IF @Status = 111
BEGIN
	Select pa.PaymentID 'MemberID', me.Status AS 'Status', me.MemberID 'Level',
	me.Role + ' - ' + me.NameFirst + ' ' + me.NameLast  + ' - #' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.email + ' - ' + CAST(pa.amount AS VARCHAR(10)) + ' - ' + CAST(pa.paydate AS VARCHAR(30)) + ' - ' + CAST(pa.notes AS VARCHAR(500)) AS 'Signature' 
	FROM Payment AS pa
	JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
	JOIN Member AS me ON so.MemberID = me.MemberID
	WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 4 AND me.Billing = 3 AND pa.Status = 4
	AND me.Role NOT LIKE '%P*'
	ORDER BY me.Role, pa.PayDate DESC, pa.PaymentID DESC
END

-- Get Members by title (level)
IF @Status = 112
BEGIN
	Select me.MemberID 'MemberID', me.Status AS 'Status', me.Title 'Level',
	me.NameFirst + ' ' + me.NameLast  + ' - #' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.email  AS 'Signature' 
	FROM Member AS me
	WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 4 AND me.Title = @Level
	ORDER BY me.MemberID
END

-- Data Exceptions List
IF @Status = 200
BEGIN
	DECLARE @Exception TABLE(MemberID int, Status int, Level int, Name nvarchar(100), Msg nvarchar(200) )

	IF @Level = 1 -- Sales Team Exceptions
	BEGIN
		INSERT INTO @Exception
		Select me.MemberID, 1, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'Missing Active Sponsor' 
		FROM Member AS me JOIN Member as re ON me.ReferralID = re.MemberID
		WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND re.Status > 4

		INSERT INTO @Exception
		Select me.MemberID, 2, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'Missing Team #' 
		FROM Member AS me WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND me.GroupID = 0
	END
	
	IF @Level = 2 -- Billing Exceptions
	BEGIN
		INSERT INTO @Exception
		Select me.MemberID, 1, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'Missing Autoship Price' 
		FROM Member AS me WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND me.Billing IN (3,5) AND me.Price = 0
		AND (Options2 LIKE '%111%' OR Options2 LIKE '%112%' OR Options2 LIKE '%113%' OR Options2 LIKE '%114%' OR Options2 LIKE '%115%' OR Options2 LIKE '%116%' 
		OR Options2 LIKE '%117%' OR Options2 LIKE '%118%' OR Options2 LIKE '%119%' OR Options2 LIKE '%120%' OR Options2 LIKE '%121%' )

		INSERT INTO @Exception
		Select me.MemberID, 2, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'Missing Autoship Code' 
		FROM Member AS me WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND me.Billing IN (3,5) AND me.Price > 0
		AND (Options2 NOT LIKE '%111%' AND Options2 NOT LIKE '%112%' AND Options2 NOT LIKE '%113%' AND Options2 NOT LIKE '%114%' 
		AND Options2 NOT LIKE '%115%'  AND Options2 NOT LIKE '%116%' AND Options2 NOT LIKE '%117%' AND Options2 NOT LIKE '%118%' 
		AND Options2 NOT LIKE '%119%' AND Options2 NOT LIKE '%120%' AND Options2 NOT LIKE '%121%' )

		INSERT INTO @Exception
		Select me.MemberID, 3, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'AutoShip Cash Payment Method' 
		FROM Member AS me JOIN Billing as bi ON me.BillingID = bi.BillingID
		WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND me.Billing IN (3,5) AND me.Price > 0 AND bi.PayType = 3 
	END	

	IF @Level = 3 -- Order Exceptions
	BEGIN
		INSERT INTO @Exception
		Select me.MemberID, 1, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'Missing Active Mailing Address' 
		FROM Member AS me WHERE me.CompanyID = @CompanyID AND Status = 1
		AND 0 = (SELECT COUNT(*) FROM Address Where OwnerType = 4 AND OwnerID = me.MemberID AND AddressType = 2 AND IsActive != 0)
	END	

	IF @Level = 4 -- Payout Exceptions
	BEGIN
		INSERT INTO @Exception
		Select me.MemberID, 1, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'Missing Payout Method' 
		FROM Member AS me WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND me.PayID = 0

		INSERT INTO @Exception
		Select me.MemberID, 2, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'Missing Payout Wallet #' 
		FROM Member AS me JOIN Billing as bi ON me.PayID = bi.BillingID
		WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND bi.CardType IN (11,12) AND bi.CardName = ''

		INSERT INTO @Exception
		Select me.MemberID, 3, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'iPayout NOT Member #' 
		FROM Member AS me JOIN Billing as bi ON me.PayID = bi.BillingID
		WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND bi.CardType = 11 AND bi.CardName != '' AND bi.CardName != CAST(me.MemberID AS VARCHAR(10))

		INSERT INTO @Exception
		Select me.MemberID, 4, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'PayQuicker Not Email' 
		FROM Member AS me JOIN Billing as bi ON me.PayID = bi.BillingID
		WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND bi.CardType = 12 AND bi.CardName != '' AND bi.CardName NOT LIKE '%@%'

		INSERT INTO @Exception
		Select me.MemberID, 5, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'PayQuicker Outside USA' 
		FROM Member AS me JOIN Billing as bi ON me.PayID = bi.BillingID
		WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND bi.CardType = 12 AND bi.CountryID != 224
	END	

--	Handle Members in results more than once.
	UPDATE ex SET Msg = Msg + '.....' FROM @Exception AS ex WHERE 1 < ( SELECT COUNT(*) FROM @Exception WHERE MemberID = ex.MemberID )
		
	SELECT MemberID, MIN(Status)'Status', MIN(Level)'Level', MIN(Name + ' - ' + Msg) 'Signature', COUNT(*)  FROM @Exception	GROUP BY MemberID ORDER BY Status, Level DESC

END

GO

