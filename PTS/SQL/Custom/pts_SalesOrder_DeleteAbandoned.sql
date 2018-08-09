EXEC [dbo].pts_CheckProc 'pts_SalesOrder_DeleteAbandoned'
GO

CREATE PROCEDURE [dbo].pts_SalesOrder_DeleteAbandoned
   @CompanyID int
AS

SET NOCOUNT ON

DECLARE @Today datetime
SET @Today = dbo.wtfn_DateOnly( GETDATE() )

DELETE si FROM SalesItem AS si
JOIN SalesOrder AS so ON si.SalesOrderID = so.SalesOrderID 
WHERE so.CompanyID = @CompanyID AND so.Status = 0 AND so.OrderDate < @Today

DELETE SalesOrder WHERE CompanyID = @CompanyID AND Status = 0 AND OrderDate < @Today

GO