EXEC [dbo].pts_CheckProc 'pts_SalesOrder_Delete'
GO

CREATE PROCEDURE [dbo].pts_SalesOrder_Delete
   @SalesOrderID int ,
   @UserID int
AS

SET NOCOUNT ON

EXEC pts_SalesItem_DeleteSalesOrder
   @SalesOrderID ,
   @UserID

DELETE so
FROM SalesOrder AS so
WHERE (so.SalesOrderID = @SalesOrderID)


GO