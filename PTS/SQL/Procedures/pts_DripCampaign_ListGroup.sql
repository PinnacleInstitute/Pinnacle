EXEC [dbo].pts_CheckProc 'pts_DripCampaign_ListGroup'
GO

CREATE PROCEDURE [dbo].pts_DripCampaign_ListGroup
   @GroupID int
AS

SET NOCOUNT ON

SELECT      dec.DripCampaignID, 
         dec.DripCampaignName, 
         dec.Description, 
         dec.Target, 
         dec.Status, 
         dec.IsShare
FROM DripCampaign AS dec (NOLOCK)
WHERE (dec.GroupID = @GroupID)

ORDER BY   dec.DripCampaignName

GO