EXEC [dbo].pts_CheckProc 'pts_SalesOrder_ListDate'
GO

CREATE PROCEDURE [dbo].pts_SalesOrder_ListDate
   @CompanyID int ,
   @OrderDate datetime
AS

SET NOCOUNT ON

SELECT      so.SalesOrderID, 
         so.OrderDate, 
         me.NameFirst AS 'NameFirst', 
         me.NameLast AS 'NameLast', 
         so.Total, 
         so.Notes
FROM SalesOrder AS so (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (so.MemberID = me.MemberID)
LEFT OUTER JOIN Prospect AS pr (NOLOCK) ON (so.ProspectID = pr.ProspectID)
WHERE (so.CompanyID = @CompanyID)
 AND (dbo.wtfn_DateOnly(so.OrderDate) = @OrderDate)
 AND (so.Status >= 1)
 AND (so.Status <= 3)


GO