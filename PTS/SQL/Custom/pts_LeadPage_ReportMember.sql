EXEC [dbo].pts_CheckProc 'pts_LeadPage_ReportMember'
GO

CREATE PROCEDURE [dbo].pts_LeadPage_ReportMember
   @LeadCampaignID int ,
   @MemberID int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime 
AS

SET NOCOUNT ON

SELECT   lp.LeadPageID, 
         lp.LeadPageName, 
         (
		SELECT COUNT(*) FROM LeadLog
		WHERE LeadPageID = lp.LeadPageID
		AND MemberID = @MemberID
		AND LogDate >= @ReportFromDate
		AND LogDate < @ReportToDate
	 ) AS 'Seq'
FROM LeadPage AS lp
WHERE lp.LeadCampaignID = @LeadCampaignID
AND lp.Language = 'en'
AND lp.Status = 2

GO