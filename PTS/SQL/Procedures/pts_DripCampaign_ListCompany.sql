EXEC [dbo].pts_CheckProc 'pts_DripCampaign_ListCompany'
GO

CREATE PROCEDURE [dbo].pts_DripCampaign_ListCompany
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      dec.DripCampaignID, 
         dec.DripCampaignName, 
         dec.Description, 
         dec.Target, 
         dec.Status, 
         dec.IsShare
FROM DripCampaign AS dec (NOLOCK)
WHERE (dec.CompanyID = @CompanyID)
 AND (dec.GroupID = 0)

ORDER BY   dec.DripCampaignName

GO