EXEC [dbo].pts_CheckProc 'pts_MemberDomain_List'
GO

CREATE PROCEDURE [dbo].pts_MemberDomain_List
   @MemberID int
AS

SET NOCOUNT ON

SELECT      med.MemberDomainID, 
         med.DomainID, 
         med.LeadCampaignID, 
         dom.DomainName AS 'DomainName', 
         lc.LeadCampaignName AS 'LeadCampaignName', 
         med.PageType
FROM MemberDomain AS med (NOLOCK)
LEFT OUTER JOIN Domain AS dom (NOLOCK) ON (med.DomainID = dom.DomainID)
LEFT OUTER JOIN LeadCampaign AS lc (NOLOCK) ON (med.LeadCampaignID = lc.LeadCampaignID)
WHERE (med.MemberID = @MemberID)

ORDER BY   dom.DomainName

GO