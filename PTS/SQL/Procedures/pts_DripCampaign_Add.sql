EXEC [dbo].pts_CheckProc 'pts_DripCampaign_Add'
 GO

CREATE PROCEDURE [dbo].pts_DripCampaign_Add ( 
   @DripCampaignID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO DripCampaign (
            CompanyID , 
            GroupID , 
            DripCampaignName , 
            Description , 
            Target , 
            Status , 
            IsShare
            )
VALUES (
            @CompanyID ,
            @GroupID ,
            @DripCampaignName ,
            @Description ,
            @Target ,
            @Status ,
            @IsShare            )

SET @mNewID = @@IDENTITY

SET @DripCampaignID = @mNewID

GO