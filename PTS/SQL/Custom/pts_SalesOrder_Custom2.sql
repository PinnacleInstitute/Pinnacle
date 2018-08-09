EXEC [dbo].pts_CheckProc 'pts_SalesOrder_Custom2'
GO

--EXEC pts_SalesOrder_Custom2 13, 102, 0, 0, 0

CREATE PROCEDURE [dbo].pts_SalesOrder_Custom2
   @CompanyID int ,
   @Status int ,
   @OrderDate datetime ,
   @Quantity int ,
   @Amount int
AS

SET NOCOUNT ON
DECLARE @OldStatus int, @NewStatus int

IF @OrderDate = 0 SET @OrderDate = dbo.wtfn_DateOnly(GETDATE())

-- Update Order Status
IF @Status = 101 OR @Status = 102 OR @Status = 103
BEGIN
	IF @Status = 101
	BEGIN
		SET @OldStatus = 1
		SET @NewStatus = 2
	END	
	IF @Status = 102
	BEGIN
		SET @OldStatus = 2
		SET @NewStatus = 3
	END	
	IF @Status = 103
	BEGIN
		SET @OldStatus = 1
		SET @NewStatus = 3
	END	
	
	UPDATE si SET Status = @NewStatus
	FROM SalesItem AS si
	JOIN SalesOrder AS so ON si.SalesOrderID = so.SalesOrderID
	WHERE so.CompanyID = @CompanyID AND so.Status = @OldStatus AND dbo.wtfn_DateOnly(so.OrderDate) <= @OrderDate
	AND ( SELECT COUNT(*) FROM Payment WHERE OwnerType = 52 AND OwnerID = so.SalesOrderID AND Status = 3 ) > 0

	UPDATE so SET Status = @NewStatus FROM SalesOrder AS so
	WHERE CompanyID = @CompanyID AND Status = @OldStatus AND dbo.wtfn_DateOnly(so.OrderDate) <= @OrderDate
	AND ( SELECT COUNT(*) FROM Payment WHERE OwnerType = 52 AND OwnerID = so.SalesOrderID AND Status = 3 ) > 0
END


GO