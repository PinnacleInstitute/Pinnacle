-- **************************************************
-- Calculate GCR Finances for the time period
-- **************************************************
DECLARE @StartDate datetime, @EndDate datetime, @NextDate datetime, @Revenue money, @Amount money, @COGS money, @cnt int
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
SET @StartDate = '9/26/14 00:00:00'
SET @EndDate = '10/3/14 00:00:00'

--SET @NextDate = DATEADD(d,1,@EndDate)
SET @NextDate = @EndDate

PRINT 'GCR Finances:  ' + CAST(@StartDate AS varchar(20)) + ' up to ' + CAST(@EndDate AS varchar(20))
PRINT '------------------'
SELECT @Amount = SUM(Amount) FROM Payment WHERE companyid = 17 AND Reference NOT LIKE '%Finland%' AND Reference NOT LIKE '%Anthony%' AND PaidDate >= @StartDate AND PaidDate < @EndDate AND PayType = 14 AND Status = 3
PRINT 'Coinbase: ' + CAST(ISNULL(@Amount,0) AS VARCHAR(10))
SELECT @Amount = SUM(Amount) FROM Payment WHERE companyid = 17 AND Reference NOT LIKE '%Finland%' AND Reference NOT LIKE '%Anthony%' AND PaidDate >= @StartDate AND PaidDate < @EndDate AND PayType != 14 AND Status = 3
PRINT 'SolidTP:  ' + CAST(ISNULL(@Amount,0) AS VARCHAR(10))
SELECT @Amount = SUM(Amount) FROM Payment WHERE companyid = 17 AND Reference LIKE '%Finland%' AND PaidDate >= @StartDate AND PaidDate < @EndDate
PRINT 'Finland:  ' + CAST(ISNULL(@Amount,0) AS VARCHAR(10))
SELECT @Amount = ISNULL(SUM(Amount),0) FROM Payment WHERE companyid = 17 AND Reference LIKE '%Anthony%' AND PaidDate >= @StartDate AND PaidDate < @EndDate
PRINT 'Anthony:  ' + CAST(ISNULL(@Amount,0) AS VARCHAR(10))
SELECT @Revenue = SUM(Amount) FROM Payment WHERE companyid = 17 AND PaidDate >= @StartDate AND PaidDate < @EndDate AND Status = 3
PRINT 'Revenue:  ' + CAST(@Revenue AS VARCHAR(10))
PRINT '------------------'
SELECT @Amount = SUM(Amount) FROM Commission WHERE companyid = 17 AND CommDate >= @StartDate AND CommDate < @NextDate
PRINT 'COS: ' + CAST(@Amount AS VARCHAR(10)) + '  (' + CAST((@Amount/@Revenue)*100 AS VARCHAR(10)) + '%)'
PRINT '------------------'
SELECT @Amount = SUM(Amount) FROM Commission WHERE companyid = 17 AND CommDate >= @StartDate AND CommDate < @NextDate
PRINT 'NET: ' + CAST(@Revenue - @Amount AS VARCHAR(10)) + '  (' + CAST(((@Revenue - @Amount)/@Revenue)*100 AS VARCHAR(10)) + '%)'
PRINT '------------------'
SELECT @Amount = SUM(Amount) FROM Commission WHERE ownerid = 12047 AND CommDate >= @StartDate AND CommDate < @NextDate
PRINT 'ROB: ' + CAST(@Amount AS VARCHAR(10))
PRINT '------------------'
SELECT @Amount = SUM(Amount) FROM Commission WHERE ownerid = 12045 AND CommDate >= @StartDate AND CommDate < @NextDate
PRINT 'TOP: ' + CAST(@Amount AS VARCHAR(10))
PRINT '------------------'
SELECT @Amount = SUM(Amount) FROM Commission WHERE ownerid = 12046 AND CommDate >= @StartDate AND CommDate < @NextDate
PRINT 'SYS: ' + CAST(@Amount AS VARCHAR(10))
PRINT '------------------'

SET @COGS = 0
SELECT @cnt = COUNT(*) FROM Payment WHERE CompanyID = 17 AND Status = 3 AND (Purpose LIKE '103%' OR Purpose LIKE '203%') AND PaidDate >= @StartDate AND PaidDate < @EndDate 
SET @Amount = 6 * @cnt
SET @COGS = @COGS + @Amount
PRINT 'Pack A: ' + CAST(@cnt AS VARCHAR(10)) + ' - ' + CAST(@Amount AS VARCHAR(10))

SELECT @cnt = COUNT(*) FROM Payment WHERE CompanyID = 17 AND Status = 3 AND (Purpose LIKE '104%' OR Purpose LIKE '204%') AND PaidDate >= @StartDate AND PaidDate < @EndDate 
SET @Amount = 18 * @cnt
SET @COGS = @COGS + @Amount
PRINT 'Pack B: ' + CAST(@cnt AS VARCHAR(10)) + ' - ' + CAST(@Amount AS VARCHAR(10))

SELECT @cnt = COUNT(*) FROM Payment WHERE CompanyID = 17 AND Status = 3 AND (Purpose LIKE '105%' OR Purpose LIKE '205%') AND PaidDate >= @StartDate AND PaidDate < @EndDate 
SET @Amount = 40 * @cnt
SET @COGS = @COGS + @Amount
PRINT 'Pack C: ' + CAST(@cnt AS VARCHAR(10)) + ' - ' + CAST(@Amount AS VARCHAR(10))

SELECT @cnt = COUNT(*) FROM Payment WHERE CompanyID = 17 AND Status = 3 AND (Purpose LIKE '106%' OR Purpose LIKE '206%') AND PaidDate >= @StartDate AND PaidDate < @EndDate 
SET @Amount = 83 * @cnt
SET @COGS = @COGS + @Amount
PRINT 'Pack D: ' + CAST(@cnt AS VARCHAR(10)) + ' - ' + CAST(@Amount AS VARCHAR(10))

SELECT @cnt = COUNT(*) FROM Payment WHERE CompanyID = 17 AND Status = 3 AND (Purpose LIKE '107%' OR Purpose LIKE '207%') AND PaidDate >= @StartDate AND PaidDate < @EndDate 
SET @Amount = 140 * @cnt
SET @COGS = @COGS + @Amount
PRINT 'Pack E: ' + CAST(@cnt AS VARCHAR(10)) + ' - ' + CAST(@Amount AS VARCHAR(10))
PRINT '------------------'
PRINT 'COGS: ' + CAST(@COGS AS VARCHAR(10))


