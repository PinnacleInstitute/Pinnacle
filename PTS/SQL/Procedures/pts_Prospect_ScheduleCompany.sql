EXEC [dbo].pts_CheckProc 'pts_Prospect_ScheduleCompany'
GO

CREATE PROCEDURE [dbo].pts_Prospect_ScheduleCompany
   @CompanyID int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime
AS

SET NOCOUNT ON

SELECT      pr.ProspectID, 
         pr.MemberID, 
         pr.ProspectName, 
         me.CompanyName AS 'MemberName', 
         pr.Status, 
         sls.SalesStepName AS 'StatusName', 
         pr.NextDate, 
         pr.NextTime, 
         pr.NextEvent
FROM Prospect AS pr (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (pr.MemberID = me.MemberID)
LEFT OUTER JOIN ProspectType AS pt (NOLOCK) ON (pr.ProspectTypeID = pt.ProspectTypeID)
LEFT OUTER JOIN SalesStep AS sls (NOLOCK) ON (pr.Status = sls.SalesStepID)
LEFT OUTER JOIN SalesCampaign AS slc (NOLOCK) ON (pr.SalesCampaignID = slc.SalesCampaignID)
WHERE (pr.CompanyID = @CompanyID)
 AND (pr.NextDate >= @ReportFromDate)
 AND (pr.NextDate <= @ReportToDate)
 AND (pr.Status > 0)

ORDER BY   pr.NextDate , pr.NextTime

GO