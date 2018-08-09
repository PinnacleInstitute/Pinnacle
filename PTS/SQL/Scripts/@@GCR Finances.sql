-- **************************************************
-- Calculate GCR Finances for the time period
-- **************************************************
DECLARE @StartDate datetime, @EndDate datetime, @NextDate datetime, @Revenue money, @Amount money, @COGS money,  @Comp money, @cnt int
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
--SET @StartDate = '4/13/15 00:00:00'
--SET @EndDate = '4/20/15 00:00:00'
--SET @StartDate = '4/20/15 00:00:00'
--SET @EndDate = '4/27/15 00:00:00'
--SET @StartDate = '4/27/15 00:00:00'
--SET @EndDate = '5/4/15 00:00:00'
--SET @StartDate = '5/4/15 00:00:00'
--SET @EndDate = '5/11/15 00:00:00'
--SET @StartDate = '5/11/15 00:00:00'
--SET @EndDate = '5/18/15 00:00:00'
--SET @StartDate = '5/18/15 00:00:00'
--SET @EndDate = '5/25/15 00:00:00'
--SET @StartDate = '5/26/15 00:00:00'
--SET @EndDate = '6/1/15 00:00:00'
--SET @StartDate = '6/1/15 00:00:00'
--SET @EndDate = '6/8/15 00:00:00'
--SET @StartDate = '6/8/15 00:00:00'
--SET @EndDate = '6/15/15 00:00:00'
--SET @StartDate = '6/15/15 00:00:00'
--SET @EndDate = '6/22/15 00:00:00'
--SET @StartDate = '6/22/15 00:00:00'
--SET @EndDate = '6/29/15 00:00:00'
--SET @StartDate = '6/29/15 00:00:00'
--SET @EndDate = '7/6/15 00:00:00'
--SET @StartDate = '7/6/15 00:00:00'
--SET @EndDate = '7/13/15 00:00:00'
--SET @StartDate = '7/13/15 00:00:00'
--SET @EndDate = '7/20/15 00:00:00'
--SET @StartDate = '7/20/15 00:00:00'
--SET @EndDate = '7/27/15 00:00:00'
--SET @StartDate = '7/27/15 00:00:00'
--SET @EndDate = '8/3/15 00:00:00'
--SET @StartDate = '8/3/15 00:00:00'
--SET @EndDate = '8/10/15 00:00:00'
--SET @StartDate = '8/10/15 00:00:00'
--SET @EndDate = '8/17/15 00:00:00'
--SET @StartDate = '8/17/15 00:00:00'
--SET @EndDate = '8/24/15 00:00:00'
--SET @StartDate = '8/24/15 00:00:00'
--SET @EndDate = '8/31/15 00:00:00'
--SET @StartDate = '8/31/15 00:00:00'
--SET @EndDate = '9/7/15 00:00:00'
--SET @StartDate = '9/7/15 00:00:00'
--SET @EndDate = '9/14/15 00:00:00'
--SET @StartDate = '9/14/15 00:00:00'
--SET @EndDate = '9/21/15 00:00:00'
--SET @StartDate = '9/21/15 00:00:00'
--SET @EndDate = '9/28/15 00:00:00'
--SET @StartDate = '9/28/15 00:00:00'
--SET @EndDate = '10/5/15 00:00:00'
--SET @StartDate = '10/5/15 00:00:00'
--SET @EndDate = '10/12/15 00:00:00'
--SET @StartDate = '10/12/15 00:00:00'
--SET @EndDate = '10/19/15 00:00:00'
--SET @StartDate = '10/19/15 00:00:00'
--SET @EndDate = '10/26/15 00:00:00'
SET @StartDate = '10/26/15 00:00:00'
SET @EndDate = '11/2/15 00:00:00'

--SET @NextDate = DATEADD(d,1,@EndDate)
SET @NextDate = @EndDate
--select ((8582.87 + 5306.61) /3) + 2128.92

PRINT 'GCR Finances:  ' + CAST(@StartDate AS varchar(20)) + ' up to ' + CAST(@EndDate AS varchar(20))
PRINT '------------------'
SELECT @Amount = SUM(Amount) FROM Payment WHERE companyid = 17 AND Reference NOT LIKE '%Finland%' AND Reference NOT LIKE '%Anthony%' AND Reference NOT LIKE '%ITCU%' AND Reference NOT LIKE '%Comp%' AND PaidDate >= @StartDate AND PaidDate < @EndDate AND Status = 3 AND PayType = 14 
PRINT 'Coinbase: ' + CAST(ISNULL(@Amount,0) AS VARCHAR(10))
SELECT @Amount = SUM(Amount) FROM Payment WHERE companyid = 17 AND Reference NOT LIKE '%Finland%' AND Reference NOT LIKE '%Anthony%' AND Reference NOT LIKE '%ITCU%' AND Reference NOT LIKE '%Comp%' AND PaidDate >= @StartDate AND PaidDate < @EndDate AND Status = 3 AND PayType = 13
PRINT 'SolidTP:  ' + CAST(ISNULL(@Amount,0) AS VARCHAR(10))
SELECT @Amount = SUM(Amount) FROM Payment WHERE companyid = 17 AND Reference NOT LIKE '%Finland%' AND Reference NOT LIKE '%Anthony%' AND Reference NOT LIKE '%ITCU%' AND Reference NOT LIKE '%Comp%' AND PaidDate >= @StartDate AND PaidDate < @EndDate AND Status = 3 AND PayType NOT IN (13,14,91)
PRINT 'Wallet:   ' + CAST(ISNULL(@Amount,0) AS VARCHAR(10))
SELECT @Amount = SUM(Amount) FROM Payment WHERE companyid = 17 AND Reference LIKE '%ITCU%' AND PaidDate >= @StartDate AND PaidDate < @EndDate AND Status = 3
PRINT 'InTouch:  ' + CAST(ISNULL(@Amount,0) AS VARCHAR(10))
SELECT @Amount = ISNULL(SUM(Amount),0) FROM Payment WHERE companyid = 17 AND Reference LIKE '%Finland%' AND PaidDate >= @StartDate AND PaidDate < @EndDate AND Status = 3
PRINT 'Finland:  ' + CAST(ISNULL(@Amount,0) AS VARCHAR(10))
SELECT @Amount = ISNULL(SUM(Amount),0) FROM Payment WHERE companyid = 17 AND Reference LIKE '%Anthony%' AND PaidDate >= @StartDate AND PaidDate < @EndDate AND Status = 3
PRINT 'Anthony:  ' + CAST(ISNULL(@Amount,0) AS VARCHAR(10))
SELECT @Amount = SUM(Amount) FROM Payment WHERE companyid = 17 AND PaidDate >= @StartDate AND PaidDate < @EndDate AND PayType IN (91) AND Status = 3
PRINT 'Credit:   ' + CAST(ISNULL(@Amount,0) AS VARCHAR(10))
SELECT @Amount = SUM(Amount) FROM Payment WHERE companyid = 17 AND PaidDate >= @StartDate AND PaidDate < @EndDate AND Reference LIKE '%Comp%' AND Status = 3
PRINT 'Comp:     ' + CAST(ISNULL(@Amount,0) AS VARCHAR(10))
SELECT @Amount = SUM(Amount) FROM Payment WHERE companyid = 17 AND PaidDate >= @StartDate AND PaidDate < @EndDate AND Reference LIKE '%Comp%' AND Status = 3 AND CommStatus = 2
PRINT 'Comp Err: ' + CAST(ISNULL(@Amount,0) AS VARCHAR(10))
SELECT @Revenue = SUM(Amount) FROM Payment WHERE companyid = 17 AND PaidDate >= @StartDate AND PaidDate < @EndDate AND PayType NOT IN (91) AND Reference NOT LIKE '%Comp%' AND Status = 3
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
SELECT @Amount = SUM(Amount) FROM Commission WHERE ownerid = 12552 AND CommDate >= @StartDate AND CommDate < @NextDate
PRINT 'LINDA: ' + CAST(@Amount AS VARCHAR(10))
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

SELECT @cnt = COUNT(*) FROM Payment WHERE CompanyID = 17 AND Status = 3 AND (Purpose LIKE '108%' OR Purpose LIKE '208%') AND PaidDate >= @StartDate AND PaidDate < @EndDate 
SET @Amount = 378 * @cnt
SET @COGS = @COGS + @Amount
PRINT 'Pack F: ' + CAST(@cnt AS VARCHAR(10)) + ' - ' + CAST(@Amount AS VARCHAR(10))
PRINT '------------------'
PRINT 'COGS: ' + CAST(@COGS AS VARCHAR(10))


--Comped Payments
IF @Comp > 0 SELECT * FROM Payment WHERE companyid = 17 AND PaidDate >= @StartDate AND PaidDate < @EndDate AND Reference LIKE '%Comp%' AND Status = 3


