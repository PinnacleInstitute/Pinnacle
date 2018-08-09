--Unpaid Bonuses

DECLARE @Payout money, @Bonus money
select @Payout = SUM(Amount) from Payout where CompanyID = 17 and Status = 1
select @Bonus = SUM(Amount) from Commission where CompanyID = 17 and Status = 1

PRINT 'Unpaid Payouts: ' + CAST(@Payout AS VARCHAR(10))
PRINT 'Unpaid Bonuses: ' + CAST(@Bonus AS VARCHAR(10))
PRINT 'Unpaid Total: ' + CAST(@Payout + @Bonus AS VARCHAR(10))
