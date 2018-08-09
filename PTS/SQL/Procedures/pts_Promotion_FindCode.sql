EXEC [dbo].pts_CheckProc 'pts_Promotion_FindCode'
 GO

CREATE PROCEDURE [dbo].pts_Promotion_FindCode ( 
   @SearchText nvarchar (6),
   @Bookmark nvarchar (16),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(pm.Code, '') + dbo.wtfn_FormatNumber(pm.PromotionID, 10) 'BookMark' ,
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
WHERE ISNULL(pm.Code, '') LIKE @SearchText + '%'
AND ISNULL(pm.Code, '') + dbo.wtfn_FormatNumber(pm.PromotionID, 10) >= @BookMark
AND         (pm.CompanyID = @CompanyID)
ORDER BY 'Bookmark'

GO