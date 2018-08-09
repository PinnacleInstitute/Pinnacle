-- ****************************************************
-- BONUS RUN STATISTICS (Set Processing Dates Below)
-- ****************************************************
DECLARE @CommDate datetime, @PayDate datetime, @PaidAheadDate datetime, @Count int, @Sales money, @Bonuses money, @MemberID int, @Name varchar(100), @Amount money, @MinPay money
-- Set the date that commissions were created
-- Set @CommDate = 0 for all transactions 
--SET @CommDate = 0
--SET @CommDate = '5/9/12'
SET @CommDate = '10/8/12'
--SET @CommDate = '10/1/12'
SET @MinPay = 20

print '*******************************'
print 'BONUS RUN STATS for ' + CONVERT(varchar(20),@CommDate,1)
print '*******************************'
print ''
-- Set the date that payouts were created
SET @PayDate = @CommDate
SET @PaidAheadDate = DATEADD(m,1,@PayDate)

select @Count = COUNT(*), @Sales = SUM(total) from Payment 
where (@CommDate = 0 OR dbo.wtfn_DateOnly(CommDate) = @CommDate) AND Status = 3
print 'Total Payments Processed: ' + CAST(@Count AS VARCHAR(10))
print 'Total Payments Amount: ' + CAST(@Sales AS VARCHAR(10))
print ''

--total payouts
select @Count = COUNT(*), @Bonuses = SUM(Amount) from Payout WHERE ( @PayDate = 0 OR PayDate = @PayDate )
print 'Total Checks Earned: ' + CAST(@Count AS VARCHAR(10))
print 'Total Bonuses Earned: ' + CAST(@Bonuses AS VARCHAR(10))
print 'Company Bonus Net: ' + CAST(@Sales - @Bonuses AS VARCHAR(10))
print 'Percent Bonuses Earned: ' + CAST(@Bonuses/@Sales AS VARCHAR(10))
print ''

--list bonus checks
print 'Bonus Checks'
print '-------------------------'
DECLARE Member_cursor CURSOR FOR 
select me.MemberID, me.namefirst + ' ' + me.NameLast, SUM(pa.amount) 
from Payout as pa join member as me on pa.ownerid=me.memberid 
where ( @PayDate = 0 OR pa.PayDate = @PayDate )
GROUP BY me.MemberID, me.namefirst, me.NameLast, me.PaidDate
having SUM(pa.Amount) <> 0 
AND SUM(pa.Amount) >= @MinPay
-- OR (SUM(pa.Amount) < @MinPay AND me.PaidDate > @PaidAheadDate))
order by SUM(pa.Amount) desc

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @Name, @Amount
WHILE @@FETCH_STATUS = 0
BEGIN
	print CAST(@Amount AS VARCHAR(10)) + ' ' + @Name + '(#' + CAST(@MemberID AS VARCHAR(10)) + ')'
	FETCH NEXT FROM Member_cursor INTO @MemberID, @Name, @Amount
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

