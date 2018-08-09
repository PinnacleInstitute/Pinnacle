EXEC [dbo].pts_CheckProc 'pts_SalesItem_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_SalesItem_Fetch ( 
   @SalesItemID int,
   @SalesOrderID int OUTPUT,
   @ProductID int OUTPUT,
   @CompanyID int OUTPUT,
   @OrderDate datetime OUTPUT,
   @ProductName nvarchar (40) OUTPUT,
   @Image nvarchar (40) OUTPUT,
   @InputOptions nvarchar (1000) OUTPUT,
   @Quantity int OUTPUT,
   @Price money OUTPUT,
   @OptionPrice money OUTPUT,
   @Tax money OUTPUT,
   @InputValues nvarchar (500) OUTPUT,
   @Reference nvarchar (50) OUTPUT,
   @Status int OUTPUT,
   @BillDate datetime OUTPUT,
   @EndDate datetime OUTPUT,
   @Locks int OUTPUT,
   @BV money OUTPUT,
   @Valid int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @SalesOrderID = si.SalesOrderID ,
   @ProductID = si.ProductID ,
   @CompanyID = so.CompanyID ,
   @OrderDate = so.OrderDate ,
   @ProductName = pd.ProductName ,
   @Image = pd.Image ,
   @InputOptions = pd.InputOptions ,
   @Quantity = si.Quantity ,
   @Price = si.Price ,
   @OptionPrice = si.OptionPrice ,
   @Tax = si.Tax ,
   @InputValues = si.InputValues ,
   @Reference = si.Reference ,
   @Status = si.Status ,
   @BillDate = si.BillDate ,
   @EndDate = si.EndDate ,
   @Locks = si.Locks ,
   @BV = si.BV ,
   @Valid = si.Valid
FROM SalesItem AS si (NOLOCK)
LEFT OUTER JOIN SalesOrder AS so (NOLOCK) ON (si.SalesOrderID = so.SalesOrderID)
LEFT OUTER JOIN Product AS pd (NOLOCK) ON (si.ProductID = pd.ProductID)
WHERE si.SalesItemID = @SalesItemID

GO