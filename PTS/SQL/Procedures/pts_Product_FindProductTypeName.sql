EXEC [dbo].pts_CheckProc 'pts_Product_FindProductTypeName'
 GO

CREATE PROCEDURE [dbo].pts_Product_FindProductTypeName ( 
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
            ISNULL(pdt.ProductTypeName, '') + dbo.wtfn_FormatNumber(pd.ProductID, 10) 'BookMark' ,
            pd.ProductID 'ProductID' ,
            pd.CompanyID 'CompanyID' ,
            pd.ProductTypeID 'ProductTypeID' ,
            pdt.ProductTypeName 'ProductTypeName' ,
            pd.ProductName 'ProductName' ,
            pd.Image 'Image' ,
            pd.Price 'Price' ,
            pd.OriginalPrice 'OriginalPrice' ,
            pd.IsTaxable 'IsTaxable' ,
            pd.TaxRate 'TaxRate' ,
            pd.Tax 'Tax' ,
            pd.Description 'Description' ,
            pd.Seq 'Seq' ,
            pd.IsActive 'IsActive' ,
            pd.IsPrivate 'IsPrivate' ,
            pd.IsPublic 'IsPublic' ,
            pd.NoQty 'NoQty' ,
            pd.Data 'Data' ,
            pd.Email 'Email' ,
            pd.InputOptions 'InputOptions' ,
            pd.Ship1 'Ship1' ,
            pd.Ship2 'Ship2' ,
            pd.Ship3 'Ship3' ,
            pd.Ship4 'Ship4' ,
            pd.Ship1a 'Ship1a' ,
            pd.Ship2a 'Ship2a' ,
            pd.Ship3a 'Ship3a' ,
            pd.Ship4a 'Ship4a' ,
            pd.Fulfill 'Fulfill' ,
            pd.Recur 'Recur' ,
            pd.RecurTerm 'RecurTerm' ,
            pd.CommPlan 'CommPlan' ,
            pd.BV 'BV' ,
            pd.QV 'QV' ,
            pd.Code 'Code' ,
            pd.Inventory 'Inventory' ,
            pd.InStock 'InStock' ,
            pd.ReOrder 'ReOrder' ,
            pd.IsShip 'IsShip' ,
            pd.OrderMin 'OrderMin' ,
            pd.OrderMax 'OrderMax' ,
            pd.OrderMul 'OrderMul' ,
            pd.OrderGrp 'OrderGrp' ,
            pd.Attribute1 'Attribute1' ,
            pd.Attribute2 'Attribute2' ,
            pd.Attribute3 'Attribute3' ,
            pd.Levels 'Levels' ,
            pd.FulFillInfo 'FulFillInfo'
FROM Product AS pd (NOLOCK)
LEFT OUTER JOIN ProductType AS pdt (NOLOCK) ON (pd.ProductTypeID = pdt.ProductTypeID)
WHERE ISNULL(pdt.ProductTypeName, '') LIKE @SearchText + '%'
AND ISNULL(pdt.ProductTypeName, '') + dbo.wtfn_FormatNumber(pd.ProductID, 10) >= @BookMark
AND         (pd.CompanyID = @CompanyID)
ORDER BY 'Bookmark'

GO