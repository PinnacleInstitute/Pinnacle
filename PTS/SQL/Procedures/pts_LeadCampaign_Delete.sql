EXEC [dbo].pts_CheckProc 'pts_LeadCampaign_Delete'
GO

CREATE PROCEDURE [dbo].pts_LeadCampaign_Delete
   @LeadCampaignID int,
   @UserID int
AS

SET NOCOUNT ON

EXEC pts_LeadPage_DeleteLeadCampaign
   @LeadCampaignID

DELETE lc
FROM LeadCampaign AS lc
WHERE (lc.LeadCampaignID = @LeadCampaignID)


GO