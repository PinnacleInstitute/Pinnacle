EXEC [dbo].pts_CheckProc 'pts_SalesOrder_ListMember'
GO

CREATE PROCEDURE [dbo].pts_SalesOrder_ListMember
   @MemberID int
AS

SET NOCOUNT ON

SELECT      so.SalesOrderID, 
         so.OrderDate, 
         so.Total, 
         so.BV, 
         so.Status, 
         so.Notes, 
         so.IsRecur, 
         so.ProspectID, 
         pr.ProspectName AS 'ProspectName', 
         so.Track
FROM SalesOrder AS so (NOLOCK)
LEFT OUTER JOIN Prospect AS pr (NOLOCK) ON (so.ProspectID = pr.ProspectID)
WHERE (so.MemberID = @MemberID)
 AND (so.Status <> 0)

ORDER BY   so.OrderDate DESC

GO