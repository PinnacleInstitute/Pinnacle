EXEC [dbo].pts_CheckProc 'pts_SalesItem_FindProductName'
 GO

CREATE PROCEDURE [dbo].pts_SalesItem_FindProductName ( 
   @SearchText nvarchar (40),
   @Bookmark nvarchar (50),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(pd.ProductName, '') + dbo.wtfn_FormatNumber(si.SalesItemID, 10) 'BookMark' ,
            si.SalesItemID 'SalesItemID' ,
            si.SalesOrderID 'SalesOrderID' ,
            si.ProductID 'ProductID' ,
            so.CompanyID 'CompanyID' ,
            so.OrderDate 'OrderDate' ,
            pd.ProductName 'ProductName' ,
            pd.Image 'Image' ,
            pd.InputOptions 'InputOptions' ,
            si.Quantity 'Quantity' ,
            si.Price 'Price' ,
            si.OptionPrice 'OptionPrice' ,
            si.Tax 'Tax' ,
            si.InputValues 'InputValues' ,
            si.Reference 'Reference' ,
            si.Status 'Status' ,
            si.BillDate 'BillDate' ,
            si.EndDate 'EndDate' ,
            si.Locks 'Locks' ,
            si.BV 'BV' ,
            si.Valid 'Valid'
FROM SalesItem AS si (NOLOCK)
LEFT OUTER JOIN SalesOrder AS so (NOLOCK) ON (si.SalesOrderID = so.SalesOrderID)
LEFT OUTER JOIN Product AS pd (NOLOCK) ON (si.ProductID = pd.ProductID)
WHERE ISNULL(pd.ProductName, '') LIKE @SearchText + '%'
AND ISNULL(pd.ProductName, '') + dbo.wtfn_FormatNumber(si.SalesItemID, 10) >= @BookMark
AND         (so.CompanyID = @CompanyID)
ORDER BY 'Bookmark'

GO