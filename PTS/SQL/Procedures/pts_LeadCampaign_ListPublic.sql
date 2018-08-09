EXEC [dbo].pts_CheckProc 'pts_LeadCampaign_ListPublic'
GO

CREATE PROCEDURE [dbo].pts_LeadCampaign_ListPublic
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      lc.LeadCampaignID, 
         lc.LeadCampaignName, 
         lc.Objective
FROM LeadCampaign AS lc (NOLOCK)
WHERE (lc.CompanyID = @CompanyID)
 AND (lc.Status = 2)
 AND (lc.IsPrivate = 0)

ORDER BY   lc.LeadCampaignName

GO