--Legacy - All Orders for Date Range
DECLARE @StartDate datetime, @EndDate datetime
SET @StartDate = '4/1/15'
SET @EndDate = '5/1/15'

	Select DISTINCT si.SalesItemID 'SalesItemID', si.Price+si.OptionPrice 'Total',
	so.OrderDate,
	so.SalesOrderID, 
	si.quantity * si.Price 'price', 
	so.Shipping, 
	si.Quantity, 
	pr.ProductName, 
	pr.FulFillInfo,
	si.InputValues, 
	me.MemberID, 
	me.NameFirst,
	me.NameLast, 
	ISNULL(ad.Street1,ISNULL(ad2.Street1,''))'Street1',
	ISNULL(ad.Street2,ISNULL(ad2.Street2,''))'Street2',
	ISNULL(ad.City,ISNULL(ad2.City,''))'City',
	ISNULL(ad.State,ISNULL(ad2.State,''))'State', 
	ISNULL(ad.Zip,ISNULL(ad2.Zip,''))'Zip',
	ISNULL(co.CountryName,ISNULL(co2.CountryName,''))'Country',
	me.Email,
	me.Phone1 
	FROM SalesItem AS si
	JOIN SalesOrder AS so ON si.SalesOrderID = so.SalesOrderID
	JOIN Member AS me ON so.MemberID = me.MemberID
	JOIN Product AS pr ON si.ProductID = pr.ProductID
	LEFT OUTER JOIN Address AS ad ON ad.AddressID = so.AddressID	
	LEFT OUTER JOIN Country AS co ON ad.CountryID = co.CountryID
	LEFT OUTER JOIN Address AS ad2 ON ad2.OwnerType = 4 AND ad2.OwnerID = me.MemberID AND ad2.AddressType = 2 AND ad2.IsActive != 0	
	LEFT OUTER JOIN Country AS co2 ON ad2.CountryID = co2.CountryID
	Where so.CompanyID = 14 AND so.Status = 2 AND pr.Fulfill = 5 
	AND so.OrderDate >= @StartDate
	AND so.OrderDate < @EndDate
--	AND ( SELECT COUNT(*) FROM Payment WHERE OwnerType = 52 AND OwnerID = so.SalesOrderID AND Status = 3 ) > 0
	ORDER BY si.SalesItemID
