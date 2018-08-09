EXEC [dbo].pts_CheckProc 'pts_Prospect_ListCustomers'
GO

CREATE PROCEDURE [dbo].pts_Prospect_ListCustomers
   @MemberID int
AS

SET NOCOUNT ON

SELECT      pr.ProspectID, 
         slc.Result AS 'Result', 
         slc.SalesCampaignName AS 'SalesCampaignName', 
         pt.ProspectTypeName AS 'ProspectTypeName', 
         pr.CloseDate, 
         pr.ProspectName, 
         pr.NameFirst, 
         pr.NameLast, 
         pr.Title, 
         pr.Email, 
         pr.Phone1, 
         pr.Phone2, 
         pr.Street, 
         pr.Unit, 
         pr.City, 
         pr.State, 
         pr.Zip, 
         pr.Country
FROM Prospect AS pr (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (pr.MemberID = me.MemberID)
LEFT OUTER JOIN ProspectType AS pt (NOLOCK) ON (pr.ProspectTypeID = pt.ProspectTypeID)
LEFT OUTER JOIN SalesStep AS sls (NOLOCK) ON (pr.Status = sls.SalesStepID)
LEFT OUTER JOIN SalesCampaign AS slc (NOLOCK) ON (pr.SalesCampaignID = slc.SalesCampaignID)
WHERE (pr.MemberID = @MemberID)
 AND (pr.Status = 4)

ORDER BY   slc.Result

GO