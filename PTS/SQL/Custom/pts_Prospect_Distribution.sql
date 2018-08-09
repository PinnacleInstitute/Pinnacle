EXEC [dbo].pts_CheckProc 'pts_Prospect_Distribution'
GO

CREATE PROCEDURE [dbo].pts_Prospect_Distribution
   @MemberID int
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
AND NoDistribute = 0

GO