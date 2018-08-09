EXEC [dbo].pts_CheckProc 'pts_Member_CustomList_9'
GO

--EXEC pts_Member_CustomList_9 100, 4

-- CloudZow
CREATE PROCEDURE [dbo].pts_Member_CustomList_9
   @Status int ,
   @Level int
AS

SET NOCOUNT ON
DECLARE @CompanyID int
SET @CompanyID = 9

-- Get Top Countries
IF @Status = 97
BEGIN
	Select CountryID 'MemberID', Cnt AS 'Status', 0 'Level', CountryName AS 'Signature' 
	FROM (
		SELECT TOP 1000 co.CountryID, co.CountryName, COUNT(me.MemberID) AS 'Cnt'
		FROM Member AS me
		join Address AS ad ON me.MemberID = ad.OwnerID
		join Country AS co ON ad.CountryID = co.CountryID
		WHERE me.CompanyID = @CompanyID	AND me.Status >=1 AND me.Status <=4 AND ad.AddressType = 2
		AND me.Sponsor3ID > 0
		GROUP BY co.CountryID, co.CountryName
		ORDER BY COUNT(me.MemberID) DESC
	) AS tmp
END

-- Get Top Recruiters
IF @Status = 99
BEGIN
	Select MemberID 'MemberID', Cnt AS 'Status', 0 'Level', NameFirst + ' ' + NameLast AS 'Signature' 
	FROM (
		SELECT TOP 50 re.MemberID, re.NameFirst, re.NameLast, COUNT(me.MemberID) 'Cnt'
		FROM Member AS me
		JOIN Member AS re ON me.ReferralID = re.MemberID
		WHERE me.CompanyID = @CompanyID AND me.Status >=1 AND me.Status <=4 
		AND me.Sponsor3ID > 0
		GROUP BY re.MemberID, re.NameFirst, re.NameLast
		ORDER BY COUNT(me.MemberID) DESC
	) AS tmp
END

-- Get Members with bad payments
IF @Status = 100
BEGIN
	Select pa.PaymentID 'MemberID', me.Status AS 'Status', me.MemberID 'Level',
	me.NameFirst + ' ' + me.NameLast  + ' - #' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.email + ' - ' + CAST(pa.amount AS VARCHAR(10)) + ' - ' + CAST(pa.paydate AS VARCHAR(30)) + ' - ' + CAST(pa.notes AS VARCHAR(500)) AS 'Signature' 
	FROM Payment AS pa
	JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
	JOIN Member AS me ON so.MemberID = me.MemberID
	WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 4 AND me.Billing = 3 AND pa.Status = @Level
	ORDER BY pa.PayDate DESC, pa.PaymentID DESC
END

-- Get bad payment in @Level
IF @Status = 101
BEGIN
	Select pa.PaymentID 'MemberID', me.Status AS 'Status', me.MemberID 'Level',
	me.NameFirst + ' ' + me.NameLast  + ' - #' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.email + ' - ' + CAST(pa.amount AS VARCHAR(10)) + ' - ' + CAST(pa.paydate AS VARCHAR(30)) + ' - ' + CAST(pa.notes AS VARCHAR(500)) AS 'Signature' 
	FROM Payment AS pa
	JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
	JOIN Member AS me ON so.MemberID = me.MemberID
	WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 4 AND me.Billing = 3
	AND pa.PaymentID = @Level
END

GO
