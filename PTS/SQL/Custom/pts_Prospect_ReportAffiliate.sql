EXEC [dbo].pts_CheckProc 'pts_Prospect_ReportAffiliate'
GO

CREATE PROCEDURE [dbo].pts_Prospect_ReportAffiliate
   @LeadCampaignID int ,
   @AffiliateID int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime ,
   @Result int OUTPUT
AS

SET NOCOUNT ON
SET @Result = 0

SELECT @Result = COUNT(*) FROM Prospect
WHERE LeadCampaignID = @LeadCampaignID
AND AffiliateID = @AffiliateID
AND CreateDate >= @ReportFromDate
AND CreateDate < @ReportToDate
AND LeadReplies > 0
AND Status > 0

GO