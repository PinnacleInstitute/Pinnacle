EXEC [dbo].pts_CheckProc 'pts_Prospect_ClosedMember'
GO

CREATE PROCEDURE [dbo].pts_Prospect_ClosedMember
   @MemberID int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime
AS

SET NOCOUNT ON

SELECT      pr.ProspectID, 
         pr.MemberID, 
         pr.ProspectName, 
         me.CompanyName AS 'MemberName', 
         pr.CloseDate, 
         pr.Potential
FROM Prospect AS pr (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (pr.MemberID = me.MemberID)
LEFT OUTER JOIN ProspectType AS pt (NOLOCK) ON (pr.ProspectTypeID = pt.ProspectTypeID)
LEFT OUTER JOIN SalesStep AS sls (NOLOCK) ON (pr.Status = sls.SalesStepID)
LEFT OUTER JOIN SalesCampaign AS slc (NOLOCK) ON (pr.SalesCampaignID = slc.SalesCampaignID)
WHERE (pr.MemberID = @MemberID)
 AND (pr.CloseDate >= @ReportFromDate)
 AND (pr.CloseDate <= @ReportToDate)
 AND (pr.Status = 4)

ORDER BY   pr.CloseDate DESC

GO