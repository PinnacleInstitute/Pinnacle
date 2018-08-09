EXEC [dbo].pts_CheckProc 'pts_BarterAd_Search2'
 GO

--DECLARE @MaxRows tinyint EXEC pts_BarterAd_Search2 '', '', @MaxRows OUTPUT, 5, 0, 0, 0, 0, 0, ''  PRINT @MaxRows
--DECLARE @MaxRows tinyint EXEC pts_BarterAd_Search2 '', '', @MaxRows OUTPUT, 15, 0, 0, 12, 0, 0, ''  PRINT @MaxRows
--DECLARE @MaxRows tinyint EXEC pts_BarterAd_Search2 '', '', @MaxRows OUTPUT, 17, 2, 0, 1, 0, 0, '' PRINT @MaxRows
--select * from barterad

CREATE PROCEDURE [dbo].pts_BarterAd_Search2 ( 
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
DECLARE @pos int, @x int, @option VARCHAR(200), @token VARCHAR(20), @values VARCHAR(100), @value VARCHAR(20), @MinPrice money, @MaxPrice money
DECLARE @ImageSize VARCHAR(2), @Conditions VARCHAR(10), @Payments VARCHAR(20)
SET @MinPrice = 0
SET @MaxPrice = 0 
SET @ImageSize = 's'
SET @Conditions = ''
SET @Payments = ''

IF @Status > 10
BEGIN
	SET @ImageSize = 'm'
	SET @Status = @Status - 10
END	

--Parse Options
WHILE @Description <> ''
BEGIN
	-- Get the next option
	SET @pos = CHARINDEX(';', @Description )
	IF @pos = 0
	BEGIN
		SET @option = @Description
		SET @Description = ''
	END	
	ELSE
	BEGIN 
		SET @option = SUBSTRING(@Description, 1, @pos-1)
		SET @Description = SUBSTRING(@Description, @pos+1, LEN(@Description)-@pos+1 )
	END
	
	IF @option != ''	
	BEGIN
		-- Get the token for the option
		SET @pos = CHARINDEX(':', @option )
		IF @pos != 0
		BEGIN
			SET @token = SUBSTRING(@option, 1, @pos-1)
			SET @values = SUBSTRING(@option, @pos+1, LEN(@option)-@pos+1)
			SET @x = 0 
			WHILE @values <> ''
			BEGIN
				SET @x = @x + 1
				SET @pos = CHARINDEX(',', @values )
				-- extract the value and truncate the values string
				IF @pos = 0
				BEGIN
					SET @value = @values
					SET @values = ''
				END	
				ELSE
				BEGIN 
					SET @value = SUBSTRING(@values, 1, @pos-1)
					SET @values = SUBSTRING(@values, @pos+1, LEN(@values)-@pos+1 )
				END
				
				IF LEN(@value) != 0
				BEGIN
					-- Process price range
					IF @token = 'Price'
					BEGIN
						IF ISNUMERIC( @value ) = 1
						BEGIN
							IF @x = 1 SET @MinPrice = CAST(@value AS money)
							IF @x = 2 SET @MaxPrice = CAST(@value AS money)
						END	
					END	
					IF @token = 'Condition'
					BEGIN
						IF ISNUMERIC( @value ) = 1 SET @Conditions = @Conditions + @value
					END	
					IF @token = 'Payment' 
					BEGIN
						SET @Payments = @Payments + @value
					END	
				END
			END
		END	
	END
END 

SET @MaxRows = 20

-- Process Relevent and Current Sort (PostDate)
IF @Status IN (5,6)
BEGIN
	IF (@Bookmark = '') SET @Bookmark = '99991231'

	SELECT TOP 21
		ISNULL(CONVERT(nvarchar(10), ba.PostDate, 112), '') + dbo.wtfn_FormatNumber(ba.BarterAdID, 10) 'BookMark' ,
		ba.BarterAdID, 
		ba.BarterArea1ID, 
		ba.BarterArea2ID, 
		ba.BarterCategoryID, 
		ba.Title, 
		ba.Price, 
		ba.Location, 
		ba.Zip, 
		ba.PostDate, 
		ba.UpdateDate, 
		ISNULL(CAST(bi.BarterImageID as VARCHAR(10)) + @ImageSize + '.' + bi.ext,'')  AS 'Image', 
		ba.Images, 
		ba.IsMap, 
		ba.Language, 
		bc.BarterCategoryName AS 'MapStreet1', 
		ba.MapStreet2,
		ba.Options
	FROM BarterAd AS ba
	JOIN BarterCategory AS bc ON ba.BarterCategoryID = bc.BarterCategoryID
	LEFT OUTER JOIN BarterImage AS bi ON bi.BarterImageID = (
		SELECT TOP 1 BarterImageID FROM BarterImage
		WHERE BarterAdID = ba.BarterAdID
		AND Status = 1 AND ext != ''
		ORDER BY Seq, BarterImageID 
	)
	WHERE ISNULL(CONVERT(nvarchar(10), ba.PostDate, 112), '') + dbo.wtfn_FormatNumber(ba.BarterAdID, 10) <= @BookMark
	AND ba.Status = 2
	AND (@BarterArea1ID = 0 OR ba.BarterArea1ID = @BarterArea1ID)
	AND (@BarterArea2ID = 0 OR ba.BarterArea2ID = @BarterArea2ID)
	AND (@MainCategoryID = 0 OR bc.ParentID = @MainCategoryID)
	AND (@BarterCategoryID = 0 OR ba.BarterCategoryID = @BarterCategoryID)
	AND ((@Images = 0) OR (ba.Images >= @Images))
	AND ((@MinPrice=0 AND @MaxPrice=0) OR (ba.Price >= @MinPrice AND ba.Price <= @MaxPrice))
	AND ((@Conditions = '') OR (CHARINDEX( CAST(ba.Condition AS VARCHAR(5)), @Conditions ) > 0) )
	AND ((@Payments = '') OR (dbo.wtfn_StrInStr( @Payments, ba.Payments ) > 0) )
	ORDER BY 'Bookmark' desc 
END

-- Process Lowest Price Sort
IF @Status = 7
BEGIN
	SELECT TOP 21
		RIGHT('00000000'+ISNULL(CONVERT(nvarchar(20), ba.Price),''),8) + dbo.wtfn_FormatNumber(ba.BarterAdID, 10) 'BookMark' ,
		ba.BarterAdID, 
		ba.BarterArea1ID, 
		ba.BarterArea2ID, 
		ba.BarterCategoryID, 
		ba.Title, 
		ba.Price, 
		ba.Location, 
		ba.Zip, 
		ba.PostDate, 
		ba.UpdateDate, 
		ISNULL(CAST(bi.BarterImageID as VARCHAR(10)) + @ImageSize + '.' + bi.ext,'')  AS 'Image', 
		ba.Images, 
		ba.IsMap, 
		ba.Language, 
		bc.BarterCategoryName AS 'MapStreet1', 
		ba.MapStreet2,
		ba.Options
	FROM BarterAd AS ba
	JOIN BarterCategory AS bc ON ba.BarterCategoryID = bc.BarterCategoryID
	LEFT OUTER JOIN BarterImage AS bi ON bi.BarterImageID = (
		SELECT TOP 1 BarterImageID FROM BarterImage
		WHERE BarterAdID = ba.BarterAdID
		AND Status = 1 AND ext != ''
		ORDER BY Seq, BarterImageID 
	)
	WHERE RIGHT('00000000'+ISNULL(CONVERT(nvarchar(20), ba.Price),''),8) + dbo.wtfn_FormatNumber(ba.BarterAdID, 10) >= @BookMark
	AND ba.Status = 2
	AND (@BarterArea1ID = 0 OR ba.BarterArea1ID = @BarterArea1ID)
	AND (@BarterArea2ID = 0 OR ba.BarterArea2ID = @BarterArea2ID)
	AND (@MainCategoryID = 0 OR bc.ParentID = @MainCategoryID)
	AND (@BarterCategoryID = 0 OR ba.BarterCategoryID = @BarterCategoryID)
	AND ((@Images = 0) OR (ba.Images >= @Images))
	AND ((@MinPrice=0 AND @MaxPrice=0) OR (ba.Price >= @MinPrice AND ba.Price <= @MaxPrice))
	AND ((@Conditions = '') OR (CHARINDEX( CAST(ba.Condition AS VARCHAR(5)), @Conditions ) > 0) )
	AND ((@Payments = '') OR (dbo.wtfn_StrInStr( @Payments, ba.Payments ) > 0) )
	ORDER BY 'Bookmark'  
END

-- Process Highest Price Sort
IF @Status = 8
BEGIN
	IF (@Bookmark = '') SET @Bookmark = '99999999'

	SELECT TOP 21
		RIGHT('00000000'+ISNULL(CONVERT(nvarchar(20), ba.Price),''),8) + dbo.wtfn_FormatNumber(ba.BarterAdID, 10) 'BookMark' ,
		ba.BarterAdID, 
		ba.BarterArea1ID, 
		ba.BarterArea2ID, 
		ba.BarterCategoryID, 
		ba.Title, 
		ba.Price, 
		ba.Location, 
		ba.Zip, 
		ba.PostDate, 
		ba.UpdateDate, 
		ISNULL(CAST(bi.BarterImageID as VARCHAR(10)) + @ImageSize + '.' + bi.ext,'')  AS 'Image', 
		ba.Images, 
		ba.IsMap, 
		ba.Language, 
		bc.BarterCategoryName AS 'MapStreet1', 
		ba.MapStreet2,
		ba.Options
	FROM BarterAd AS ba
	JOIN BarterCategory AS bc ON ba.BarterCategoryID = bc.BarterCategoryID
	LEFT OUTER JOIN BarterImage AS bi ON bi.BarterImageID = (
		SELECT TOP 1 BarterImageID FROM BarterImage
		WHERE BarterAdID = ba.BarterAdID
		AND Status = 1 AND ext != ''
		ORDER BY Seq, BarterImageID 
	)
	WHERE RIGHT('00000000'+ISNULL(CONVERT(nvarchar(20), ba.Price),''),8) + dbo.wtfn_FormatNumber(ba.BarterAdID, 10) <= @BookMark
	AND ba.Status = 2
	AND (@BarterArea1ID = 0 OR ba.BarterArea1ID = @BarterArea1ID)
	AND (@BarterArea2ID = 0 OR ba.BarterArea2ID = @BarterArea2ID)
	AND (@MainCategoryID = 0 OR bc.ParentID = @MainCategoryID)
	AND (@BarterCategoryID = 0 OR ba.BarterCategoryID = @BarterCategoryID)
	AND ((@Images = 0) OR (ba.Images >= @Images))
	AND ((@MinPrice=0 AND @MaxPrice=0) OR (ba.Price >= @MinPrice AND ba.Price <= @MaxPrice))
	AND ((@Conditions = '') OR (CHARINDEX( CAST(ba.Condition AS VARCHAR(5)), @Conditions ) > 0) )
	AND ((@Payments = '') OR (dbo.wtfn_StrInStr( @Payments, ba.Payments ) > 0) )
	ORDER BY 'Bookmark' desc 
END


GO
