EXEC [dbo].pts_CheckProc 'pts_BarterCampaign_Delete'
 GO

CREATE PROCEDURE [dbo].pts_BarterCampaign_Delete ( 
   @BarterCampaignID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE bcp
FROM BarterCampaign AS bcp
WHERE bcp.BarterCampaignID = @BarterCampaignID

GO