EXEC [dbo].pts_CheckProc 'pts_Member_CustomList_20'
GO

--EXEC pts_Member_CustomList_20 106, 27572

CREATE PROCEDURE [dbo].pts_Member_CustomList_20
   @Status int ,
   @Level int
AS

SET NOCOUNT ON
DECLARE @CompanyID int, @MemberID int, @Date datetime
SET @CompanyID = 20
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


GO
