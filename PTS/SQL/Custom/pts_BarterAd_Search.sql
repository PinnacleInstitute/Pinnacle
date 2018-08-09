EXEC [dbo].pts_CheckProc 'pts_BarterAd_Search'
 GO

--DECLARE @MaxRows tinyint EXEC pts_BarterAd_Search '', '', @MaxRows OUTPUT, 5, 0, 0, 0, 0, 0, ''  PRINT @MaxRows

CREATE PROCEDURE [dbo].pts_BarterAd_Search ( 
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

IF @Status IN (1,2,3,4,11,12,13,14) EXEC pts_BarterAd_Search1 @SearchText, @Bookmark, @MaxRows OUTPUT, @Status, @BarterArea1ID, @BarterArea2ID, @MainCategoryID, @BarterCategoryID, @Images, @Description
IF @Status IN (5,6,7,8,15,16,17,18) EXEC pts_BarterAd_Search2 @SearchText, @Bookmark, @MaxRows OUTPUT, @Status, @BarterArea1ID, @BarterArea2ID, @MainCategoryID, @BarterCategoryID, @Images, @Description
IF @Status = 100 EXEC pts_BarterAd_Search3 @SearchText, @Bookmark, @MaxRows OUTPUT, @Status, @BarterArea1ID, @BarterArea2ID, @MainCategoryID, @BarterCategoryID, @Images, @Description

GO