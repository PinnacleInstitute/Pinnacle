EXEC [dbo].pts_CheckProc 'pts_BarterAd_Search3'
 GO
 
 -- Modern black, "Items For Sale", "Dallas - Fort Worth", "Texas", "United States"
-- Find Barter Ad Campaigns
--DECLARE @MaxRows tinyint EXEC pts_BarterAd_Search3 'Modern or black or "Items For Sale" or "Dallas - Fort Worth" or "Texas" or "United States"', '', @MaxRows OUTPUT, 100, 0, 0, 0, 0, 0, '' PRINT @MaxRows
--select * from bartercampaign

CREATE PROCEDURE [dbo].pts_BarterAd_Search3 ( 
	@SearchText nvarchar (200),
	@Bookmark nvarchar (20),
	@MaxRows tinyint OUTPUT,
	@Status int ,
	@BarterArea1ID int ,
	@BarterArea2ID int ,
	@MainCategoryID int ,
	@BarterCategoryID int ,
	@Images int ,
	@Description nvarchar (4000)
)
AS

SET NOCOUNT ON
DECLARE @Today datetime
SET @Today = dbo.wtfn_DateOnly(GETDATE())
SET @MaxRows = 10

SELECT TOP 10
	'' 'BookMark',
	ba.BarterAdID, 
	0 'BarterArea1ID', 
	0 'BarterArea2ID', 
	0 'BarterCategoryID', 
	ba.Title, 
	ba.Price, 
	ba.Location, 
	ba.Zip, 
	ba.PostDate, 
	0 'UpdateDate', 
	ISNULL(CAST(bi.BarterImageID as VARCHAR(10)) + 'm.' + bi.ext,'')  AS 'Image', 
	ba.Images, 
	ba.IsMap, 
	'' 'Language', 
	'' 'MapStreet1', 
	'' 'MapStreet2',
	ba.Options
FROM BarterAd AS ba
JOIN BarterCampaign AS bcm ON ba.BarterAdID = bcm.BarterAdID
INNER JOIN CONTAINSTABLE(BarterCampaign,*, @SearchText, 1000 ) AS K ON bcm.BarterCampaignID = K.[KEY]
LEFT OUTER JOIN BarterImage AS bi ON bi.BarterImageID = (
	SELECT TOP 1 BarterImageID FROM BarterImage
	WHERE BarterAdID = ba.BarterAdID
	AND Status = 1 AND ext != ''
	ORDER BY Seq, BarterImageID 
)
WHERE ba.Status = 2
AND bcm.Status = 2
AND bcm.StartDate <= @Today
AND bcm.EndDate >= @Today

ORDER BY K.[RANK] desc 

GO
