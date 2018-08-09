EXEC [dbo].pts_CheckProc 'pts_DripTarget_ListCampaign'
GO

CREATE PROCEDURE [dbo].pts_DripTarget_ListCampaign
   @Target int ,
   @TargetID int
AS

SET NOCOUNT ON

SELECT det.DripTargetID, det.DripCampaignID, det.Status, det.StartDate, dec.DripCampaignName AS 'Data'
FROM DripTarget AS det (NOLOCK)
JOIN DripCampaign AS dec ON det.DripCampaignID = dec.DripCampaignID
WHERE dec.Target = @Target AND det.TargetID = @TargetID

GO