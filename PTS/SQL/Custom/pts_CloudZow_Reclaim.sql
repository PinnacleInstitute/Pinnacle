EXEC [dbo].pts_CheckProc 'pts_CloudZow_Reclaim'
GO

--declare @Result varchar(1000) EXEC pts_CloudZow_Reclaim 3339, @Result output print @Result

CREATE PROCEDURE [dbo].pts_CloudZow_Reclaim
   @Status int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int, @Count int, @PaymentID int, @Today datetime
SET @CompanyID = 5
SET @PaymentID = @Status
SET @Today = GETDATE()

-- Test if we already reclaimed these commissions
SELECT @Count = COUNT(*) FROM Commission WHERE RefID = @PaymentID AND Amount < 0

IF @Count = 0
BEGIN
--	Get the total number of reclaimed commissions 
	SELECT @Count = COUNT(*) FROM Commission WHERE RefID = @PaymentID

--	Add a negative commission for each reclaimed commission 
	INSERT INTO Commission ( CompanyID, OwnerType, OwnerID, RefID, CommDate, CommType, Status, Amount, Total, Description )
	SELECT                   CompanyID, OwnerType, OwnerID, RefID, @Today, Commtype, 1, Amount*-1, Total*-1, Description FROM Commission
	WHERE RefID = @PaymentID

	UPDATE Payment SET CommStatus = 4, CommDate = @Today WHERE PaymentID = @PaymentID
	SET @Result = CAST( @Count AS VARCHAR(10))
END

GO
