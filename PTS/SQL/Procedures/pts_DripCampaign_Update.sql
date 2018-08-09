EXEC [dbo].pts_CheckProc 'pts_DripCampaign_Update'
 GO

CREATE PROCEDURE [dbo].pts_DripCampaign_Update ( 
   @DripCampaignID int,
   @CompanyID int,
   @GroupID int,
   @DripCampaignName nvarchar (40),
   @Description varchar (200),
   @Target int,
   @Status int,
   @IsShare bit,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE dec
SET dec.CompanyID = @CompanyID ,
   dec.GroupID = @GroupID ,
   dec.DripCampaignName = @DripCampaignName ,
   dec.Description = @Description ,
   dec.Target = @Target ,
   dec.Status = @Status ,
   dec.IsShare = @IsShare
FROM DripCampaign AS dec
WHERE dec.DripCampaignID = @DripCampaignID

GO