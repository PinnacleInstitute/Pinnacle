EXEC [dbo].pts_CheckProc 'pts_Prospect_MemberActive'
GO

CREATE PROCEDURE [dbo].pts_Prospect_MemberActive
   @MemberID int
AS

SET NOCOUNT ON

SELECT      pr.ProspectID, 
         pr.ProspectName, 
         slc.SalesCampaignName AS 'SalesCampaignName', 
         pr.CreateDate, 
         pr.Potential, 
         pr.NextDate, 
         pr.NextTime, 
         pr.NextEvent
FROM Prospect AS pr (NOLOCK)
LEFT OUTER JOIN SalesCampaign AS slc (NOLOCK) ON (pr.SalesCampaignID = slc.SalesCampaignID)
WHERE (pr.MemberID = @MemberID)
 AND (pr.Status > 5)
 AND (pr.NextEvent <> 0)
 AND (pr.NextDate <> 0)

ORDER BY   slc.SalesCampaignName , pr.ProspectName

GO