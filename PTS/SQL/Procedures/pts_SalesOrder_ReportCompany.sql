EXEC [dbo].pts_CheckProc 'pts_SalesOrder_ReportCompany'
GO

CREATE PROCEDURE [dbo].pts_SalesOrder_ReportCompany
   @CompanyID int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime
AS

SET NOCOUNT ON

SELECT      so.SalesOrderID, 
         so.OrderDate, 
         so.MemberID, 
         LTRIM(RTRIM(me.NameLast)) +  ', '  + LTRIM(RTRIM(me.NameFirst)) AS 'MemberName', 
         so.Total, 
         so.Amount, 
         so.Shipping, 
         so.Tax
FROM SalesOrder AS so (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (so.MemberID = me.MemberID)
LEFT OUTER JOIN Prospect AS pr (NOLOCK) ON (so.ProspectID = pr.ProspectID)
WHERE (so.CompanyID = @CompanyID)
 AND (so.Status >= 1)
 AND (so.Status <= 3)
 AND (so.OrderDate >= @ReportFromDate)
 AND (so.OrderDate <= @ReportToDate)

ORDER BY   so.OrderDate

GO