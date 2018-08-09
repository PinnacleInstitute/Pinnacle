EXEC [dbo].pts_CheckProc 'pts_Prospect_FAMember'
GO

CREATE PROCEDURE [dbo].pts_Prospect_FAMember
   @MemberID int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime
AS

SET NOCOUNT ON

SELECT      pr.ProspectID, 
         pr.MemberID, 
         pr.ProspectName, 
         me.CompanyName AS 'MemberName', 
         pr.Date1, 
         pr.Potential, 
         slc.SalesCampaignName AS 'SalesCampaignName'
FROM Prospect AS pr (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (pr.MemberID = me.MemberID)
LEFT OUTER JOIN ProspectType AS pt (NOLOCK) ON (pr.ProspectTypeID = pt.ProspectTypeID)
LEFT OUTER JOIN SalesStep AS sls (NOLOCK) ON (pr.Status = sls.SalesStepID)
LEFT OUTER JOIN SalesCampaign AS slc (NOLOCK) ON (pr.SalesCampaignID = slc.SalesCampaignID)
WHERE (pr.MemberID = @MemberID)
 AND (pr.Date1 >= @ReportFromDate)
 AND (pr.Date1 <= @ReportToDate)
 AND (pr.Status > 0)

ORDER BY   pr.Date1

GO