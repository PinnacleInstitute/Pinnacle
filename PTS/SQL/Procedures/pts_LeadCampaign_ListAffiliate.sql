EXEC [dbo].pts_CheckProc 'pts_LeadCampaign_ListAffiliate'
GO

CREATE PROCEDURE [dbo].pts_LeadCampaign_ListAffiliate
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      lc.LeadCampaignID, 
         lc.LeadCampaignName, 
         lc.Image, 
         lc.PageType, 
         lc.Objective
FROM LeadCampaign AS lc (NOLOCK)
WHERE (lc.CompanyID = @CompanyID)
 AND (lc.Status = 2)
 AND (lc.IsAffiliate <> 0)
 AND (lc.PageType = 1)

ORDER BY   lc.Seq , lc.LeadCampaignName

GO