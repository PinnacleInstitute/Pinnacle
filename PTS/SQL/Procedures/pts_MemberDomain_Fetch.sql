EXEC [dbo].pts_CheckProc 'pts_MemberDomain_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_MemberDomain_Fetch ( 
   @MemberDomainID int,
   @MemberID int OUTPUT,
   @DomainID int OUTPUT,
   @LeadCampaignID int OUTPUT,
   @DomainName nvarchar (40) OUTPUT,
   @LeadCampaignName nvarchar (40) OUTPUT,
   @PageType int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = med.MemberID ,
   @DomainID = med.DomainID ,
   @LeadCampaignID = med.LeadCampaignID ,
   @DomainName = dom.DomainName ,
   @LeadCampaignName = lc.LeadCampaignName ,
   @PageType = med.PageType
FROM MemberDomain AS med (NOLOCK)
LEFT OUTER JOIN Domain AS dom (NOLOCK) ON (med.DomainID = dom.DomainID)
LEFT OUTER JOIN LeadCampaign AS lc (NOLOCK) ON (med.LeadCampaignID = lc.LeadCampaignID)
WHERE med.MemberDomainID = @MemberDomainID

GO