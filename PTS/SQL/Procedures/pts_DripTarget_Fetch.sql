EXEC [dbo].pts_CheckProc 'pts_DripTarget_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_DripTarget_Fetch ( 
   @DripTargetID int,
   @DripCampaignID int OUTPUT,
   @TargetID int OUTPUT,
   @Status int OUTPUT,
   @StartDate datetime OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @DripCampaignID = det.DripCampaignID ,
   @TargetID = det.TargetID ,
   @Status = det.Status ,
   @StartDate = det.StartDate
FROM DripTarget AS det (NOLOCK)
WHERE det.DripTargetID = @DripTargetID

GO