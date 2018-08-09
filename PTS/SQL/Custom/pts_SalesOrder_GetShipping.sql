EXEC [dbo].pts_CheckProc 'pts_SalesOrder_GetShipping'
GO

CREATE PROCEDURE [dbo].pts_SalesOrder_GetShipping
   @SalesOrderID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

SET @Result = 0

SELECT @Result = COUNT(*) 
FROM Product AS pr
JOIN SalesItem AS si ON si.ProductID = pr.ProductID
WHERE si.SalesOrderID = @SalesOrderID AND pr.IsShip <> 0

GO
