EXEC [dbo].pts_CheckProc 'pts_SalesOrder_CustomList2_14'
GO

--EXEC pts_SalesOrder_CustomList2_14 101, '2/1/14', '2/28/14', 1, 0

CREATE PROCEDURE [dbo].pts_SalesOrder_CustomList2_14
   @Status int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime ,
   @Quantity int ,
   @Amount int
AS

SET NOCOUNT ON
DECLARE @CompanyID int, @Data varchar(20)
SET @CompanyID = 14

IF @Status = 101 OR @Status = 102
BEGIN
	IF @Quantity = 1 SET @Data = 'GFT'

	Select DISTINCT si.SalesItemID 'SalesOrderID', si.Price+si.OptionPrice 'Total',
	dbo.wtfn_DateOnlyStr(so.OrderDate) + '|' + 
	CAST(so.SalesOrderID AS VARCHAR(10)) + '|' + 
	CAST(si.Price+si.OptionPrice AS VARCHAR(10)) + '|' + 
	CAST(si.Quantity AS VARCHAR(10)) + '|' + 
	pr.ProductName + '|' + 
	pr.FulfillInfo + '|' + 
	CAST(me.MemberID AS VARCHAR(10)) + '|' + 
	me.NameFirst + '|' + me.NameLast + '|' + me.Email + '|' + me.Phone1 + '|' + 
	ISNULL(ad.Street1,ISNULL(ad2.Street1,'')) + '|' + ISNULL(ad.Street2,ISNULL(ad2.Street2,'')) + '|' + ISNULL(ad.City,ISNULL(ad2.City,'')) + '|' + ISNULL(ad.State,ISNULL(ad2.State,'')) + '|' + 
	ISNULL(ad.Zip,ISNULL(ad2.Zip,'')) + '|' + ISNULL(co.CountryName,ISNULL(co2.CountryName,'')) AS 'Result' 
	FROM SalesItem AS si
	JOIN SalesOrder AS so ON si.SalesOrderID = so.SalesOrderID
	JOIN Member AS me ON so.MemberID = me.MemberID
	JOIN Product AS pr ON si.ProductID = pr.ProductID
	LEFT OUTER JOIN Address AS ad ON ad.AddressID = so.AddressID	
	LEFT OUTER JOIN Country AS co ON ad.CountryID = co.CountryID
	LEFT OUTER JOIN Address AS ad2 ON ad2.OwnerType = 4 AND ad2.OwnerID = me.MemberID AND ad2.AddressType = 2 AND ad2.IsActive != 0	
	LEFT OUTER JOIN Country AS co2 ON ad2.CountryID = co2.CountryID
	Where so.CompanyID = @CompanyID AND (so.Status = 2 OR so.Status = 3) AND pr.Fulfill = 5 
	AND ( pr.Data = 'GFT' OR pr.Data = 'LM' OR pr.Data = 'LM-OIL' )
	AND dbo.wtfn_DateOnly(so.OrderDate) >= @ReportFromDate AND dbo.wtfn_DateOnly(so.OrderDate) <= @ReportToDate
	AND ( SELECT COUNT(*) FROM Payment WHERE OwnerType = 52 AND OwnerID = so.SalesOrderID AND Status = 3 ) > 0
	ORDER BY si.SalesItemID
END
   
GO
