EXEC [dbo].pts_CheckProc 'pts_BarterCampaign_FindAdStatusCampaignName'
 GO

CREATE PROCEDURE [dbo].pts_BarterCampaign_FindAdStatusCampaignName ( 
   @SearchText nvarchar (100),
   @Bookmark nvarchar (110),
   @MaxRows tinyint OUTPUT,
   @BarterAdID int,
   @Status int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(bcp.CampaignName, '') + dbo.wtfn_FormatNumber(bcp.BarterCampaignID, 10) 'BookMark' ,
            bcp.BarterCampaignID 'BarterCampaignID' ,
            bcp.ConsumerID 'ConsumerID' ,
            bcp.BarterAdID 'BarterAdID' ,
            bcp.BarterAreaID 'BarterAreaID' ,
            bcp.BarterCategoryID 'BarterCategoryID' ,
            bcp.CampaignName 'CampaignName' ,
            bcp.Status 'Status' ,
            bcp.StartDate 'StartDate' ,
            bcp.EndDate 'EndDate' ,
            bcp.IsKeyword 'IsKeyword' ,
            bcp.IsAllCategory 'IsAllCategory' ,
            bcp.IsMainCategory 'IsMainCategory' ,
            bcp.IsSubCategory 'IsSubCategory' ,
            bcp.IsAllLocation 'IsAllLocation' ,
            bcp.IsCountry 'IsCountry' ,
            bcp.IsState 'IsState' ,
            bcp.IsCity 'IsCity' ,
            bcp.IsArea 'IsArea' ,
            bcp.Keyword 'Keyword' ,
            bcp.FT 'FT' ,
            bcp.Credits 'Credits'
FROM BarterCampaign AS bcp (NOLOCK)
WHERE ISNULL(bcp.CampaignName, '') LIKE @SearchText + '%'
AND ISNULL(bcp.CampaignName, '') + dbo.wtfn_FormatNumber(bcp.BarterCampaignID, 10) >= @BookMark
AND         (bcp.BarterAdID = @BarterAdID)
AND         (bcp.Status = @Status)
ORDER BY 'Bookmark'

GO