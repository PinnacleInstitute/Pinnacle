EXEC [dbo].pts_CheckProc 'pts_DripTarget_Update'
 GO

CREATE PROCEDURE [dbo].pts_DripTarget_Update ( 
   @DripTargetID int,
   @DripCampaignID int,
   @TargetID int,
   @Status int,
   @StartDate datetime,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE det
SET det.DripCampaignID = @DripCampaignID ,
   det.TargetID = @TargetID ,
   det.Status = @Status ,
   det.StartDate = @StartDate
FROM DripTarget AS det
WHERE det.DripTargetID = @DripTargetID

GO