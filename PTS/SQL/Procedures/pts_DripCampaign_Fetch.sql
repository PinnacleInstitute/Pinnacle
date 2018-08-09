EXEC [dbo].pts_CheckProc 'pts_DripCampaign_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_DripCampaign_Fetch ( 
   @DripCampaignID int,
   @CompanyID int OUTPUT,
   @GroupID int OUTPUT,
   @DripCampaignName nvarchar (40) OUTPUT,
   @Description varchar (200) OUTPUT,
   @Target int OUTPUT,
   @Status int OUTPUT,
   @IsShare bit OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = dec.CompanyID ,
   @GroupID = dec.GroupID ,
   @DripCampaignName = dec.DripCampaignName ,
   @Description = dec.Description ,
   @Target = dec.Target ,
   @Status = dec.Status ,
   @IsShare = dec.IsShare
FROM DripCampaign AS dec (NOLOCK)
WHERE dec.DripCampaignID = @DripCampaignID

GO