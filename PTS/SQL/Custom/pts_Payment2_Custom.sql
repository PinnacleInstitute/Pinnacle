EXEC [dbo].pts_CheckProc 'pts_Payment2_Custom'
GO

--DECLARE @Result nvarchar (1000) EXEC pts_Payment2_Custom 2, 1, 0, 0, 0, '', @Result OUTPUT PRINT @Result

CREATE PROCEDURE [dbo].pts_Payment2_Custom
   @Status int ,
   @MerchantID int ,
   @PayType int ,
   @Amount money ,
   @PayDate datetime ,
   @Description nvarchar (100) ,
   @Result nvarchar (1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = ''
DECLARE @Payment2ID int, @Coin int, @Reference varchar(40), @tmpDate datetime 


-- Update Payment to Pending Status
IF @Status = 1
BEGIN
	SET @Payment2ID = @MerchantID
	-- Update payment to pending status
	UPDATE Payment2 SET Status = 2 WHERE Payment2ID = @Payment2ID AND Status = 1
	-- Update payment rewards to pending status
	UPDATE Reward SET Status = 2 WHERE Payment2ID = @Payment2ID AND Status = 1
END

-- Look for a reusable coin address
IF @Status = 2
BEGIN
	SET @Coin = @MerchantID
	SET @Payment2ID = 0
	SET @tmpDate = DATEADD(DAY,-1,GETDATE())
	SELECT TOP 1 @Payment2ID = Payment2ID, @Reference = Reference FROM Payment2 
	WHERE Status = 0 AND PayDate < @tmpDate AND PayType = @Coin+2 AND PaidCoins = 0 AND Reference <> '' AND LEFT(Reference,1) <> '-' AND LEFT(Reference,2) <> '1-'
	ORDER BY Status, PayDate
	IF @Payment2ID > 0 
	BEGIN
	 SET @Result = @Reference
	 UPDATE Payment2 SET Reference = '-' + Reference WHERE Payment2ID = @Payment2ID
	END 
END

GO

