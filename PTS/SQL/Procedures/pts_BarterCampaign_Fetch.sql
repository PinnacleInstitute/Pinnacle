EXEC [dbo].pts_CheckProc 'pts_BarterCampaign_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_BarterCampaign_Fetch ( 
   @BarterCampaignID int,
   @ConsumerID int OUTPUT,
   @BarterAdID int OUTPUT,
   @BarterAreaID int OUTPUT,
   @BarterCategoryID int OUTPUT,
   @CampaignName nvarchar (100) OUTPUT,
   @Status int OUTPUT,
   @StartDate datetime OUTPUT,
   @EndDate datetime OUTPUT,
   @IsKeyword bit OUTPUT,
   @IsAllCategory bit OUTPUT,
   @IsMainCategory bit OUTPUT,
   @IsSubCategory bit OUTPUT,
   @IsAllLocation bit OUTPUT,
   @IsCountry bit OUTPUT,
   @IsState bit OUTPUT,
   @IsCity bit OUTPUT,
   @IsArea bit OUTPUT,
   @Keyword nvarchar (100) OUTPUT,
   @FT nvarchar (500) OUTPUT,
   @Credits money OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @ConsumerID = bcp.ConsumerID ,
   @BarterAdID = bcp.BarterAdID ,
   @BarterAreaID = bcp.BarterAreaID ,
   @BarterCategoryID = bcp.BarterCategoryID ,
   @CampaignName = bcp.CampaignName ,
   @Status = bcp.Status ,
   @StartDate = bcp.StartDate ,
   @EndDate = bcp.EndDate ,
   @IsKeyword = bcp.IsKeyword ,
   @IsAllCategory = bcp.IsAllCategory ,
   @IsMainCategory = bcp.IsMainCategory ,
   @IsSubCategory = bcp.IsSubCategory ,
   @IsAllLocation = bcp.IsAllLocation ,
   @IsCountry = bcp.IsCountry ,
   @IsState = bcp.IsState ,
   @IsCity = bcp.IsCity ,
   @IsArea = bcp.IsArea ,
   @Keyword = bcp.Keyword ,
   @FT = bcp.FT ,
   @Credits = bcp.Credits
FROM BarterCampaign AS bcp (NOLOCK)
WHERE bcp.BarterCampaignID = @BarterCampaignID

GO