EXEC [dbo].pts_CheckProc 'pts_DripCampaign_ListActive'
GO

CREATE PROCEDURE [dbo].pts_DripCampaign_ListActive
   @UserID int
AS

SET NOCOUNT ON

SELECT      dec.DripCampaignID, 
         dec.CompanyID, 
         dec.Target, 
         dec.IsShare
FROM DripCampaign AS dec (NOLOCK)
WHERE (dec.Status = 2)

ORDER BY   dec.CompanyID

GO