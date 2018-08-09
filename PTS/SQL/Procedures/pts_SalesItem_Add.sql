EXEC [dbo].pts_CheckProc 'pts_SalesItem_Add'
GO

CREATE PROCEDURE [dbo].pts_SalesItem_Add
   @SalesItemID int OUTPUT,
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

DECLARE @mNow datetime, 
         @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()
INSERT INTO SalesItem (
            SalesOrderID , 
            ProductID , 
            Quantity , 
            Price , 
            OptionPrice , 
            Tax , 
            InputValues , 
            Reference , 
            Status , 
            BillDate , 
            EndDate , 
            Locks , 
            BV , 
            Valid

            )
VALUES (
            @SalesOrderID ,
            @ProductID ,
            @Quantity ,
            @Price ,
            @OptionPrice ,
            @Tax ,
            @InputValues ,
            @Reference ,
            @Status ,
            @BillDate ,
            @EndDate ,
            @Locks ,
            @BV ,
            @Valid
            )

SET @mNewID = @@IDENTITY
SET @SalesItemID = @mNewID
EXEC pts_SalesItem_ComputeSalesTax
   @SalesItemID

EXEC pts_SalesOrder_ComputeTotalPrice
   @SalesOrderID

GO