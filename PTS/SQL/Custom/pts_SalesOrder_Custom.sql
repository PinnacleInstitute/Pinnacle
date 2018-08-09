EXEC [dbo].pts_CheckProc 'pts_SalesOrder_Custom'
GO

--EXEC pts_SalesOrder_Custom 9, 102, 0

CREATE PROCEDURE [dbo].pts_SalesOrder_Custom
   @CompanyID int ,
   @Status int ,
   @SalesOrderID int
AS

SET NOCOUNT ON
DECLARE @OldStatus int, @NewStatus int, @Today datetime 
SET @Today = dbo.wtfn_DateOnly( GETDATE() )

IF @Status < 100 OR @Status > 103
BEGIN
	IF @CompanyID = 1  EXEC pts_SalesOrder_Custom_1 @Status, @SalesOrderID  
	IF @CompanyID = 9  EXEC pts_SalesOrder_Custom_9 @Status, @SalesOrderID  
	IF @CompanyID = 11  EXEC pts_SalesOrder_Custom_11 @Status, @SalesOrderID  
	IF @CompanyID = 13  EXEC pts_SalesOrder_Custom_13 @Status, @SalesOrderID  
--	IF @CompanyID = 14  EXEC pts_SalesOrder_Custom_14 @Status, @SalesOrderID  
END

-- Delete All abandoned Shopping Carts older than today
IF @Status = 100
BEGIN
	DELETE si FROM SalesItem AS si
	JOIN SalesOrder AS so ON si.SalesOrderID = so.SalesOrderID 
	WHERE so.CompanyID = @CompanyID AND so.Status = 0 AND so.OrderDate < @Today

	DELETE SalesOrder WHERE CompanyID = @CompanyID AND Status = 0 AND OrderDate < @Today
END

GO