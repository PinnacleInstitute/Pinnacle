EXEC [dbo].pts_CheckProc 'pts_Product_Copy'
 GO

CREATE PROCEDURE [dbo].pts_Product_Copy ( 
   @ProductID int OUTPUT,
   @CopyProductID int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()

INSERT INTO Product (
            CompanyID , 
            ProductTypeID , 
            ProductName , 
            Image , 
            Price , 
            OriginalPrice , 
            IsTaxable , 
            TaxRate , 
            Tax , 
            Description , 
            Seq , 
            IsActive , 
            IsPrivate , 
            IsPublic , 
            NoQty , 
            Data , 
            Email , 
            InputOptions , 
            Ship1 , 
            Ship2 , 
            Ship3 , 
            Ship4 , 
            Ship1a , 
            Ship2a , 
            Ship3a , 
            Ship4a , 
            Fulfill , 
            Recur , 
            RecurTerm , 
            CommPlan , 
            BV , 
            QV , 
            Code , 
            Inventory , 
            InStock , 
            ReOrder , 
            IsShip , 
            OrderMin , 
            OrderMax , 
            OrderMul , 
            OrderGrp , 
            Attribute1 , 
            Attribute2 , 
            Attribute3 , 
            Levels , 
            FulFillInfo
            )
SELECT            pd.CompanyID , 
            pd.ProductTypeID , 
            'Copy of ' + substring(pd.ProductName,1,32) , 
            pd.Image , 
            pd.Price , 
            pd.OriginalPrice , 
            pd.IsTaxable , 
            pd.TaxRate , 
            pd.Tax , 
            pd.Description , 
            pd.Seq , 
            pd.IsActive , 
            pd.IsPrivate , 
            pd.IsPublic , 
            pd.NoQty , 
            pd.Data , 
            pd.Email , 
            pd.InputOptions , 
            pd.Ship1 , 
            pd.Ship2 , 
            pd.Ship3 , 
            pd.Ship4 , 
            pd.Ship1a , 
            pd.Ship2a , 
            pd.Ship3a , 
            pd.Ship4a , 
            pd.Fulfill , 
            pd.Recur , 
            pd.RecurTerm , 
            pd.CommPlan , 
            pd.BV , 
            pd.QV , 
            pd.Code , 
            pd.Inventory , 
            pd.InStock , 
            pd.ReOrder , 
            pd.IsShip , 
            pd.OrderMin , 
            pd.OrderMax , 
            pd.OrderMul , 
            pd.OrderGrp , 
            pd.Attribute1 , 
            pd.Attribute2 , 
            pd.Attribute3 , 
            pd.Levels , 
            pd.FulFillInfo
FROM Product AS pd
WHERE pd.ProductID = @CopyProductID
SET @mNewID = @@IDENTITY
SET @ProductID = @mNewID

GO