EXEC [dbo].pts_CheckProc 'pts_LeadPage_DeleteLeadCampaign'
GO

CREATE PROCEDURE [dbo].pts_LeadPage_DeleteLeadCampaign
   @LeadCampaignID int
AS

DELETE LeadPage WHERE LeadCampaignID = @LeadCampaignID

GO