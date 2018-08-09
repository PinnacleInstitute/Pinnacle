EXEC [dbo].pts_CheckProc 'pts_Product_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Product_Delete ( 
   @ProductID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE pd
FROM Product AS pd
WHERE pd.ProductID = @ProductID

GO