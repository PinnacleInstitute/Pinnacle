EXEC [dbo].pts_CheckProc 'pts_Merchant_Logon2'
GO

--DECLARE @Result int EXEC pts_Merchant_Logon2 'bob@pinnaclep.com', @Result OUTPUT PRINT @Result

CREATE PROCEDURE [dbo].pts_Merchant_Logon2
   @Email nvarchar (80) ,
   @Result int OUTPUT
AS
-- RETURN VALUES
-- >0 ... Found MerchantID
-- -1000002 ... Merchant Email Address not found
-- -1000003 ... Merchant Account Number not found

SET NOCOUNT ON

DECLARE @MerchantID int, @logonemail int, @logonid int

SET @logonemail = CHARINDEX( '@', @Email )
SET @logonid = ISNUMERIC( @Email )
SET @Result = 0
SET @MerchantID = 0
	
IF @logonemail > 0 SELECT @MerchantID = MerchantID FROM Merchant WHERE Email = @Email
IF @logonid > 0 SELECT @MerchantID = MerchantID FROM Merchant WHERE MerchantID = CAST(@Email AS INT)
	
IF @MerchantID > 0
BEGIN
	SET @Result = @MerchantID
END
ELSE
BEGIN 
	IF @logonemail > 0 SET @Result = -1000002	
	IF @logonid > 0 SET @Result = -1000003	
END	

GO