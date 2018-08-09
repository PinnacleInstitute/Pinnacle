EXEC [dbo].pts_CheckProc 'pts_SalesOrder_ListProspect'
GO

CREATE PROCEDURE [dbo].pts_SalesOrder_ListProspect
   @ProspectID int
AS

SET NOCOUNT ON

SELECT      so.SalesOrderID, 
         so.OrderDate, 
         so.Total, 
         so.BV, 
         so.Status, 
         so.Notes, 
         so.IsRecur
FROM SalesOrder AS so (NOLOCK)
WHERE (so.ProspectID = @ProspectID)
 AND (so.Status >= 1)
 AND (so.Status <= 3)

ORDER BY   so.OrderDate DESC

GO