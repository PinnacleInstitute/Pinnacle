EXEC [dbo].pts_CheckProc 'pts_SalesOrder_ProductFulfillment'
GO

CREATE PROCEDURE [dbo].pts_SalesOrder_ProductFulfillment
   @SalesOrderID int ,
   @Quantity int ,
   @Result nvarchar (500) OUTPUT
AS

SET NOCOUNT ON

DECLARE	@Data nvarchar(80), @Fulfill int

SET @Fulfill = @Quantity

DECLARE Product_cursor CURSOR LOCAL FOR 
SELECT pr.Data FROM Product AS pr
JOIN SalesItem AS si ON si.ProductID = pr.ProductID
WHERE si.SalesOrderID = @SalesOrderID AND pr.Fulfill = @Fulfill AND pr.Data <> ''

OPEN Product_cursor
FETCH NEXT FROM Product_cursor INTO @Data
SET @Result = ''
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Result = @Result + @Data + ','
	FETCH NEXT FROM Product_cursor INTO @Data
END
CLOSE Product_cursor
DEALLOCATE Product_cursor

GO