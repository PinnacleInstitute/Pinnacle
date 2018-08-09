EXEC [dbo].pts_CheckProc 'pts_DripPage_Update'
 GO

CREATE PROCEDURE [dbo].pts_DripPage_Update ( 
   @DripPageID int,
   @DripCampaignID int,
   @Subject nvarchar (80),
   @Status int,
   @Days int,
   @IsCC bit,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE dep
SET dep.DripCampaignID = @DripCampaignID ,
   dep.Subject = @Subject ,
   dep.Status = @Status ,
   dep.Days = @Days ,
   dep.IsCC = @IsCC
FROM DripPage AS dep
WHERE dep.DripPageID = @DripPageID

GO