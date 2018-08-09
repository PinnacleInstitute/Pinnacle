EXEC [dbo].pts_CheckProc 'pts_SalesItem_DeleteSalesOrder'
 GO

CREATE PROCEDURE [dbo].pts_SalesItem_DeleteSalesOrder ( 
   @SalesOrderID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE si
FROM SalesItem AS si
WHERE (si.SalesOrderID = @SalesOrderID)

GO