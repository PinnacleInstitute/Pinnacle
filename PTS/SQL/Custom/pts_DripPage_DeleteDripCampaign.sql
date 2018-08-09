EXEC [dbo].pts_CheckProc 'pts_DripPage_DeleteDripCampaign'
GO

CREATE PROCEDURE [dbo].pts_DripPage_DeleteDripCampaign
   @DripCampaignID int
AS

DELETE DripPage WHERE DripCampaignID = @DripCampaignID

GO