EXEC [dbo].pts_CheckProc 'pts_SalesItem_DuplicateProduct'
GO

CREATE PROCEDURE [dbo].pts_SalesItem_DuplicateProduct
   @SalesOrderID int ,
   @ProductID int ,
   @SalesItemID int OUTPUT
AS

SET NOCOUNT ON

SET @SalesItemID = 0

SELECT TOP 1 @SalesItemID = SalesItemID FROM SalesItem 
WHERE SalesOrderID = @SalesOrderID AND ProductID = @ProductID

GO
