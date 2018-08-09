EXEC [dbo].pts_CheckProc 'pts_SalesOrder_ProductEmails'
GO

CREATE PROCEDURE [dbo].pts_SalesOrder_ProductEmails
   @SalesOrderID int ,
   @Result nvarchar(500) OUTPUT
AS

SET NOCOUNT ON

DECLARE	@Email nvarchar(80)

DECLARE Product_cursor CURSOR LOCAL FOR 
SELECT pr.Email FROM Product AS pr
JOIN SalesItem AS si ON si.ProductID = pr.ProductID
WHERE si.SalesOrderID = @SalesOrderID AND pr.Email <> ''

OPEN Product_cursor
FETCH NEXT FROM Product_cursor INTO @Email
SET @Result = ''
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Result = @Result + @Email + ';'
	FETCH NEXT FROM Product_cursor INTO @Email
END
CLOSE Product_cursor
DEALLOCATE Product_cursor

GO