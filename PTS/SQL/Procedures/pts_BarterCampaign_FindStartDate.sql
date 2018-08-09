EXEC [dbo].pts_CheckProc 'pts_BarterCampaign_FindStartDate'
 GO

CREATE PROCEDURE [dbo].pts_BarterCampaign_FindStartDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @ConsumerID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20
IF (@Bookmark = '') SET @Bookmark = '99991231'
IF (ISDATE(@SearchText) = 1)
            SET @SearchText = CONVERT(nvarchar(10), CONVERT(datetime, @SearchText), 112)
ELSE
            SET @SearchText = ''


SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), bcp.StartDate, 112), '') + dbo.wtfn_FormatNumber(bcp.BarterCampaignID, 10) 'BookMark' ,
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
WHERE ISNULL(CONVERT(nvarchar(10), bcp.StartDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), bcp.StartDate, 112), '') + dbo.wtfn_FormatNumber(bcp.BarterCampaignID, 10) <= @BookMark
AND         (bcp.ConsumerID = @ConsumerID)
ORDER BY 'Bookmark' DESC

GO