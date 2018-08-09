EXEC [dbo].pts_CheckProc 'pts_SalesOrder_FindStatus'
 GO

CREATE PROCEDURE [dbo].pts_SalesOrder_FindStatus ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), so.Status), '') + dbo.wtfn_FormatNumber(so.SalesOrderID, 10) 'BookMark' ,
            so.SalesOrderID 'SalesOrderID' ,
            so.CompanyID 'CompanyID' ,
            so.MemberID 'MemberID' ,
            so.AffiliateID 'AffiliateID' ,
            so.PromotionID 'PromotionID' ,
            me.NameLast 'NameLast' ,
            me.NameFirst 'NameFirst' ,
            LTRIM(RTRIM(me.NameLast)) +  ', '  + LTRIM(RTRIM(me.NameFirst)) 'MemberName' ,
            so.OrderDate 'OrderDate' ,
            so.Amount 'Amount' ,
            so.Tax 'Tax' ,
            so.Total 'Total' ,
            so.Status 'Status' ,
            so.Notes 'Notes' ,
            so.Discount 'Discount' ,
            so.Shipping 'Shipping' ,
            so.Ship 'Ship' ,
            so.IsTaxable 'IsTaxable' ,
            so.IsRecur 'IsRecur'
FROM SalesOrder AS so (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (so.MemberID = me.MemberID)
WHERE ISNULL(CONVERT(nvarchar(10), so.Status), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), so.Status), '') + dbo.wtfn_FormatNumber(so.SalesOrderID, 10) >= @BookMark
AND         (so.CompanyID = @CompanyID)
ORDER BY 'Bookmark'

GO