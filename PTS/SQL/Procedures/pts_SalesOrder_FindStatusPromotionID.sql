EXEC [dbo].pts_CheckProc 'pts_SalesOrder_FindStatusPromotionID'
 GO

CREATE PROCEDURE [dbo].pts_SalesOrder_FindStatusPromotionID ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @Status int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), so.PromotionID), '') + dbo.wtfn_FormatNumber(so.SalesOrderID, 10) 'BookMark' ,
            so.SalesOrderID 'SalesOrderID' ,
            so.CompanyID 'CompanyID' ,
            so.MemberID 'MemberID' ,
            so.ProspectID 'ProspectID' ,
            so.AffiliateID 'AffiliateID' ,
            so.PromotionID 'PromotionID' ,
            so.PartyID 'PartyID' ,
            so.AddressID 'AddressID' ,
            me.NameLast 'NameLast' ,
            me.NameFirst 'NameFirst' ,
            LTRIM(RTRIM(me.NameLast)) +  ', '  + LTRIM(RTRIM(me.NameFirst)) 'MemberName' ,
            pr.ProspectName 'ProspectName' ,
            pm.PromotionName 'PromotionName' ,
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
            so.IsRecur 'IsRecur' ,
            so.PinnDate 'PinnDate' ,
            so.PinnAmount 'PinnAmount' ,
            so.CommDate 'CommDate' ,
            so.CommAmount 'CommAmount' ,
            so.AutoShip 'AutoShip' ,
            so.IsActive 'IsActive' ,
            so.BV 'BV' ,
            so.Track 'Track' ,
            so.Valid 'Valid'
FROM SalesOrder AS so (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (so.MemberID = me.MemberID)
LEFT OUTER JOIN Prospect AS pr (NOLOCK) ON (so.ProspectID = pr.ProspectID)
LEFT OUTER JOIN Promotion AS pm (NOLOCK) ON (so.PromotionID = pm.PromotionID)
WHERE ISNULL(CONVERT(nvarchar(10), so.PromotionID), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), so.PromotionID), '') + dbo.wtfn_FormatNumber(so.SalesOrderID, 10) >= @BookMark
AND         (so.CompanyID = @CompanyID)
AND         (so.Status = @Status)
ORDER BY 'Bookmark'

GO