EXEC [dbo].pts_CheckProc 'pts_SalesItem_FindOrderDate'
 GO

CREATE PROCEDURE [dbo].pts_SalesItem_FindOrderDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20
IF (@Bookmark = '') SET @Bookmark = '99991231'
IF (ISDATE(@SearchText) = 1)
            SET @SearchText = CONVERT(nvarchar(10), CONVERT(datetime, @SearchText), 112)
ELSE
            SET @SearchText = ''


SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), so.OrderDate, 112), '') + dbo.wtfn_FormatNumber(si.SalesItemID, 10) 'BookMark' ,
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
WHERE ISNULL(CONVERT(nvarchar(10), so.OrderDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), so.OrderDate, 112), '') + dbo.wtfn_FormatNumber(si.SalesItemID, 10) <= @BookMark
AND         (so.CompanyID = @CompanyID)
ORDER BY 'Bookmark' DESC

GO