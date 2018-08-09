EXEC [dbo].pts_CheckProc 'pts_BarterCampaign_Update'
 GO

CREATE PROCEDURE [dbo].pts_BarterCampaign_Update ( 
   @BarterCampaignID int,
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

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE bcp
SET bcp.ConsumerID = @ConsumerID ,
   bcp.BarterAdID = @BarterAdID ,
   bcp.BarterAreaID = @BarterAreaID ,
   bcp.BarterCategoryID = @BarterCategoryID ,
   bcp.CampaignName = @CampaignName ,
   bcp.Status = @Status ,
   bcp.StartDate = @StartDate ,
   bcp.EndDate = @EndDate ,
   bcp.IsKeyword = @IsKeyword ,
   bcp.IsAllCategory = @IsAllCategory ,
   bcp.IsMainCategory = @IsMainCategory ,
   bcp.IsSubCategory = @IsSubCategory ,
   bcp.IsAllLocation = @IsAllLocation ,
   bcp.IsCountry = @IsCountry ,
   bcp.IsState = @IsState ,
   bcp.IsCity = @IsCity ,
   bcp.IsArea = @IsArea ,
   bcp.Keyword = @Keyword ,
   bcp.FT = @FT ,
   bcp.Credits = @Credits
FROM BarterCampaign AS bcp
WHERE bcp.BarterCampaignID = @BarterCampaignID

GO