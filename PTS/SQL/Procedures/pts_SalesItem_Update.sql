EXEC [dbo].pts_CheckProc 'pts_SalesItem_Update'
GO

CREATE PROCEDURE [dbo].pts_SalesItem_Update
   @SalesItemID int,
   @SalesOrderID int,
   @ProductID int,
   @Quantity int,
   @Price money,
   @OptionPrice money,
   @Tax money,
   @InputValues nvarchar (500),
   @Reference nvarchar (50),
   @Status int,
   @BillDate datetime,
   @EndDate datetime,
   @Locks int,
   @BV money,
   @Valid int,
   @UserID int
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()
UPDATE si
SET si.SalesOrderID = @SalesOrderID ,
   si.ProductID = @ProductID ,
   si.Quantity = @Quantity ,
   si.Price = @Price ,
   si.OptionPrice = @OptionPrice ,
   si.Tax = @Tax ,
   si.InputValues = @InputValues ,
   si.Reference = @Reference ,
   si.Status = @Status ,
   si.BillDate = @BillDate ,
   si.EndDate = @EndDate ,
   si.Locks = @Locks ,
   si.BV = @BV ,
   si.Valid = @Valid
FROM SalesItem AS si
WHERE (si.SalesItemID = @SalesItemID)


EXEC pts_SalesItem_ComputeSalesTax
   @SalesItemID

EXEC pts_SalesOrder_ComputeTotalPrice
   @SalesOrderID

GO