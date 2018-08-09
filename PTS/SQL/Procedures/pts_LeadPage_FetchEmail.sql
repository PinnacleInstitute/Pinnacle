EXEC [dbo].pts_CheckProc 'pts_LeadPage_FetchEmail'
GO

CREATE PROCEDURE [dbo].pts_LeadPage_FetchEmail
   @LeadCampaignID int ,
   @Language nvarchar (6) ,
   @LeadPageID int OUTPUT ,
   @LeadPageName nvarchar (60) OUTPUT
AS

SET NOCOUNT ON

SELECT      @LeadPageID = lp.LeadPageID, 
         @LeadPageName = lp.LeadPageName
FROM LeadPage AS lp (NOLOCK)
WHERE (lp.LeadCampaignID = @LeadCampaignID)
 AND (lp.Language = @Language)
 AND (lp.Status = 5)


GO