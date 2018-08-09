EXEC [dbo].pts_CheckProc 'pts_LeadCampaign_List'
GO

CREATE PROCEDURE [dbo].pts_LeadCampaign_List
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      lc.LeadCampaignID, 
         lc.LeadCampaignName, 
         lc.Status, 
         lc.Objective, 
         lc.IsPrivate
FROM LeadCampaign AS lc (NOLOCK)
WHERE (lc.CompanyID = @CompanyID)

ORDER BY   lc.LeadCampaignName

GO