EXEC [dbo].pts_CheckProc 'pts_Commission_Report'
GO

--EXEC pts_Commission_Report 12, '5/4/10', '5/4/10'

CREATE PROCEDURE [dbo].pts_Commission_Report
   @CompanyID int ,
   @FromDate datetime ,
   @ToDate datetime
AS

SET NOCOUNT ON
SET @ToDate = DATEADD(d,1,@ToDate)

SELECT   co.CommissionID, 
         me.reference + ',' + me.NameFirst + ' ' + me.NameLast + ',' + ti.TitleName AS 'Description', 
         co.Amount AS 'Amount', 
         pr.ProspectName AS 'CommTypeName', 
         co.CommDate AS 'CommDate', 
         so.Amount AS 'Total', 
         so.Notes AS 'Notes'
FROM Commission AS co
JOIN Member AS me ON co.OwnerType = 4 AND co.OwnerID = me.MemberID
LEFT OUTER JOIN SalesOrder AS so ON co.RefID = so.SalesOrderID
LEFT OUTER JOIN Prospect AS pr ON so.ProspectID = pr.ProspectID
LEFT OUTER JOIN Title AS ti ON (ti.CompanyID = @CompanyID AND ti.TitleNo = me.Title)
WHERE co.CompanyID = @CompanyID
AND co.CommDate >= @FromDate
AND co.CommDate <= @ToDate
AND co.Status = 0
ORDER BY me.reference, co.CommDate, co.Amount

GO

