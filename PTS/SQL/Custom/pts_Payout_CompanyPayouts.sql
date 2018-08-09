EXEC [dbo].pts_CheckProc 'pts_Payout_CompanyPayouts'
GO

--DECLARE @cnt int EXEC pts_Payout_CompanyPayouts 17, '12/25/14', @cnt output print @cnt

CREATE PROCEDURE [dbo].pts_Payout_CompanyPayouts
   @CompanyID int ,
   @PayDate datetime,
   @Count int OUTPUT
AS

SET NOCOUNT ON
SET @Count = 0

DECLARE @PayoutID int, @OwnerType int, @OwnerID int, @Amount money, @PayType int, @PaidDate datetime, @PayoutProcessors varchar(20) 
DECLARE @PostDate datetime, @Reference varchar(30) 

IF @PayDate = 0 SET @PayDate = dbo.wtfn_DateOnly(GETDATE())
SET @PayType = 0
SET @PaidDate = 0
SET @PostDate = @PayDate
SET @Reference = ''

--Check for Payout Wallet
SELECT @PayoutProcessors = PayoutProcessors FROM Coption WHERE CompanyID = @CompanyID
IF CHARINDEX('10', @PayoutProcessors) > 0
BEGIN
	SET @PayType = 91
	SET @PostDate = dbo.wtfn_DateOnly(GETDATE())
	SET @PaidDate = @PostDate
	SET @Reference = dbo.wtfn_DateOnlyStr(@PayDate)
END

-- Get all earned unpaid commissions for each member
DECLARE Commission_cursor CURSOR LOCAL STATIC FOR 
SELECT OwnerType, OwnerID, SUM(Amount)
FROM Commission 
WHERE CompanyID = @CompanyID
AND dbo.wtfn_DateOnly(CommDate) <= @PayDate
AND Status = 1
AND OwnerType <> 150 -- Merchant commissions are summarized on invoices
GROUP BY OwnerType, OwnerID

OPEN Commission_cursor
FETCH NEXT FROM Commission_cursor INTO @OwnerType, @OwnerID, @Amount

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Count = @Count + 1

--	PayoutID OUTPUT, CompanyID, OwnerType, OwnerID, PayDate, PaidDate, Amount, Status, Notes, PayType, Reference, Show, UserID
	EXEC pts_Payout_Add @PayoutID OUTPUT, @CompanyID, @OwnerType, @OwnerID, @PostDate, @PaidDate, @Amount, 1, '', @PayType, @Reference, 1, 1

	UPDATE Commission SET PayoutID = @PayoutID, Status = 2 
	WHERE OwnerType = @OwnerType AND OwnerID = @OwnerID AND dbo.wtfn_DateOnly(CommDate) <= @PayDate AND Status = 1

	FETCH NEXT FROM Commission_cursor INTO @OwnerType, @OwnerID, @Amount
END
CLOSE Commission_cursor
DEALLOCATE Commission_cursor

GO
