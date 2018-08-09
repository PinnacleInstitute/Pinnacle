EXEC [dbo].pts_CheckProc 'pts_BarterArea_Custom'
GO

--DECLARE @Result nvarchar (1000) EXEC pts_BarterArea_Custom 1, 11, @Result OUTPUT PRINT @Result
-- select * from barterarea

CREATE PROCEDURE [dbo].pts_BarterArea_Custom
   @Status int ,
   @BarterAreaID int ,
   @Result nvarchar (1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = ''

-- Get all the target labels
IF @Status = 1
BEGIN
	DECLARE @Country nvarchar(50), @State nvarchar(40), @City nvarchar(40), @Area nvarchar(40)
	DECLARE @CountryID int, @BarterAreaType int, @BarterAreaName nvarchar(40), @ParentID int

	SET @Country = '' SET @State = '' SET @City = '' SET @Area = ''

	Select @BarterAreaName = BarterAreaName, @BarterAreaType = BarterAreaType, @ParentID = ParentID, @CountryID = CountryID FROM BarterArea WHERE BarterAreaID = @BarterAreaID
	IF @BarterAreaType = 3
	BEGIN
		SET @Area = @BarterAreaName
		Select @BarterAreaName = BarterAreaName, @BarterAreaType = BarterAreaType, @ParentID = ParentID FROM BarterArea WHERE BarterAreaID = @ParentID
	END
	IF @BarterAreaType = 2
	BEGIN
		SET @City = @BarterAreaName
		Select @BarterAreaName = BarterAreaName, @BarterAreaType = BarterAreaType, @ParentID = ParentID FROM BarterArea WHERE BarterAreaID = @ParentID
	END
	IF @BarterAreaType = 1 SET @State = @BarterAreaName
	Select @Country = CountryName FROM Country WHERE CountryID = @CountryID

	IF @Area != '' SET @Result = '"' + @Area + '" or '
	SET @Result = @Result + '"' + @City + '" or "' + @State + '" or "' + @Country + '"'

END

GO