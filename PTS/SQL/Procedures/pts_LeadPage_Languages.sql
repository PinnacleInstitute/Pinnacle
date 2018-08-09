EXEC [dbo].pts_CheckProc 'pts_LeadPage_Languages'
GO

CREATE PROCEDURE [dbo].pts_LeadPage_Languages
   @LeadCampaignID int
AS

SET NOCOUNT ON

SELECT      lp.LeadPageID, 
         lp.LeadPageName, 
         lp.Language
FROM LeadPage AS lp (NOLOCK)
WHERE (lp.LeadCampaignID = @LeadCampaignID)

ORDER BY   lp.Language , lp.Seq

GO