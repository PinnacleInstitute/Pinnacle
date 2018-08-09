EXEC [dbo].pts_CheckProc 'pts_Promotion_ProductsPrice'
GO

CREATE PROCEDURE [dbo].pts_Promotion_ProductsPrice
   @SalesOrderID int ,
   @Products nvarchar(50),
   @Amount money OUTPUT
	
AS

SET NOCOUNT ON

SET @Amount = 0

DECLARE @IDs nvarchar(50), @x int, @xspace int, @cnt int, @ID int, @Price money 
DECLARE @ID1 int, @ID2 int, @ID3 int, @ID4 int, @ID5 int, @ID6 int, @ID7 int, @ID8 int, @ID9 int, @ID10 int 

-- Loop through sets of product numbers separated by semicolons "1,2,3;4,5,6"
WHILE @Products != ''
BEGIN
	SET @x = CHARINDEX(';', @Products)
	IF @x > 0
	BEGIN
		SET @IDs = CAST(SUBSTRING(@Products, 1, @x-1) AS int)
		SET @Products = LTRIM(SUBSTRING(@Products, @x+1, LEN(@Products)-@x))
	END
	ELSE
	BEGIN
		SET @IDs = @Products
		SET @Products = ''
	END

	SET @ID1 = 0
	SET @ID2 = 0
	SET @ID3 = 0
	SET @ID4 = 0
	SET @ID5 = 0
	SET @ID6 = 0
	SET @ID7 = 0
	SET @ID8 = 0
	SET @ID9 = 0
	SET @ID10 = 0
	
-- 	Loop through product numbers separated by commas "1,2,3"
	SET @cnt = 0
	WHILE @IDs != ''
	BEGIN
		SET @x = CHARINDEX(',', @IDs)
		SET @xspace = CHARINDEX(' ', @IDs)
--		Found comma and space, use the first one found	
		IF @x > 0 AND @xspace > 0 IF @xspace < @x SET @x = @xspace
--		Found space only, use the space
		IF @x = 0 AND @xspace > 0 SET @x = @xspace
--		Found comma only, use the comma
	
		IF @x > 0
		BEGIN
			SET @ID = CAST(SUBSTRING(@IDs, 1, @x-1) AS int)
			SET @IDs = LTRIM(SUBSTRING(@IDs, @x+1, LEN(@IDs)-@x))
		END
		ELSE
		BEGIN
			SET @ID = CAST(@IDs AS int)
			SET @IDs = ''
		END
		IF @ID!=@ID1 AND @ID!=@ID2 AND @ID!=@ID3 AND @ID!=@ID4 AND @ID!=@ID5 AND
		   @ID!=@ID6 AND @ID!=@ID7 AND @ID!=@ID8 AND @ID!=@ID9 AND @ID!=@ID10
		BEGIN
			SET @cnt = @cnt + 1
			IF @cnt = 1 SET @ID1 = @ID
			IF @cnt = 2 SET @ID2 = @ID
			IF @cnt = 3 SET @ID3 = @ID
			IF @cnt = 4 SET @ID4 = @ID
			IF @cnt = 5 SET @ID5 = @ID
			IF @cnt = 6 SET @ID6 = @ID
			IF @cnt = 7 SET @ID7 = @ID
			IF @cnt = 8 SET @ID8 = @ID
			IF @cnt = 9 SET @ID9 = @ID
			IF @cnt = 10 SET @ID10 = @ID
		END 
	END 
	
--	get the price of the first specified product number in the sales order
	SELECT TOP 1 @Price = ISNULL(Price+OptionPrice,0)
	FROM   SalesItem (NOLOCK)
	WHERE  SalesOrderID = @SalesOrderID
	AND    ProductID IN (@ID1, @ID2, @ID3, @ID4, @ID5, @ID6, @ID7, @ID8, @ID9, @ID10)

	IF @Price > 0 SET @Amount = @Amount + @Price
END


GO