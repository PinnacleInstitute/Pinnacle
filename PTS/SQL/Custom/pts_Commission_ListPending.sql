EXEC [dbo].pts_CheckProc 'pts_Commission_ListPending'
GO

--EXEC pts_Commission_ListPending 12, '4/1/10', '4/30/10'

CREATE PROCEDURE [dbo].pts_Commission_ListPending
   @CompanyID int ,
   @FromDate datetime ,
   @ToDate datetime
AS

SET NOCOUNT ON

SELECT co.CommissionID, 
       co.CommDate, 
       co.Amount,
       me.NameLast + ', ' + me.NameFirst AS 'Description', 
       ct.CommTypeName + ', ' + co.Description AS 'CommTypeName', 
       pr.ProspectName AS 'Notes' 
FROM Commission AS co (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON co.OwnerType = 4 AND co.OwnerID = me.MemberID
LEFT OUTER JOIN CommType AS ct (NOLOCK) ON (co.CompanyID = ct.CompanyID AND co.CommType = ct.CommTypeNo)
LEFT OUTER JOIN SalesOrder AS so (NOLOCK) ON (co.RefID = so.SalesOrderID)
LEFT OUTER JOIN Prospect AS pr (NOLOCK) ON (so.ProspectID = pr.ProspectID)
WHERE (co.CompanyID = @CompanyID)
 AND (co.Status = 0)
 AND (co.CommDate >= @FromDate)
 AND (co.CommDate <= @ToDate)

GO