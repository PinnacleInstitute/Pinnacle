EXEC [dbo].pts_CheckProc 'pts_Legacy_CustomList'
GO

-- EXEC pts_Legacy_CustomList 13, '7/1/14', 5, 0

CREATE PROCEDURE [dbo].pts_Legacy_CustomList
   @Status int ,
   @czDate datetime ,
   @Quantity int ,
   @Amount int
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @Today datetime, @FromDate datetime, @ToDate datetime
SET @CompanyID = 14
SET @Today = dbo.wtfn_DateOnly(GETDATE())

-- List all new iPayout eWallets to create
IF @Status = 3
BEGIN
--UserName,FirstName,LastName,CompanyName,Address1,Address2,City,State,ZipCode,Country2xFormat,PhoneNumber,CellPhoneNumber,EmailAddress,SSN,CompanyTaxID,GovernmentID,MilitaryID,PassportNumber,DriversLicense,DateOfBirth,WebsitePassword,DefaultCurrency,PreferredLanguage
	SELECT me.MemberID AS 'LegacyID', '"' + au.Logon + '","' + me.NameFirst + '","' + me.NameLast + '",,,,,,,,,,"' + me.Email + '",,,,,,,,"' + au.Password + '",,' AS 'Result'
	FROM Member AS me
	JOIN Billing AS bi ON me.PayID = bi.BillingID
	JOIN AuthUser AS au ON me.AuthUserID = au.AuthUserID
	WHERE CompanyID = @CompanyID AND me.Status = 1 AND me.Level = 1
	AND bi.CardType = 11 AND bi.CardName = ''
	order by me.NameLast, me.namefirst
END

-- List all sales orders for the specified date range
IF @Status = 10
BEGIN
	SET @FromDate = @czDate
	SET @ToDate = DATEADD( d, @Quantity, @FromDate )

	SELECT  so.SalesOrderID AS 'LegacyID', CAST(so.SalesOrderID AS VARCHAR(20)) + ',' + dbo.wtfn_DateOnlyStr(so.OrderDate) + ',' + CAST(so.Status AS VARCHAR(20)) + ',' + CAST(so.Total AS VARCHAR(20)) + ',' + CAST(so.Amount AS VARCHAR(20)) + ',' + CAST(so.Shipping AS VARCHAR(20)) + ',' + ISNULL(gr.NameLast,'') + ',' + ISNULL(co.CountryName,ISNULL(co2.CountryName,'')) AS 'Result'
	FROM SalesOrder AS so
	JOIN Member AS me ON so.MemberID = me.MemberID
	LEFT OUTER JOIN Member AS gr ON me.GroupID = gr.MemberID
	LEFT OUTER JOIN Address AS ad ON ad.AddressID = so.AddressID	
	LEFT OUTER JOIN Country AS co ON ad.CountryID = co.CountryID
	LEFT OUTER JOIN Address AS ad2 ON ad2.OwnerType = 4 AND ad2.OwnerID = me.MemberID AND ad2.AddressType = 2 AND ad2.IsActive != 0	
	LEFT OUTER JOIN Country AS co2 ON ad2.CountryID = co2.CountryID
	WHERE so.CompanyID = @CompanyID AND so.Status >= 1 AND so.Status <= 3
	AND dbo.wtfn_DateOnly(so.OrderDate) >= @FromDate AND dbo.wtfn_DateOnly(so.OrderDate) <= @ToDate
	ORDER BY so.OrderDate, so.SalesOrderID
END

-- List all sales items for the specified date range
IF @Status = 11
BEGIN
	SET @FromDate = @czDate
	SET @ToDate = DATEADD( d, @Quantity, @FromDate )

	SELECT si.SalesItemID AS 'LegacyID', CAST(si.SalesItemID AS VARCHAR(20)) + ',' + CAST(so.SalesOrderID AS VARCHAR(20)) + ',' + dbo.wtfn_DateOnlyStr(so.OrderDate) + ',' + CAST(so.Status AS VARCHAR(20)) + ',' + CAST(si.Quantity AS VARCHAR(20)) + ',' + CAST(si.Price AS VARCHAR(20)) + ',' + pr.ProductName + ',' + pt.ProductTypeName + ',' + ISNULL(gr.NameLast,'') + ',' + ISNULL(co.CountryName,ISNULL(co2.CountryName,'')) AS 'Result'
	FROM SalesItem AS si
	JOIN SalesOrder AS so ON si.SalesOrderID = so.SalesOrderID
	JOIN Member AS me ON so.MemberID = me.MemberID
	JOIN Product AS pr ON si.ProductID = pr.ProductID
	LEFT OUTER JOIN ProductType AS pt ON pr.ProductTypeID = pt.ProductTypeID
	LEFT OUTER JOIN Member AS gr ON me.GroupID = gr.MemberID
	LEFT OUTER JOIN Address AS ad ON ad.AddressID = so.AddressID	
	LEFT OUTER JOIN Country AS co ON ad.CountryID = co.CountryID
	LEFT OUTER JOIN Address AS ad2 ON ad2.OwnerType = 4 AND ad2.OwnerID = me.MemberID AND ad2.AddressType = 2 AND ad2.IsActive != 0	
	LEFT OUTER JOIN Country AS co2 ON ad2.CountryID = co2.CountryID
	WHERE so.CompanyID = @CompanyID AND so.Status >= 1 AND so.Status <= 3
	AND dbo.wtfn_DateOnly(OrderDate) >= @FromDate AND dbo.wtfn_DateOnly(OrderDate) <= @ToDate
	ORDER BY so.OrderDate, so.SalesOrderID
END

-- List all payments for the specified date range
IF @Status = 12
BEGIN
	SET @FromDate = @czDate
	SET @ToDate = DATEADD( d, @Quantity, @FromDate )

	SELECT pa.PaymentID AS 'LegacyID', CAST(pa.PaymentID AS VARCHAR(20)) + ',' + CAST(so.SalesOrderID AS VARCHAR(20)) + ',' + dbo.wtfn_DateOnlyStr(pa.PaidDate) + ',' + CAST(pa.Total AS VARCHAR(20)) + ',' + CAST(pa.Status AS VARCHAR(20)) + ',' + pa.Purpose + ',' + CAST(pa.PayType AS VARCHAR(20)) + ',' + CAST(pa.CommStatus AS VARCHAR(20)) + ',' + ISNULL(gr.NameLast,'') + ',' + ISNULL(co.CountryName,ISNULL(co2.CountryName,'')) AS 'Result'
	FROM Payment AS pa
	JOIN SalesOrder AS so ON (pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID)
	JOIN Member AS me ON so.MemberID = me.MemberID
	LEFT OUTER JOIN Member AS gr ON me.GroupID = gr.MemberID
	LEFT OUTER JOIN Address AS ad ON ad.AddressID = so.AddressID	
	LEFT OUTER JOIN Country AS co ON ad.CountryID = co.CountryID
	LEFT OUTER JOIN Address AS ad2 ON ad2.OwnerType = 4 AND ad2.OwnerID = me.MemberID AND ad2.AddressType = 2 AND ad2.IsActive != 0	
	LEFT OUTER JOIN Country AS co2 ON ad2.CountryID = co2.CountryID
	WHERE pa.CompanyID = @CompanyID AND so.Status >= 1 AND so.Status <= 3
	AND dbo.wtfn_DateOnly(OrderDate) >= @FromDate AND dbo.wtfn_DateOnly(OrderDate) <= @ToDate
	ORDER BY so.OrderDate, so.SalesOrderID
END

-- List all Bonuses for the specified date range
IF @Status = 13
BEGIN
	SET @FromDate = @czDate
	SET @ToDate = DATEADD( d, @Quantity, @FromDate )

	SELECT cm.CommissionID AS 'LegacyID', CAST(cm.CommissionID AS VARCHAR(20)) + ',' + dbo.wtfn_DateOnlyStr(cm.CommDate) + ',' + CAST(cm.Total AS VARCHAR(20)) + ',' + CAST(cm.Status AS VARCHAR(20)) + ',' + CAST(cm.CommType AS VARCHAR(20)) + ',' + CAST(cm.RefID AS VARCHAR(20)) + ',' + ISNULL(gr.NameLast,'') + ',' + ISNULL(co.CountryName,'') AS 'Result'
	FROM Commission AS cm
	JOIN Member AS me ON cm.OwnerID = me.MemberID
	LEFT OUTER JOIN Member AS gr ON me.GroupID = gr.MemberID
	LEFT OUTER JOIN Address AS ad ON ad.OwnerType = 4 AND ad.OwnerID = me.MemberID AND ad.AddressType = 2 AND ad.IsActive != 0	
	LEFT OUTER JOIN Country AS co ON ad.CountryID = co.CountryID
	WHERE cm.CompanyID = @CompanyID
	AND dbo.wtfn_DateOnly(cm.CommDate) >= @FromDate AND dbo.wtfn_DateOnly(cm.CommDate) <= @ToDate
	ORDER BY cm.CommDate
END

GO

