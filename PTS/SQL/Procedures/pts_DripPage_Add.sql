EXEC [dbo].pts_CheckProc 'pts_DripPage_Add'
 GO

CREATE PROCEDURE [dbo].pts_DripPage_Add ( 
   @DripPageID int OUTPUT,
   @DripCampaignID int,
   @Subject nvarchar (80),
   @Status int,
   @Days int,
   @IsCC bit,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO DripPage (
            DripCampaignID , 
            Subject , 
            Status , 
            Days , 
            IsCC
            )
VALUES (
            @DripCampaignID ,
            @Subject ,
            @Status ,
            @Days ,
            @IsCC            )

SET @mNewID = @@IDENTITY

SET @DripPageID = @mNewID

GO