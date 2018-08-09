DECLARE @CompanyID int, @cnt int, @new int, @Now datetime, @FromDate datetime, @ToDate datetime, @amt money, @Price money
SET @CompanyID = 6
SET @FromDate = '6/1/11'
SET @ToDate = '6/8/11'
SET @Price = 30
SET @Now = GETDATE()

PRINT 'Financial Statistics for Company ' + CAST(@CompanyID AS VARCHAR(10)) + ' on ' + CAST(@Now AS VARCHAR(30))

SELECT @cnt = COUNT(*) FROM Member WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND DATEADD(day, TrialDays, EnrollDate) < @ToDate
PRINT CAST(@cnt AS VARCHAR(10)) + ' Members Active' 
SELECT @cnt = COUNT(*) FROM Member WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND DATEADD(day, TrialDays, EnrollDate) < @ToDate AND Billing = 3
PRINT CAST(@cnt AS VARCHAR(10)) + ' Members Billed' 
SELECT @cnt = COUNT(*) FROM Payment AS pa JOIN Member AS me on pa.OwnerID = me.MemberID
WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 4
AND pa.Status = 3 AND pa.PayDate >= @FromDate AND pa.PayDate < @ToDate
PRINT CAST(@cnt AS VARCHAR(10)) + ' Members Paid' 
PRINT '------------------------'

SELECT @new = COUNT(*) FROM Payment AS pa JOIN Member AS me on pa.OwnerID = me.MemberID
WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 4
AND pa.Status = 3 AND pa.PaidDate >= @FromDate AND pa.PaidDate < @ToDate AND pa.PayType < 90 AND pa.Amount > @Price
PRINT CAST(@new AS VARCHAR(10)) + ' Billing New Members' 
SELECT @cnt = COUNT(*) FROM Payment AS pa JOIN Member AS me on pa.OwnerID = me.MemberID
WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 4
AND pa.Status = 3 AND pa.PaidDate >= @FromDate AND pa.PaidDate < @ToDate AND pa.PayType < 90
PRINT CAST(@cnt-@new AS VARCHAR(10)) + ' Billing Existing Members' 
PRINT CAST(@cnt AS VARCHAR(10)) + ' Billing Total Members' 
SELECT @amt = SUM(Amount) FROM Payment AS pa JOIN Member AS me on pa.OwnerID = me.MemberID
WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 4
AND pa.Status = 3 AND pa.PaidDate >= @FromDate AND pa.PaidDate < @ToDate AND pa.PayType < 90
PRINT CAST(@amt AS VARCHAR(15)) + ' Billing Amount' 
PRINT '------------------------'

SELECT @cnt = COUNT(*), @amt = SUM(Amount) FROM (
	SELECT OwnerID 'OwnerID', SUM(Amount)'Amount' FROM Commission
	WHERE CompanyID = @CompanyID AND OwnerType = 4 AND CommDate >= @FromDate AND CommDate < @ToDate  
	GROUP BY OwnerID
) AS po
PRINT CAST(@cnt AS VARCHAR(10)) + ' Bonuses Earned' 
PRINT CAST(@amt AS VARCHAR(15)) + ' Bonuses Earned $' 

SELECT @cnt = COUNT(*), @amt = ABS(SUM(Amount)) FROM Payout
WHERE CompanyID = @CompanyID AND Amount < 0 AND PayDate >= @FromDate AND PayDate < @ToDate  
PRINT CAST(@cnt AS VARCHAR(10)) + ' Payment Credits' 
PRINT CAST(@amt AS VARCHAR(15)) + ' Payment Credits $' 

SELECT @cnt = COUNT(*), @amt = SUM(Amount) FROM (
	SELECT OwnerID 'OwnerID', SUM(Amount)'Amount' FROM Payout
	WHERE CompanyID = @CompanyID AND OwnerType = 4 AND Status = 2 AND PayType < 4
	AND PaidDate >= @FromDate AND PaidDate < @ToDate  
	GROUP BY OwnerID
) AS po
PRINT CAST(@cnt AS VARCHAR(10)) + ' Bonuses Paid' 
PRINT CAST(@amt AS VARCHAR(15)) + ' Bonuses Paid $' 

