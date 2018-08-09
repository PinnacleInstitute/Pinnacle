EXEC [dbo].pts_CheckProc 'pts_Payment_Custom'
GO

--declare @Result int EXEC pts_Payment_Custom 0, '25192', 3, 'test', @Result
--declare @Result int EXEC pts_Payment_Custom 1, '4016', 21, '0', @Result OUTPUT print @Result
--SELECT * FROM Payment WHERE CompanyID = 21 and PayDate = dbo.wtfn_DateOnly(GETDATE()) AND PayType IN (1,2,3,4)
-- Charged:[1; 4016702001489223; 3/20; 974; Marcus Counts; 3412 Stoneridge Drive; ; Johnson City; TN; 37604; US]

CREATE PROCEDURE [dbo].pts_Payment_Custom
   @PaymentID int ,
   @Reference nvarchar (30) ,
   @Status int ,
   @Notes nvarchar (200) ,
   @Result int OUTPUT
AS

SET NOCOUNT ON
SET @Result = 0

--PaymentID=0 - CallBack function for payment processing
IF @PaymentID = 0
BEGIN
	IF @Reference <> ''
	BEGIN
		UPDATE Payment SET Status = @Status, Notes = Notes + @Notes WHERE Reference = @Reference
		SET @Result = 1
	END
END

-- Custom Payment Validation
IF @PaymentID = 1
BEGIN
	DECLARE @CompanyID int, @CC nvarchar(30), @Today datetime, @cnt int, @PID int
	SET @CompanyID = @Status
	SET @CC = @Reference
	SET @Today = dbo.wtfn_DateOnly(GETDATE())
	SET @PID = 0
	IF ISNUMERIC(@Notes) = 1
	BEGIN 
		SET @PID = CAST(@Notes AS int) 
	END  
	
	IF @CompanyID = 21 -- Nexxus
	BEGIN
		-- Disallow the same CC Number from being used in the same day
		SELECT @cnt = COUNT(*) FROM Payment 
		WHERE CompanyID = 21 and PayDate = dbo.wtfn_DateOnly(GETDATE()) 
		AND PayType IN (1,2,3,4) AND PaymentID != @PID
		AND Description LIKE '%' + @CC + '%'
		SET @Result = @cnt
	END
END

GO
