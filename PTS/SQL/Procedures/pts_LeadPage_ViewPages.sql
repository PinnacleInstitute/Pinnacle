EXEC [dbo].pts_CheckProc 'pts_LeadPage_ViewPages'
GO

CREATE PROCEDURE [dbo].pts_LeadPage_ViewPages
   @LeadCampaignID int ,
   @Language nvarchar (6)
AS

SET NOCOUNT ON

SELECT      lp.LeadPageID, 
         lp.LeadPageName, 
         lp.Seq
FROM LeadPage AS lp (NOLOCK)
WHERE (lp.LeadCampaignID = @LeadCampaignID)
 AND (lp.Status = 2)
 AND (lp.Language = @Language)

ORDER BY   lp.Seq

GO