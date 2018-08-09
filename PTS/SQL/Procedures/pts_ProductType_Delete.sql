EXEC [dbo].pts_CheckProc 'pts_ProductType_Delete'
 GO

CREATE PROCEDURE [dbo].pts_ProductType_Delete ( 
   @ProductTypeID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE pdt
FROM ProductType AS pdt
WHERE pdt.ProductTypeID = @ProductTypeID

GO