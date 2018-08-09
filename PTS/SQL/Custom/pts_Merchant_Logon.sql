EXEC [dbo].pts_CheckProc 'pts_Merchant_Logon'
GO

--DECLARE @Result int EXEC pts_Merchant_Logon '1', 'staff', @Result OUTPUT PRINT @Result

CREATE PROCEDURE [dbo].pts_Merchant_Logon
   @Email nvarchar (80) ,
   @Password nvarchar (20) ,
   @Result int OUTPUT
AS
-- RETURN VALUES
-- >0 ... Found MerchantID
-- <0 ... Found Merchant Password2
-- -1000002 ... Merchant Email Address not found
-- -1000003 ... Merchant Account Number not found
-- -1000004 ... Password not found

SET NOCOUNT ON

DECLARE @MerchantID int, @logonemail int, @logonid int, @Password1 nvarchar (20), @Password2 nvarchar (20), @Password3 nvarchar (20), @Password4 nvarchar (20)

SET @logonemail = CHARINDEX( '@', @Email )
SET @logonid = ISNUMERIC( @Email )
SET @Result = 0
SET @MerchantID = 0
	
IF @logonemail > 0 SELECT @MerchantID = MerchantID, @Password1 = Password, @Password2 = Password2, @Password3 = Password3, @Password4 = Password4 FROM Merchant WHERE Email = @Email
IF @logonid > 0 SELECT @MerchantID = MerchantID, @Password1 = Password, @Password2 = Password2, @Password3 = Password3, @Password4 = Password4 FROM Merchant WHERE MerchantID = CAST(@Email AS INT)
	
IF @MerchantID > 0
BEGIN
	SET @Result = -1000004
	IF @Password = @Password1 SET @Result = @MerchantID
	IF @Password = @Password2 SET @Result = @MerchantID
	IF @Password = @Password3 SET @Result = @MerchantID
	IF @Password = @Password4 SET @Result = @MerchantID
END
ELSE
BEGIN 
	IF @logonemail > 0 SET @Result = -1000002	
	IF @logonid > 0 SET @Result = -1000003	
END	

GO
