EXEC [dbo].pts_CheckProc 'pts_SalesOrder_ListAutoShip'
GO

CREATE PROCEDURE [dbo].pts_SalesOrder_ListAutoShip
   @MemberID int
AS

SET NOCOUNT ON

SELECT      so.SalesOrderID, 
         so.OrderDate, 
         so.Total, 
         so.Notes, 
         so.IsActive, 
         so.Valid
FROM SalesOrder AS so (NOLOCK)
WHERE (so.MemberID = @MemberID)
 AND (so.AutoShip = 2)

ORDER BY   so.IsActive DESC , so.OrderDate

GO