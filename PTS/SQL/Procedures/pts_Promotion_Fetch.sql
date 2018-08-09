EXEC [dbo].pts_CheckProc 'pts_Promotion_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Promotion_Fetch ( 
   @PromotionID int,
   @CompanyID int OUTPUT,
   @ProductID int OUTPUT,
   @PromotionName nvarchar (60) OUTPUT,
   @Description nvarchar (500) OUTPUT,
   @Code nvarchar (6) OUTPUT,
   @Amount money OUTPUT,
   @Rate money OUTPUT,
   @StartDate datetime OUTPUT,
   @EndDate datetime OUTPUT,
   @Qty int OUTPUT,
   @Used int OUTPUT,
   @Products nvarchar (50) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = pm.CompanyID ,
   @ProductID = pm.ProductID ,
   @PromotionName = pm.PromotionName ,
   @Description = pm.Description ,
   @Code = pm.Code ,
   @Amount = pm.Amount ,
   @Rate = pm.Rate ,
   @StartDate = pm.StartDate ,
   @EndDate = pm.EndDate ,
   @Qty = pm.Qty ,
   @Used = pm.Used ,
   @Products = pm.Products
FROM Promotion AS pm (NOLOCK)
WHERE pm.PromotionID = @PromotionID

GO