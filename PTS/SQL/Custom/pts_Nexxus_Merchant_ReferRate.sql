EXEC [dbo].pts_CheckProc 'pts_Nexxus_Merchant_ReferRate'
GO

-- EXEC pts_Nexxus_Merchant_ReferRate
-- update merchant set referrate=10
-- select referrate, * from merchant

CREATE PROCEDURE [dbo].pts_Nexxus_Merchant_ReferRate
AS

SET NOCOUNT ON

DECLARE @MerchantID int, @cnt int, @ReferRate int

-- Process all active merchants
DECLARE Merchant_cursor CURSOR LOCAL STATIC FOR 
SELECT MerchantID FROM Merchant WHERE Status = 3
OPEN Merchant_cursor
FETCH NEXT FROM Merchant_cursor INTO @MerchantID
WHILE @@FETCH_STATUS = 0
BEGIN
	
	SELECT @cnt = COUNT(*) FROM Consumer WHERE MerchantID = @MerchantID AND ReferID = 0 
	SET @ReferRate = 10
	IF @cnt >= 1000 AND @cnt < 3000 SET @ReferRate = 12
	IF @cnt >= 3000 AND @cnt < 5000 SET @ReferRate = 14
	IF @cnt >= 5000 AND @cnt < 7500 SET @ReferRate = 16
	IF @cnt >= 7500 AND @cnt < 10000 SET @ReferRate = 18
	IF @cnt >= 10000 SET @ReferRate = 20
	
	UPDATE Merchant SET ReferRate = @ReferRate WHERE MerchantID = @MerchantID

	FETCH NEXT FROM Merchant_cursor INTO @MerchantID
END
CLOSE Merchant_cursor
DEALLOCATE Merchant_cursor

GO
