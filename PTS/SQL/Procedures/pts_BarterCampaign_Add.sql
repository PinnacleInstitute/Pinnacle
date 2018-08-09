EXEC [dbo].pts_CheckProc 'pts_BarterCampaign_Add'
 GO

CREATE PROCEDURE [dbo].pts_BarterCampaign_Add ( 
   @BarterCampaignID int OUTPUT,
   @ConsumerID int,
   @BarterAdID int,
   @BarterAreaID int,
   @BarterCategoryID int,
   @CampaignName nvarchar (100),
   @Status int,
   @StartDate datetime,
   @EndDate datetime,
   @IsKeyword bit,
   @IsAllCategory bit,
   @IsMainCategory bit,
   @IsSubCategory bit,
   @IsAllLocation bit,
   @IsCountry bit,
   @IsState bit,
   @IsCity bit,
   @IsArea bit,
   @Keyword nvarchar (100),
   @FT nvarchar (500),
   @Credits money,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO BarterCampaign (
            ConsumerID , 
            BarterAdID , 
            BarterAreaID , 
            BarterCategoryID , 
            CampaignName , 
            Status , 
            StartDate , 
            EndDate , 
            IsKeyword , 
            IsAllCategory , 
            IsMainCategory , 
            IsSubCategory , 
            IsAllLocation , 
            IsCountry , 
            IsState , 
            IsCity , 
            IsArea , 
            Keyword , 
            FT , 
            Credits
            )
VALUES (
            @ConsumerID ,
            @BarterAdID ,
            @BarterAreaID ,
            @BarterCategoryID ,
            @CampaignName ,
            @Status ,
            @StartDate ,
            @EndDate ,
            @IsKeyword ,
            @IsAllCategory ,
            @IsMainCategory ,
            @IsSubCategory ,
            @IsAllLocation ,
            @IsCountry ,
            @IsState ,
            @IsCity ,
            @IsArea ,
            @Keyword ,
            @FT ,
            @Credits            )

SET @mNewID = @@IDENTITY

SET @BarterCampaignID = @mNewID

GO