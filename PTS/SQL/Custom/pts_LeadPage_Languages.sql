EXEC [dbo].pts_CheckProc 'pts_LeadPage_Languages'
GO
--EXEC pts_LeadPage_Languages 22

CREATE PROCEDURE [dbo].pts_LeadPage_Languages
   @LeadCampaignID int
AS

SET NOCOUNT ON

SELECT lp.Language,
       MIN(lp.LeadPageID) 'LeadPageID',
       MIN(lp.LeadPageName) 'LeadPageName'
FROM LeadPage AS lp (NOLOCK)
WHERE (lp.LeadCampaignID = @LeadCampaignID)
AND lp.Status = 2
GROUP BY lp.language



GO

