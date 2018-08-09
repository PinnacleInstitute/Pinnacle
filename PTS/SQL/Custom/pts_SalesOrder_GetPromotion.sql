EXEC [dbo].pts_CheckProc 'pts_SalesOrder_GetPromotion'
GO

CREATE PROCEDURE [dbo].pts_SalesOrder_GetPromotion
   @SalesOrderID int ,
   @NameLast nvarchar (30) ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

DECLARE @Code nvarchar(6), @CompanyID int, @OrderDate datetime, @Status int
DECLARE @PromotionID int, @StartDate datetime, @EndDate datetime, @Qty int, @Used int

SET @Code = @NameLast
SET @Result = 0

SELECT @CompanyID = CompanyID, @OrderDate = OrderDate, @Status = Status 
FROM SalesOrder WHERE SalesOrderID = @SalesOrderID

SELECT @PromotionID = PromotionID, @StartDate = StartDate, @EndDate = EndDate, @Qty = Qty, @Used = Used
FROM Promotion WHERE CompanyID = @CompanyID AND Code = @Code

-- If this is a new sales order, increment the @Used count
IF @Status = 0 SET @Used = @Used + 1 

-- Check if we found the promotion
IF @PromotionID IS NULL 
BEGIN
	SET @Result = 1
	RETURN
END 

-- Check if the promotion has started
IF @StartDate > 0 AND @OrderDate < @StartDate
BEGIN
	SET @Result = 2
	RETURN
END 

-- Check if the promotion has expired	
SET @EndDate = DATEADD( day, 1, @EndDate)
IF @EndDate > 0 AND @OrderDate > @EndDate  
BEGIN
	SET @Result = 3
	RETURN
END

-- Check if the qty has been reached
IF @Qty > 0 AND @Used >= @Qty
BEGIN
	SET @Result = 4
	RETURN
END 

-- Update PromotionID on Sales Order
UPDATE SalesOrder SET PromotionID = @PromotionID WHERE SalesOrderID = @SalesOrderID

GO

