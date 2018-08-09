EXEC [dbo].pts_CheckProc 'pts_Merchant_UpdateFT'
GO

CREATE PROCEDURE [dbo].pts_Merchant_UpdateFT
   @MerchantID int,
   @MerchantName nvarchar (80),
   @City nvarchar (30),
   @State nvarchar (30),
   @Zip nvarchar (20),
   @CountryName nvarchar (50),
   @Description nvarchar (2000),
   @Result int OUTPUT
AS

DECLARE @ID int

SELECT @ID = @MerchantID FROM MerchantFT WHERE MerchantID = @MerchantID

IF @ID IS NULL
BEGIN
	INSERT INTO MerchantFT ( MerchantID, FT ) VALUES ( @MerchantID, @MerchantName + ' ' + @City + ' ' + @State + ' ' + @Zip + ' ' + @CountryName + ' ' + @Description )

	SET @Result = 1
END
IF @ID > 0
BEGIN
	UPDATE MerchantFT
	SET FT = @MerchantName + ' ' + @City + ' ' + @State + ' ' + @Zip + ' ' + @CountryName + ' ' + @Description
	WHERE MerchantID = @MerchantID

	SET @Result = 2
END

GO

