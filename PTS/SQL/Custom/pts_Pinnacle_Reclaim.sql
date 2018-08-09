EXEC [dbo].pts_CheckProc 'pts_Pinnacle_Reclaim'
GO

--declare @Result varchar(1000) EXEC pts_Pinnacle_Reclaim 85191, @Result output print @Result
--select * from Commission where RefID = 85191
--SELECT TOP 1 CommissionID FROM Commission WHERE  RefID = 85191 AND Amount < 0 ORDER BY CommissionID DESC  

CREATE PROCEDURE [dbo].pts_Pinnacle_Reclaim
   @Status int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @Count int, @PaymentID int, @Today datetime, @CommissionID int
SET @PaymentID = @Status
SET @Today = GETDATE()
SET @CommissionID = 0

-- Test if we already reclaimed these commissions
SELECT @Count = COUNT(*) FROM Commission WHERE RefID = @PaymentID AND Amount < 0
IF @Count > 0 SELECT TOP 1 @CommissionID = CommissionID FROM Commission WHERE  RefID = @PaymentID AND Amount < 0 ORDER BY CommissionID DESC  

--	Get the total number of reclaimed commissions 
SELECT @Count = COUNT(*) FROM Commission WHERE RefID = @PaymentID

--	Add a negative commission for each reclaimed commission 
INSERT INTO Commission ( CompanyID, OwnerType, OwnerID, RefID, CommDate, CommType, Status, Amount, Total, Description )
SELECT                   CompanyID, OwnerType, OwnerID, RefID, @Today, Commtype, 1, Amount*-1, Total*-1, Description FROM Commission
WHERE RefID = @PaymentID AND CommissionID > @CommissionID

UPDATE Payment SET CommStatus = 4, CommDate = @Today WHERE PaymentID = @PaymentID
SET @Result = CAST( @Count AS VARCHAR(10))

GO
