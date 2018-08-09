EXEC [dbo].pts_CheckProc 'pts_Promotion_Update'
 GO

CREATE PROCEDURE [dbo].pts_Promotion_Update ( 
   @PromotionID int,
   @CompanyID int,
   @ProductID int,
   @PromotionName nvarchar (60),
   @Description nvarchar (500),
   @Code nvarchar (6),
   @Amount money,
   @Rate money,
   @StartDate datetime,
   @EndDate datetime,
   @Qty int,
   @Used int,
   @Products nvarchar (50),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE pm
SET pm.CompanyID = @CompanyID ,
   pm.ProductID = @ProductID ,
   pm.PromotionName = @PromotionName ,
   pm.Description = @Description ,
   pm.Code = @Code ,
   pm.Amount = @Amount ,
   pm.Rate = @Rate ,
   pm.StartDate = @StartDate ,
   pm.EndDate = @EndDate ,
   pm.Qty = @Qty ,
   pm.Used = @Used ,
   pm.Products = @Products
FROM Promotion AS pm
WHERE pm.PromotionID = @PromotionID

GO