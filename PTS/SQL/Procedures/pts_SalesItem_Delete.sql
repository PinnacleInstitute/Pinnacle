EXEC [dbo].pts_CheckProc 'pts_SalesItem_Delete'
GO

CREATE PROCEDURE [dbo].pts_SalesItem_Delete
   @SalesItemID int ,
   @UserID int
AS

DECLARE @mSalesOrderID int

SET NOCOUNT ON

EXEC pts_SalesItem_GetSalesOrderID
   @SalesItemID ,
   @mSalesOrderID OUTPUT

DELETE si
FROM SalesItem AS si
WHERE (si.SalesItemID = @SalesItemID)


IF ((@mSalesOrderID > 0))
   BEGIN
   EXEC pts_SalesOrder_ComputeTotalPrice
      @mSalesOrderID

   END

GO