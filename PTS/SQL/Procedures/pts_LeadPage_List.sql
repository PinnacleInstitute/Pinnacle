EXEC [dbo].pts_CheckProc 'pts_LeadPage_List'
GO

CREATE PROCEDURE [dbo].pts_LeadPage_List
   @LeadCampaignID int
AS

SET NOCOUNT ON

SELECT      lp.LeadPageID, 
         lp.LeadPageName, 
         lp.Status, 
         lp.Seq, 
         lp.IsInput, 
         lp.IsCapture, 
         lp.IsProspect, 
         lp.IsNext, 
         lp.NextCaption, 
         lp.Inputs, 
         lp.Language, 
         lp.IsLeadURL, 
         lp.IsRedirectURL, 
         lp.LeadURL, 
         lp.RedirectURL, 
         lp.TopCode
FROM LeadPage AS lp (NOLOCK)
WHERE (lp.LeadCampaignID = @LeadCampaignID)

ORDER BY   lp.Language , lp.Seq

GO