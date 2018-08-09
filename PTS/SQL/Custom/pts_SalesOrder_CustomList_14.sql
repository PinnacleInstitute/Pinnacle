EXEC [dbo].pts_CheckProc 'pts_SalesOrder_CustomList_14'
GO

--EXEC pts_SalesOrder_CustomList_14 101, 0, 1, 0

CREATE PROCEDURE [dbo].pts_SalesOrder_CustomList_14
   @Status int ,
   @EnrollDate datetime ,
   @Quantity int ,
   @Amount int
AS

SET NOCOUNT ON
DECLARE @CompanyID int, @Stat int, @Data varchar(20), @OrderDate datetime 
SET @CompanyID = 14
SET @OrderDate = @EnrollDate
IF @OrderDate = 0 SET @OrderDate = dbo.wtfn_DateOnly( GETDATE() )

IF @Status = 101 OR @Status = 102
BEGIN
	IF @Status = 101 SET @Stat = 1
	IF @Status = 102 SET @Stat = 2
	IF @Quantity = 1 SET @Data = 'GFT'
	IF @Quantity = 2 SET @Data = 'LM'
	IF @Quantity = 3 SET @Data = 'LM-OIL'
	IF @Quantity = 4 SET @Data = 'MAX-NETICS'

--SHPR,ORD_DT,SHP_DT,TRK#,STATUS,DEL_DT,ORD#,$_AMT,$_SHIP,QTY,PACKAGE,PRODUCTS,REP#,FIRSTNAME,LASTNAME,STREET1,STREET2,CITY,STATE,ZIP,COUNTRY,EMAIL,PHONE

	Select DISTINCT si.SalesItemID 'SalesOrderID', si.Price+si.OptionPrice 'Total',
	'|' + dbo.wtfn_DateOnlyStr(so.OrderDate) + '|||||' + 
	CAST(so.SalesOrderID AS VARCHAR(10)) + '|' + 
	CAST(si.quantity * si.Price AS VARCHAR(10)) + '|' + 
	CAST(so.Shipping AS VARCHAR(10)) + '|' + 
	CAST(si.Quantity AS VARCHAR(10)) + '|' + 
	pr.ProductName + '|' + 
	pr.FulFillInfo + '  ' + si.InputValues + '|' + 
	CAST(me.MemberID AS VARCHAR(10)) + '|' + 
	me.NameFirst + '|' + me.NameLast + '|' + 
	ISNULL(ad.Street1,ISNULL(ad2.Street1,'')) + '|' + ISNULL(ad.Street2,ISNULL(ad2.Street2,'')) + '|' + ISNULL(ad.City,ISNULL(ad2.City,'')) + '|' + ISNULL(ad.State,ISNULL(ad2.State,'')) + '|' + 
	ISNULL(ad.Zip,ISNULL(ad2.Zip,'')) + '|' + ISNULL(co.CountryName,ISNULL(co2.CountryName,'')) + '|' + me.Email + '|' + me.Phone1 AS 'Result' 
	FROM SalesItem AS si
	JOIN SalesOrder AS so ON si.SalesOrderID = so.SalesOrderID
	JOIN Member AS me ON so.MemberID = me.MemberID
	JOIN Product AS pr ON si.ProductID = pr.ProductID
	LEFT OUTER JOIN Address AS ad ON ad.AddressID = so.AddressID	
	LEFT OUTER JOIN Country AS co ON ad.CountryID = co.CountryID
	LEFT OUTER JOIN Address AS ad2 ON ad2.OwnerType = 4 AND ad2.OwnerID = me.MemberID AND ad2.AddressType = 2 AND ad2.IsActive != 0	
	LEFT OUTER JOIN Country AS co2 ON ad2.CountryID = co2.CountryID
	Where so.CompanyID = @CompanyID AND so.Status = @Stat AND pr.Fulfill = 5 AND pr.Data = @Data AND dbo.wtfn_DateOnly(so.OrderDate) <= @OrderDate
	AND ( SELECT COUNT(*) FROM Payment WHERE OwnerType = 52 AND OwnerID = so.SalesOrderID AND Status = 3 ) > 0
	ORDER BY si.SalesItemID
END

GO
