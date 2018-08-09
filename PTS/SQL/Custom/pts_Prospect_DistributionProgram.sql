EXEC [dbo].pts_CheckProc 'pts_Prospect_DistributionProgram'
GO

CREATE PROCEDURE [dbo].pts_Prospect_DistributionProgram
   @MemberID int,
   @LeadCampaignID int
AS

SET NOCOUNT ON

SELECT TOP 100 pr.ProspectID, 
         pr.ProspectName, 
         lc.LeadCampaignName 'MemberName', 
         pr.Email, 
         pr.Phone1, 
         pr.City, 
         pr.State, 
         pr.Zip, 
         pr.Country,
         pr.Description
FROM Prospect AS pr (NOLOCK)
LEFT OUTER JOIN LeadCampaign AS lc ON pr.LeadCampaignID = lc.LeadCampaignID
WHERE MemberID = @MemberID
AND pr.NoDistribute = 0
AND pr.LeadCampaignID = @LeadCampaignID

GO