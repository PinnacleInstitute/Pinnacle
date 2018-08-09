EXEC [dbo].pts_CheckProc 'pts_MemberDomain_Website'
GO

CREATE PROCEDURE [dbo].pts_MemberDomain_Website
   @MemberID int ,
   @DomainName nvarchar (40) ,
   @UserID int ,
   @PageType int OUTPUT ,
   @LeadCampaignID int OUTPUT
AS

DECLARE @mPageType int, 
         @mLeadCampaignID int

SET NOCOUNT ON

SELECT      @mPageType = med.PageType, 
         @mLeadCampaignID = med.LeadCampaignID
FROM MemberDomain AS med (NOLOCK)
LEFT OUTER JOIN Domain AS dom (NOLOCK) ON (med.DomainID = dom.DomainID)
WHERE (dom.DomainName = @DomainName)


SET @PageType = ISNULL(@mPageType, 0)
SET @LeadCampaignID = ISNULL(@mLeadCampaignID, 0)
GO