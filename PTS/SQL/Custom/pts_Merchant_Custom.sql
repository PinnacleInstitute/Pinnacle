EXEC [dbo].pts_CheckProc 'pts_Merchant_Custom'
GO

--DECLARE @Result nvarchar (1000)  EXEC pts_Merchant_Custom 1, 2, 0, 0, 0, '', @Result OUTPUT  PRINT @Result

CREATE PROCEDURE [dbo].pts_Merchant_Custom
   @MerchantID int ,
   @Status int ,
   @MemberID int ,
   @BillingID int ,
   @EnrollDate datetime ,
   @Access nvarchar (80) ,
   @Result nvarchar (1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = ''

DECLARE @Coin Int, @cnt int

-- Get All accepted coins for the merchant
IF @Status = 1
BEGIN
	DECLARE Coin_cursor CURSOR LOCAL STATIC FOR 
	SELECT Coin FROM CoinAddress WHERE MerchantID = @MerchantID AND Status = 1 ORDER BY Coin
	OPEN Coin_cursor
	FETCH NEXT FROM Coin_cursor INTO @Coin
	SET @Result = ','
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @Result = @Result + CAST(@Coin AS VARCHAR(5)) + ','
		FETCH NEXT FROM Coin_cursor INTO @Coin
	END
	CLOSE Coin_cursor
	DEALLOCATE Coin_cursor
END

-- Get the number of orders pending approval
IF @Status = 2
BEGIN
	SELECT @cnt = COUNT(*) FROM Payment2 WHERE MerchantID = @MerchantID AND PayType = 1 AND Status = 1
	SET @Result = CAST(@cnt AS VARCHAR(10))
END

GO