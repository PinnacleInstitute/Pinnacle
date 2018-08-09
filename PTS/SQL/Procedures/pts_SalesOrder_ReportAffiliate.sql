EXEC [dbo].pts_CheckProc 'pts_SalesOrder_ReportAffiliate'
GO

CREATE PROCEDURE [dbo].pts_SalesOrder_ReportAffiliate
   @AffiliateID int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime
AS

SET NOCOUNT ON

SELECT      so.SalesOrderID, 
         so.OrderDate, 
         me.NameFirst AS 'NameFirst', 
         me.NameLast AS 'NameLast', 
         so.Amount, 
         so.Total
FROM SalesOrder AS so (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (so.MemberID = me.MemberID)
LEFT OUTER JOIN Prospect AS pr (NOLOCK) ON (so.ProspectID = pr.ProspectID)
WHERE (so.AffiliateID = @AffiliateID)
 AND (so.Status >= 1)
 AND (so.Status <= 3)
 AND (so.OrderDate >= @ReportFromDate)
 AND (so.OrderDate <= @ReportToDate)

ORDER BY   so.OrderDate

GO