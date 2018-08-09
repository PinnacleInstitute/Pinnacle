EXEC [dbo].pts_CheckProc 'pts_LeadLog_ClearAffiliate'
GO

CREATE PROCEDURE [dbo].pts_LeadLog_ClearAffiliate
   @AffiliateID int ,
   @LeadCampaignID int ,
   @FromDate datetime ,
   @ToDate datetime ,
   @Count int OUTPUT
AS

SET NOCOUNT ON

SELECT @Count = COUNT(*) 
FROM LeadLog as ll
JOIN LeadPage AS lp ON ll.LeadPageID = lp.LeadPageID
WHERE lp.LeadCampaignID = @LeadCampaignID
AND ll.AffiliateID = @AffiliateID
AND ll.LogDate >= @FromDate
AND ll.LogDate <= @ToDate

DELETE ll
FROM LeadLog as ll
JOIN LeadPage AS lp ON ll.LeadPageID = lp.LeadPageID
WHERE lp.LeadCampaignID = @LeadCampaignID
AND ll.AffiliateID = @AffiliateID
AND ll.LogDate >= @FromDate
AND ll.LogDate <= @ToDate

GO