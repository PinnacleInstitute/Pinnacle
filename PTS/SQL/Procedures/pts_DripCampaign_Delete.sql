EXEC [dbo].pts_CheckProc 'pts_DripCampaign_Delete'
GO

CREATE PROCEDURE [dbo].pts_DripCampaign_Delete
   @DripCampaignID int,
   @UserID int
AS

SET NOCOUNT ON

EXEC pts_DripPage_DeleteDripCampaign
   @DripCampaignID

DELETE dec
FROM DripCampaign AS dec
WHERE (dec.DripCampaignID = @DripCampaignID)


GO