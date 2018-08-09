EXEC [dbo].pts_CheckProc 'pts_Promotion_FindPromotionID'
 GO

CREATE PROCEDURE [dbo].pts_Promotion_FindPromotionID ( 
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
            ISNULL(CONVERT(nvarchar(10), pm.PromotionID), '') + dbo.wtfn_FormatNumber(pm.PromotionID, 10) 'BookMark' ,
            pm.PromotionID 'PromotionID' ,
            pm.CompanyID 'CompanyID' ,
            pm.ProductID 'ProductID' ,
            pm.PromotionName 'PromotionName' ,
            pm.Description 'Description' ,
            pm.Code 'Code' ,
            pm.Amount 'Amount' ,
            pm.Rate 'Rate' ,
            pm.StartDate 'StartDate' ,
            pm.EndDate 'EndDate' ,
            pm.Qty 'Qty' ,
            pm.Used 'Used' ,
            pm.Products 'Products'
FROM Promotion AS pm (NOLOCK)
WHERE ISNULL(CONVERT(nvarchar(10), pm.PromotionID), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), pm.PromotionID), '') + dbo.wtfn_FormatNumber(pm.PromotionID, 10) >= @BookMark
AND         (pm.CompanyID = @CompanyID)
ORDER BY 'Bookmark'

GO