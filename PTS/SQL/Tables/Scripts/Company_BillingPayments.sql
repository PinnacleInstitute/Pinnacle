
SET NOCOUNT ON
DECLARE @CompanyID int
DECLARE @MemberID int, @Price money, @IsMaster bit, @IsDiscount bit, @Discount int
DECLARE @EnrollDate datetime, @TrialDays int, @BillingID int
DECLARE @Total money, @Credit money, @MasterPrice money
DECLARE @Cnt int, @Notes nvarchar(500), @tmpNotes nvarchar(500), @tmpDescription varchar(100)
DECLARE @PayType int, @BillingInfo nvarchar(100)
DECLARE @Now datetime, @PaymentID int

SET @Now = GETDATE()

-----------------------------------------------
-----------------------------------------------
--(13, 121, 140, 151, 154, 155, 403)  
SET @CompanyID = 403
Select Notes, description, * from payment where ownertype = 38 --and ownerid = 13 
-----------------------------------------------
-----------------------------------------------

--**********************************************************************************************************
--Process Bill Company (Billing = 2)
DECLARE @TotalCount int, @MasterCount int, @CreditCount int
DECLARE @TotalPrice money, @TotalMaster money, @TotalCredit money

DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID
FROM Member WHERE CompanyID = @CompanyID AND Price > 0 AND Status = 1 AND Billing = 2

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID

SET @TotalCount = 0
SET @Notes = ''

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @TotalCount = @TotalCount + 1
	SET @Notes = @Notes + CAST(@MemberID AS varchar(10)) + ' '
	FETCH NEXT FROM Member_cursor INTO @MemberID
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

IF @TotalCount > 0
BEGIN
	SET @Notes = 'Members:[' + @Notes + ']'
	UPDATE PAYMENT SET Notes = @Notes
	WHERE OwnerType = 38 AND OwnerID = @CompanyID AND Description not like 'UNBILLED%'
END
--select ownerid from payment
--WHERE OwnerType = 38
--order by ownerid
-- AND OwnerID = 13 AND Description like '%UNBILLED%'


--**********************************************************************************************************
--Process Bill Company for all other members not yet billed (skip no billing(1))
-- e.g. Bill Member (3) with No BillingID
-- e.g. Bill Master (4) with No MasterID
DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID
FROM Member WHERE CompanyID = @CompanyID AND Price > 0 AND Status = 1 AND Billing != 1

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID

SET @TotalCount = 0
SET @Notes = ''

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @TotalCount = @TotalCount + 1
	SET @Notes = @Notes + CAST(@MemberID AS varchar(10)) + ' '

	FETCH NEXT FROM Member_cursor INTO @MemberID
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

SET @tmpDescription = 'UNBILLED MEMBERS: '
IF @TotalCount > 0
BEGIN
	SET @Notes = 'Members:[' + @Notes + ']'
	UPDATE PAYMENT SET Notes = @Notes 
	WHERE OwnerType = 38 AND OwnerID = @CompanyID AND Description like 'UNBILLED%'
END

