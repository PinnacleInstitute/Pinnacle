EXEC [dbo].pts_CheckProc 'pts_BarterCampaign_Targets'
GO

-- DECLARE @Result nvarchar(1000) EXEC pts_BarterCampaign_Targets 11, 34, @Result OUTPUT PRINT @Result
-- select * from barterad where barteradid = 5

CREATE PROCEDURE [dbo].pts_BarterCampaign_Targets
   @BarterAreaID int ,
   @BarterCategoryID int ,
   @Result nvarchar (1000) OUTPUT
AS

SET NOCOUNT ON

DECLARE @Country nvarchar(50), @State nvarchar(40), @City nvarchar(40), @Area nvarchar(40), @MainCategory nvarchar(40), @SubCategory nvarchar(40)
DECLARE @CountryID int, @SelectAreaID int, @SelectCategoryID int, @BarterAreaType int, @BarterAreaName nvarchar(40), @ParentID int

SET @Country = '' SET @State = '' SET @City = '' SET @Area = '' SET @MainCategory = '' SET @SubCategory = ''
SET @SelectAreaID = 0 SET @SelectCategoryID = 0

IF @BarterAreaID > 0
BEGIN
	Select @BarterAreaName = BarterAreaName, @BarterAreaType = BarterAreaType, @ParentID = ParentID, @CountryID = CountryID FROM BarterArea WHERE BarterAreaID = @BarterAreaID
	IF @BarterAreaType = 3
	BEGIN
		SET @Area = @BarterAreaName
		Select @BarterAreaName = BarterAreaName, @BarterAreaType = BarterAreaType, @ParentID = ParentID FROM BarterArea WHERE BarterAreaID = @ParentID
	END
	IF @BarterAreaType = 2
	BEGIN
		SET @City = @BarterAreaName
		SET @SelectAreaID = @ParentID
		Select @BarterAreaName = BarterAreaName, @BarterAreaType = BarterAreaType, @ParentID = ParentID FROM BarterArea WHERE BarterAreaID = @ParentID
	END
	IF @BarterAreaType = 1 SET @State = @BarterAreaName
	Select @Country = CountryName FROM Country WHERE CountryID = @CountryID
END
IF @BarterCategoryID > 0
BEGIN
	Select @SubCategory = BarterCategoryName, @ParentID = ParentID FROM BarterCategory WHERE BarterCategoryID = @BarterCategoryID
	IF @ParentID > 0 Select @MainCategory = BarterCategoryName FROM BarterCategory WHERE BarterCategoryID = @ParentID
	SET @SelectCategoryID = @ParentID
END

SET @Result = @Country + '|' + @State + '|' + @City + '|' + @area + '|' + @MainCategory + '|' + @SubCategory + '|' + CAST(@SelectAreaID AS VARCHAR(10)) + '|' + CAST(@SelectCategoryID AS VARCHAR(10))

GO