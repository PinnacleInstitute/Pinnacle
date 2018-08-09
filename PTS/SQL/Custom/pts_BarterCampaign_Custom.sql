EXEC [dbo].pts_CheckProc 'pts_BarterCampaign_Custom'
GO

-- DECLARE @Result nvarchar(1000) EXEC pts_BarterCampaign_Custom 1, 0, 11, 34, @Result OUTPUT PRINT @Result
-- DECLARE @Result nvarchar(1000) EXEC pts_BarterCampaign_Custom 2, 1, 0, 0, @Result OUTPUT PRINT @Result
-- select * from barterad where barteradid = 5
-- select * from bartercampaign

CREATE PROCEDURE [dbo].pts_BarterCampaign_Custom
   @Status int ,
   @BarterCampaignID int ,
   @BarterAreaID int ,
   @BarterCategoryID int ,
   @Result nvarchar (1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

-- Get all the target labels
IF @Status = 1
BEGIN
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
		IF @ParentID > 0
		BEGIN
			SET @SelectCategoryID = @ParentID
			Select @MainCategory = BarterCategoryName FROM BarterCategory WHERE BarterCategoryID = @ParentID
		END	
		ELSE
		BEGIN
			SET @SelectCategoryID = @BarterCategoryID
			SET @MainCategory = @SubCategory
			SET @SubCategory = ''
		END	
	END

	SET @Result = @Country + '|' + @State + '|' + @City + '|' + @area + '|' + @MainCategory + '|' + @SubCategory + '|' + CAST(@SelectAreaID AS VARCHAR(10)) + '|' + CAST(@SelectCategoryID AS VARCHAR(10))

END

-- Start Campaign
IF @Status = 2
BEGIN
	DECLARE @ConsumerID int, @Available money, @Credits money, @ID int, @BarterAdID int, @tmpStatus int
	DECLARE @Today datetime, @EndDate datetime, @AdEndDate datetime, @Options varchar(20)
	SET @Today = dbo.wtfn_DateOnly(GETDATE())
	SET @EndDate = DATEADD(M,1,@Today)

	SELECT @ConsumerID = ConsumerID, @BarterAdID = BarterAdID, @tmpStatus = Status,
	@Credits = CAST(IsKeyword AS INT) + CAST(IsSubCategory AS INT) + CAST(IsMainCategory AS INT) + CAST(IsAllCategory AS INT) + CAST(IsArea AS INT) + CAST(IsCity AS INT) + CAST(IsState AS INT) + CAST(IsCountry AS INT) + CAST(IsAllLocation AS INT) 
	FROM BarterCampaign WHERE BarterCampaignID = @BarterCampaignID
	
	-- Get available credits for this consumer
	SELECT @Available = ISNULL(SUM(Amount),0) FROM BarterCredit WHERE OwnerType = 151 AND OwnerID = @ConsumerID AND Status IN (1,2)

	SET @Result = '0'
	IF @tmpStatus != 2 SET @Result = '1'
	IF @Available < @Credits SET @Result = '2'
	IF @Credits = 0 SET @Result = '3'
	IF @Result = '0'
	BEGIN
		-- Update Barter Ad Options and EndDate
		SELECT @Options = Options, @AdEndDate = EndDate FROM BarterAd WHERE BarterAdID = @BarterAdID
		IF CHARINDEX('G',@Options) = 0 SET @Options = @Options + 'G'
		IF @AdEndDate < @EndDate SET @AdEndDate = @EndDate
		UPDATE BarterAd SET Options = @Options, EndDate = @AdEndDate WHERE BarterAdID = @BarterAdID

		-- Update Barter Campaign Start/End dates and Credits used 
		UPDATE BarterCampaign SET StartDate = @Today, EndDate = @EndDate, Credits = @Credits WHERE BarterCampaignID = @BarterCampaignID

		-- Create Barter Credit (Debit)
		-- BarterCreditID,OwnerType,OwnerID,BarterAdID,CreditDate,Amount,Status,CreditType,StartDate,EndDate,Reference,Notes,UserID
		SET @Credits = @Credits * -1
		EXEC pts_BarterCredit_Add @ID, 151, @ConsumerID, @BarterAdID, @Today, @Credits, 1, 7, @Today, @EndDate, '', '', 1
	END
END

GO
