EXEC [dbo].pts_CheckProc 'pts_Product_Summary'
GO

CREATE PROCEDURE [dbo].pts_Product_Summary
   @ProductID int ,
   @ProductTypeID int ,
   @FromDate datetime ,
   @ToDate datetime
AS

SET NOCOUNT ON

IF @ProductID > 0
BEGIN
	SELECT   pr.ProductID , 
		pr.ProductName , 
		(
			SELECT COUNT(*) FROM SalesItem AS si
			JOIN SalesOrder AS so ON si.SalesOrderID = so.SalesOrderID
			WHERE so.OrderDate >= @FromDate
			AND   so.OrderDate < @ToDate
			AND   so.Status = 3
			AND   si.ProductID = @ProductID
		) AS 'CompanyID' , 
		(
			SELECT COUNT(*) FROM SalesItem AS si
			JOIN SalesOrder AS so ON si.SalesOrderID = so.SalesOrderID
			WHERE so.OrderDate >= @FromDate
			AND   so.OrderDate < @ToDate
			AND   (so.Status = 1 OR so.Status = 2)
			AND   si.ProductID = @ProductID
		) AS 'CommPlan' , 
		(
			SELECT COUNT(*) FROM SalesItem AS si
			JOIN SalesOrder AS so ON si.SalesOrderID = so.SalesOrderID
			WHERE so.OrderDate >= @FromDate
			AND   so.OrderDate < @ToDate
			AND   (so.Status = 0)
			AND   si.ProductID = @ProductID
		) AS 'Reorder' , 
		pr.Inventory , 
		pr.InStock
	FROM Product AS pr (NOLOCK)
	WHERE (pr.ProductID = @ProductID)
	ORDER BY   pr.Seq
END
IF @ProductTypeID > 0
BEGIN
	SELECT   pr.ProductID , 
		pr.ProductName , 
		(
			SELECT COUNT(*) FROM SalesItem AS si
			JOIN SalesOrder AS so ON si.SalesOrderID = so.SalesOrderID
			WHERE so.OrderDate >= @FromDate
			AND   so.OrderDate < @ToDate
			AND   so.Status = 3
			AND   si.ProductID = pr.ProductID
		) AS 'CompanyID' , 
		(
			SELECT COUNT(*) FROM SalesItem AS si
			JOIN SalesOrder AS so ON si.SalesOrderID = so.SalesOrderID
			WHERE so.OrderDate >= @FromDate
			AND   so.OrderDate < @ToDate
			AND   (so.Status = 1 OR so.Status = 2)
			AND   si.ProductID = pr.ProductID
		) AS 'CommPlan' , 
		(
			SELECT COUNT(*) FROM SalesItem AS si
			JOIN SalesOrder AS so ON si.SalesOrderID = so.SalesOrderID
			WHERE so.OrderDate >= @FromDate
			AND   so.OrderDate < @ToDate
			AND   (so.Status = 0)
			AND   si.ProductID = pr.ProductID
		) AS 'Reorder' , 
		pr.Inventory , 
		pr.InStock
	FROM Product AS pr (NOLOCK)
	WHERE (pr.ProductTypeID = @ProductTypeID)
	ORDER BY   pr.Seq
END

GO