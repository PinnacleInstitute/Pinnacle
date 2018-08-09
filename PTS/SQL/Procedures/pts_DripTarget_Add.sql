EXEC [dbo].pts_CheckProc 'pts_DripTarget_Add'
 GO

CREATE PROCEDURE [dbo].pts_DripTarget_Add ( 
   @DripTargetID int OUTPUT,
   @DripCampaignID int,
   @TargetID int,
   @Status int,
   @StartDate datetime,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO DripTarget (
            DripCampaignID , 
            TargetID , 
            Status , 
            StartDate
            )
VALUES (
            @DripCampaignID ,
            @TargetID ,
            @Status ,
            @StartDate            )

SET @mNewID = @@IDENTITY

SET @DripTargetID = @mNewID

GO