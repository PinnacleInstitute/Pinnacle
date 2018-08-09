EXEC [dbo].pts_CheckProc 'pts_SalesItem_GetSalesOrderID'
GO

CREATE PROCEDURE [dbo].pts_SalesItem_GetSalesOrderID
   @SalesItemID int ,
   @SalesOrderID int OUTPUT
AS

SET NOCOUNT ON

SELECT @SalesOrderID = SalesOrderID FROM SalesItem WHERE SalesItemID = @SalesItemID

GO

