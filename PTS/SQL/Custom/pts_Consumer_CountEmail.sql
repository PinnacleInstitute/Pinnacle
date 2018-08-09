EXEC [dbo].pts_CheckProc 'pts_Consumer_CountEmail'
GO
--DECLARE @Cnt int EXEC pts_Consumer_CountEmail 1, 1, 1, 30, '75075,75093', 224, @Cnt OUTPUT PRINT @Cnt

CREATE PROCEDURE [dbo].pts_Consumer_CountEmail
   @MerchantID int ,
   @TargetArea int ,
   @TargetType int ,
   @TargetDays int ,
   @Target nvarchar (200) ,
   @CountryID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON
SET @Result = 0

DECLARE @pos int, @val NVARCHAR(20), @TargetDate datetime
DECLARE @TargetTable TABLE (Target nvarchar(20))

SET @TargetDate = DATEADD( day, @TargetDays * -1, dbo.wtfn_DateOnly(GETDATE()) )

--Parse Target Values
WHILE @Target <> ''
BEGIN
	SET @pos = CHARINDEX(',', @Target )
	IF @pos = 0
		BEGIN SET @val = @Target SET @Target = '' END
	ELSE	
		BEGIN SET @val = Left(@Target, @pos - 1) SET @Target = SUBSTRING(@Target, @pos+1, LEN(@Target)) END
	INSERT @TargetTable VALUES ( @val )
END 

--Zip Code Target
IF @TargetArea = 1
BEGIN
	-- All Shoppers
	IF @TargetType <= 1
	BEGIN 
		SELECT @Result = COUNT(*) FROM Consumer (NOLOCK)
		WHERE Status = 2 AND Messages < 3
		AND ( ( CountryID = @CountryID AND EXISTS (SELECT * FROM @TargetTable WHERE Target = Zip) ) 
		OR ( CountryID2 = @CountryID AND EXISTS (SELECT Target FROM @TargetTable WHERE Target = Zip2) ) )
		AND NOT EXISTS (SELECT * FROM Block WHERE MerchantID = @MerchantID AND ConsumerID = Consumer.ConsumerID)
	END
	-- Other Shoppers
	IF @TargetType = 2
	BEGIN 
		SELECT @Result = COUNT(*) FROM Consumer (NOLOCK)
		WHERE Status = 2 AND Messages < 3
		AND ( ( CountryID = @CountryID AND EXISTS (SELECT * FROM @TargetTable WHERE Target = Zip) ) 
		OR ( CountryID2 = @CountryID AND EXISTS (SELECT Target FROM @TargetTable WHERE Target = Zip2) ) )
		AND NOT EXISTS (SELECT * FROM Block WHERE MerchantID = @MerchantID AND ConsumerID = Consumer.ConsumerID)
		AND NOT EXISTS (SELECT * FROM Payment2 WHERE MerchantID = @MerchantID AND ConsumerID = Consumer.ConsumerID ) 
	END
	-- My Shoppers
	IF @TargetType = 3
	BEGIN 
		SELECT @Result = COUNT(*) FROM Consumer (NOLOCK)
		WHERE Status = 2 AND Messages < 3
		AND ( ( CountryID = @CountryID AND EXISTS (SELECT * FROM @TargetTable WHERE Target = Zip) ) 
		OR ( CountryID2 = @CountryID AND EXISTS (SELECT Target FROM @TargetTable WHERE Target = Zip2) ) )
		AND NOT EXISTS (SELECT * FROM Block WHERE MerchantID = @MerchantID AND ConsumerID = Consumer.ConsumerID)
		AND EXISTS (SELECT * FROM Payment2 WHERE MerchantID = @MerchantID AND ConsumerID = Consumer.ConsumerID ) 
	END
	-- My Frequent Shoppers
	IF @TargetType = 4
	BEGIN 
		SELECT @Result = COUNT(*) FROM Consumer (NOLOCK)
		WHERE Status = 2 AND Messages < 3
		AND ( ( CountryID = @CountryID AND EXISTS (SELECT * FROM @TargetTable WHERE Target = Zip) ) 
		OR ( CountryID2 = @CountryID AND EXISTS (SELECT Target FROM @TargetTable WHERE Target = Zip2) ) )
		AND NOT EXISTS (SELECT * FROM Block WHERE MerchantID = @MerchantID AND ConsumerID = Consumer.ConsumerID)
		AND EXISTS (SELECT * FROM Payment2 WHERE MerchantID = @MerchantID AND ConsumerID = Consumer.ConsumerID AND PayDate > @TargetDate) 
	END
	-- My Infrequent Shoppers
	IF @TargetType = 5
	BEGIN 
		SELECT @Result = COUNT(*) FROM Consumer (NOLOCK)
		WHERE Status = 2 AND Messages < 3
		AND ( ( CountryID = @CountryID AND EXISTS (SELECT * FROM @TargetTable WHERE Target = Zip) ) 
		OR ( CountryID2 = @CountryID AND EXISTS (SELECT Target FROM @TargetTable WHERE Target = Zip2) ) )
		AND NOT EXISTS (SELECT * FROM Block WHERE MerchantID = @MerchantID AND ConsumerID = Consumer.ConsumerID)
		AND EXISTS (SELECT * FROM Payment2 WHERE MerchantID = @MerchantID AND ConsumerID = Consumer.ConsumerID) 
		AND NOT EXISTS (SELECT * FROM Payment2 WHERE MerchantID = @MerchantID AND ConsumerID = Consumer.ConsumerID AND PayDate > @TargetDate) 
	END
END


--City Target
IF @TargetArea = 2
BEGIN
	SELECT @Result = COUNT(*) FROM Consumer (NOLOCK)
	WHERE Status = 2 AND Messages < 3
	AND ( ( CountryID = @CountryID AND EXISTS (SELECT * FROM @TargetTable WHERE Target = Zip) ) 
	OR ( CountryID2 = @CountryID AND EXISTS (SELECT Target FROM @TargetTable WHERE Target = Zip2) ) )
	AND NOT EXISTS (SELECT * FROM Block WHERE MerchantID = @MerchantID AND ConsumerID = Consumer.ConsumerID)
END

--State Target
IF @TargetArea = 3
BEGIN
	SELECT @Result = COUNT(*) FROM Consumer (NOLOCK)
	WHERE Status = 2 AND Messages < 3
	AND ( ( CountryID = @CountryID AND EXISTS (SELECT * FROM @TargetTable WHERE Target = Zip) ) 
	OR ( CountryID2 = @CountryID AND EXISTS (SELECT Target FROM @TargetTable WHERE Target = Zip2) ) )
	AND NOT EXISTS (SELECT * FROM Block WHERE MerchantID = @MerchantID AND ConsumerID = Consumer.ConsumerID)
END

GO