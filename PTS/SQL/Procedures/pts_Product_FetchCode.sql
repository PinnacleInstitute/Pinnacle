EXEC [dbo].pts_CheckProc 'pts_Product_FetchCode'
GO

CREATE PROCEDURE [dbo].pts_Product_FetchCode
   @CompanyID int ,
   @Code nvarchar (10) ,
   @ProductID int OUTPUT ,
   @Price money OUTPUT ,
   @BV money OUTPUT
AS

DECLARE @mProductID int, 
         @mPrice money, 
         @mBV money

SET NOCOUNT ON

SELECT      @mProductID = pd.ProductID, 
         @mPrice = pd.Price, 
         @mBV = pd.BV
FROM Product AS pd (NOLOCK)
WHERE (pd.CompanyID = @CompanyID)
 AND (pd.Code = @Code)


SET @ProductID = ISNULL(@mProductID, 0)
SET @Price = ISNULL(@mPrice, 0)
SET @BV = ISNULL(@mBV, 0)
GO