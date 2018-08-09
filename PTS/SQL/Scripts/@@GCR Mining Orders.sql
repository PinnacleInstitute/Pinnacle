-- **************************************************
-- Calculate GCR Finances for the time period
-- **************************************************
DECLARE @StartDate datetime, @EndDate datetime, @Revenue money, @Amount money, @COGS money, @cnt int
DECLARE @MemberID int, @OrderDate datetime, @Notes nvarchar(500)
--SET @StartDate = '7/1/14 00:00:00'
--SET @EndDate = '7/18/14 00:00:00'
--SET @StartDate = '7/18/14 00:00:00'
--SET @EndDate = '7/25/14 00:00:00'
--SET @StartDate = '7/25/14 00:00:00'
--SET @EndDate = '8/1/14 12:00:00'
--SET @StartDate = '8/1/14 12:00:00'
--SET @EndDate = '8/8/14 00:00:00'
--SET @StartDate = '8/8/14 00:00:00'
--SET @EndDate = '8/15/14 00:00:00'
--SET @StartDate = '8/15/14 00:00:00'
--SET @EndDate = '8/22/14 00:00:00'
--SET @StartDate = '8/22/14 00:00:00'
--SET @EndDate = '8/29/14 00:00:00'
--SET @StartDate = '8/29/14 00:00:00'
--SET @EndDate = '9/5/14 00:00:00'
--SET @StartDate = '9/5/14 00:00:00'
--SET @EndDate = '9/12/14 00:00:00'
--SET @StartDate = '9/12/14 00:00:00'
--SET @EndDate = '9/19/14 00:00:00'
--SET @StartDate = '9/19/14 00:00:00'
--SET @EndDate = '9/26/14 00:00:00'
--SET @StartDate = '9/26/14 00:00:00'
--SET @EndDate = '10/3/14 00:00:00'
--SET @StartDate = '10/3/14 00:00:00'
--SET @EndDate = '10/10/14 00:00:00'
--SET @StartDate = '10/10/14 00:00:00'
--SET @EndDate = '10/17/14 00:00:00'
--SET @StartDate = '10/17/14 00:00:00'
--SET @EndDate = '10/24/14 00:00:00'
--SET @StartDate = '10/24/14 00:00:00'
--SET @EndDate = '10/31/14 00:00:00'
--SET @StartDate = '10/31/14 00:00:00'
--SET @EndDate = '11/7/14 00:00:00'
--SET @StartDate = '11/7/14 00:00:00'
--SET @EndDate = '11/14/14 00:00:00'
--SET @StartDate = '11/14/14 00:00:00'
--SET @EndDate = '11/21/14 00:00:00'
--SET @StartDate = '11/21/14 00:00:00'
--SET @EndDate = '11/28/14 00:00:00'
--SET @StartDate = '11/28/14 00:00:00'
--SET @EndDate = '12/5/14 00:00:00'
--SET @StartDate = '12/5/14 00:00:00'
--SET @EndDate = '12/12/14 00:00:00'
--SET @StartDate = '12/12/14 00:00:00'
--SET @EndDate = '12/19/14 00:00:00'
--SET @StartDate = '12/19/14 00:00:00'
--SET @EndDate = '12/26/14 00:00:00'
--SET @StartDate = '12/26/14 00:00:00'
--SET @EndDate = '1/2/15 00:00:00'
--SET @StartDate = '1/2/15 00:00:00'
--SET @EndDate = '1/9/15 00:00:00'
--SET @StartDate = '1/9/15 00:00:00'
--SET @EndDate = '1/16/15 00:00:00'
--SET @StartDate = '1/16/15 00:00:00'
--SET @EndDate = '1/23/15 00:00:00'
--SET @StartDate = '1/23/15 00:00:00'
--SET @EndDate = '1/30/15 00:00:00'
--SET @StartDate = '1/30/15 00:00:00'
--SET @EndDate = '2/6/15 00:00:00'
--SET @StartDate = '2/6/15 00:00:00'
--SET @EndDate = '2/12/15 00:00:00'
--SET @StartDate = '2/12/15 00:00:00'
--SET @EndDate = '2/20/15 00:00:00'
--SET @StartDate = '2/20/15 00:00:00'
--SET @EndDate = '2/27/15 00:00:00'
--SET @StartDate = '2/27/15 00:00:00'
--SET @EndDate = '3/6/15 00:00:00'
--SET @StartDate = '3/6/15 00:00:00'
--SET @EndDate = '3/13/15 00:00:00'
--SET @StartDate = '3/13/15 00:00:00'
--SET @EndDate = '3/20/15 00:00:00'
--SET @StartDate = '3/20/15 00:00:00'
--SET @EndDate = '3/27/15 00:00:00'
--SET @StartDate = '3/27/15 00:00:00'
--SET @EndDate = '4/3/15 00:00:00'
--SET @StartDate = '4/3/15 00:00:00'
--SET @EndDate = '4/13/15 00:00:00'
SET @StartDate = '4/13/15 00:00:00'
SET @EndDate = '4/20/15 00:00:00'
--SET @StartDate = '4/20/15 00:00:00'
--SET @EndDate = '4/27/15 00:00:00'
SET @StartDate = '9/14/15 00:00:00'
SET @EndDate = '9/21/15 00:00:00'
SET @StartDate = '9/21/15 00:00:00'
SET @EndDate = '9/28/15 00:00:00'

PRINT 'GCR Mining Orders:  ' + CAST(@StartDate AS varchar(20)) + ' - ' + CAST(@EndDate AS varchar(20))
PRINT '------------------------'
SET @COGS = 0
SELECT @cnt = COUNT(*) FROM Payment WHERE CompanyID = 17 AND Status = 3 AND (Purpose LIKE '103%' OR Purpose LIKE '203%') AND PaidDate >= @StartDate AND PaidDate < @EndDate 
SET @Amount = 6 * @cnt
SET @COGS = @COGS + @Amount
PRINT 'Pack A:   $6 * ' + CAST(@cnt AS VARCHAR(10)) + ' = ' + CAST(@Amount AS VARCHAR(10))

SELECT @cnt = COUNT(*) FROM Payment WHERE CompanyID = 17 AND Status = 3 AND (Purpose LIKE '104%' OR Purpose LIKE '204%') AND PaidDate >= @StartDate AND PaidDate < @EndDate 
SET @Amount = 18 * @cnt
SET @COGS = @COGS + @Amount
PRINT 'Pack B:  $18 * ' + CAST(@cnt AS VARCHAR(10)) + ' = ' + CAST(@Amount AS VARCHAR(10))

SELECT @cnt = COUNT(*) FROM Payment WHERE CompanyID = 17 AND Status = 3 AND (Purpose LIKE '105%' OR Purpose LIKE '205%') AND PaidDate >= @StartDate AND PaidDate < @EndDate 
SET @Amount = 40 * @cnt
SET @COGS = @COGS + @Amount
PRINT 'Pack C:  $40 * ' + CAST(@cnt AS VARCHAR(10)) + ' = ' + CAST(@Amount AS VARCHAR(10))

SELECT @cnt = COUNT(*) FROM Payment WHERE CompanyID = 17 AND Status = 3 AND (Purpose LIKE '106%' OR Purpose LIKE '206%') AND PaidDate >= @StartDate AND PaidDate < @EndDate 
SET @Amount = 83 * @cnt
SET @COGS = @COGS + @Amount
PRINT 'Pack D:  $83 * ' + CAST(@cnt AS VARCHAR(10)) + ' = ' + CAST(@Amount AS VARCHAR(10))

SELECT @cnt = COUNT(*) FROM Payment WHERE CompanyID = 17 AND Status = 3 AND (Purpose LIKE '107%' OR Purpose LIKE '207%') AND PaidDate >= @StartDate AND PaidDate < @EndDate 
SET @Amount = 140 * @cnt
SET @COGS = @COGS + @Amount
PRINT 'Pack E: $140 * ' + CAST(@cnt AS VARCHAR(10)) + ' = ' + CAST(@Amount AS VARCHAR(10))

SELECT @cnt = COUNT(*) FROM Payment WHERE CompanyID = 17 AND Status = 3 AND (Purpose LIKE '108%' OR Purpose LIKE '208%') AND PaidDate >= @StartDate AND PaidDate < @EndDate 
SET @Amount = 378 * @cnt
SET @COGS = @COGS + @Amount
PRINT 'Pack F: $378 * ' + CAST(@cnt AS VARCHAR(10)) + ' = ' + CAST(@Amount AS VARCHAR(10))

PRINT '------------------------'
PRINT 'Total Amount: ' + CAST(@COGS AS VARCHAR(10))

IF @StartDate = '7/1/14 00:00:00'
BEGIN
PRINT ''
	SELECT @cnt = COUNT(*) FROM Payment WHERE CompanyID = 17 AND Status = 3 AND Purpose LIKE '%105%' AND PaidDate = 0
	SET @Amount = 40 * @cnt
	SET @COGS = @COGS + @Amount
	PRINT 'Comp Pack C: $40 * ' + CAST(@cnt AS VARCHAR(10)) + ' = ' + CAST(@Amount AS VARCHAR(10))
	SELECT @cnt = COUNT(*) FROM Payment WHERE CompanyID = 17 AND Status = 3 AND Purpose LIKE '107%' AND PaidDate = 0
	SET @Amount = 140 * @cnt
	SET @COGS = @COGS + @Amount
	PRINT 'Comp Pack E: $140 * ' + CAST(@cnt AS VARCHAR(10)) + ' = ' + CAST(@Amount AS VARCHAR(10))
	PRINT '------------------------'
	PRINT 'Total Amount: ' + CAST(@COGS AS VARCHAR(10))
END 

PRINT ''

PRINT 'Pack A Orders'
PRINT '------------------------'
DECLARE Payment_cursor CURSOR LOCAL STATIC FOR 
SELECT OwnerID, PaidDate, Notes FROM Payment WHERE CompanyID = 17 AND Status = 3 AND (Purpose LIKE '103%' OR Purpose LIKE '203%') AND PaidDate >= @StartDate AND PaidDate < @EndDate ORDER BY PaidDate 
OPEN Payment_cursor
FETCH NEXT FROM Payment_cursor INTO @MemberID, @OrderDate, @Notes 
WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT '#' + CAST(@MemberID AS VARCHAR(10)) + ' - ' + dbo.wtfn_DateOnlyStr(@OrderDate) + ' - ' + @Notes
	FETCH NEXT FROM Payment_cursor INTO @MemberID, @OrderDate, @Notes 
END
CLOSE Payment_cursor
DEALLOCATE Payment_cursor
PRINT ''

PRINT 'Pack B Orders'
PRINT '------------------------'
DECLARE Payment_cursor CURSOR LOCAL STATIC FOR 
SELECT OwnerID, PaidDate, Notes FROM Payment WHERE CompanyID = 17 AND Status = 3 AND (Purpose LIKE '104%' OR Purpose LIKE '204%') AND PaidDate >= @StartDate AND PaidDate < @EndDate ORDER BY PaidDate 
OPEN Payment_cursor
FETCH NEXT FROM Payment_cursor INTO @MemberID, @OrderDate, @Notes 
WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT '#' + CAST(@MemberID AS VARCHAR(10)) + ' - ' + dbo.wtfn_DateOnlyStr(@OrderDate) + ' - ' + @Notes
	FETCH NEXT FROM Payment_cursor INTO @MemberID, @OrderDate, @Notes 
END
CLOSE Payment_cursor
DEALLOCATE Payment_cursor
PRINT ''

PRINT 'Pack C Orders '
PRINT '------------------------'
DECLARE Payment_cursor CURSOR LOCAL STATIC FOR 
SELECT OwnerID, PaidDate, Notes FROM Payment WHERE CompanyID = 17 AND Status = 3 AND (Purpose LIKE '105%' OR Purpose LIKE '205%') AND PaidDate >= @StartDate AND PaidDate < @EndDate ORDER BY PaidDate 
OPEN Payment_cursor
FETCH NEXT FROM Payment_cursor INTO @MemberID, @OrderDate, @Notes 
WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT '#' + CAST(@MemberID AS VARCHAR(10)) + ' - ' + dbo.wtfn_DateOnlyStr(@OrderDate) + ' - ' + @Notes
	FETCH NEXT FROM Payment_cursor INTO @MemberID, @OrderDate, @Notes 
END
CLOSE Payment_cursor
DEALLOCATE Payment_cursor
PRINT ''

PRINT 'Pack D Orders'
PRINT '------------------------'
DECLARE Payment_cursor CURSOR LOCAL STATIC FOR 
SELECT OwnerID, PaidDate, Notes FROM Payment WHERE CompanyID = 17 AND Status = 3 AND (Purpose LIKE '106%' OR Purpose LIKE '206%') AND PaidDate >= @StartDate AND PaidDate < @EndDate ORDER BY PaidDate 
OPEN Payment_cursor
FETCH NEXT FROM Payment_cursor INTO @MemberID, @OrderDate, @Notes 
WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT '#' + CAST(@MemberID AS VARCHAR(10)) + ' - ' + dbo.wtfn_DateOnlyStr(@OrderDate) + ' - ' + @Notes
	FETCH NEXT FROM Payment_cursor INTO @MemberID, @OrderDate, @Notes 
END
CLOSE Payment_cursor
DEALLOCATE Payment_cursor
PRINT ''

PRINT 'Pack E Orders'
PRINT '------------------------'
DECLARE Payment_cursor CURSOR LOCAL STATIC FOR 
SELECT OwnerID, PaidDate, Notes FROM Payment WHERE CompanyID = 17 AND Status = 3 AND (Purpose LIKE '107%' OR Purpose LIKE '207%') AND PaidDate >= @StartDate AND PaidDate < @EndDate ORDER BY PaidDate 
OPEN Payment_cursor
FETCH NEXT FROM Payment_cursor INTO @MemberID, @OrderDate, @Notes 
WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT '#' + CAST(@MemberID AS VARCHAR(10)) + ' - ' + dbo.wtfn_DateOnlyStr(@OrderDate) + ' - ' + @Notes
	FETCH NEXT FROM Payment_cursor INTO @MemberID, @OrderDate, @Notes 
END
CLOSE Payment_cursor
DEALLOCATE Payment_cursor
PRINT ''

PRINT 'Pack F Orders'
PRINT '------------------------'
DECLARE Payment_cursor CURSOR LOCAL STATIC FOR 
SELECT OwnerID, PaidDate, Notes FROM Payment WHERE CompanyID = 17 AND Status = 3 AND (Purpose LIKE '108%' OR Purpose LIKE '208%') AND PaidDate >= @StartDate AND PaidDate < @EndDate ORDER BY PaidDate 
OPEN Payment_cursor
FETCH NEXT FROM Payment_cursor INTO @MemberID, @OrderDate, @Notes 
WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT '#' + CAST(@MemberID AS VARCHAR(10)) + ' - ' + dbo.wtfn_DateOnlyStr(@OrderDate) + ' - ' + @Notes
	FETCH NEXT FROM Payment_cursor INTO @MemberID, @OrderDate, @Notes 
END
CLOSE Payment_cursor
DEALLOCATE Payment_cursor
PRINT ''


IF @StartDate = '7/1/14 00:00:00'
BEGIN
PRINT ''
	PRINT 'Comped Pack C Orders '
	PRINT '------------------------'
	DECLARE Payment_cursor CURSOR LOCAL STATIC FOR 
	SELECT OwnerID, PaidDate, Notes FROM Payment WHERE CompanyID = 17 AND Status = 3 AND Purpose LIKE '%105%' AND PaidDate = 0
	OPEN Payment_cursor
	FETCH NEXT FROM Payment_cursor INTO @MemberID, @OrderDate, @Notes 
	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT '#' + CAST(@MemberID AS VARCHAR(10)) + ' - ' + @Notes
		FETCH NEXT FROM Payment_cursor INTO @MemberID, @OrderDate, @Notes 
	END
	CLOSE Payment_cursor
	DEALLOCATE Payment_cursor
	PRINT ''

	PRINT 'Comped Pack E Orders'
	PRINT '------------------------'
	DECLARE Payment_cursor CURSOR LOCAL STATIC FOR 
	SELECT OwnerID, PaidDate, Notes FROM Payment WHERE CompanyID = 17 AND Status = 3 AND Purpose LIKE '107%' AND PaidDate = 0
	OPEN Payment_cursor
	FETCH NEXT FROM Payment_cursor INTO @MemberID, @OrderDate, @Notes 
	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT '#' + CAST(@MemberID AS VARCHAR(10)) + ' - ' + @Notes
		FETCH NEXT FROM Payment_cursor INTO @MemberID, @OrderDate, @Notes 
	END
	CLOSE Payment_cursor
	DEALLOCATE Payment_cursor
	PRINT ''
END

