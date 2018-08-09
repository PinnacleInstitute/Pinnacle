DECLARE @FromDate datetime, @ToDate datetime
DECLARE @Total money, @Reseller money, @Affiliate money, @Customer money
SET @FromDate = '7/1/12'
SET @ToDate = '8/1/12'
print '***************************'
print 'Payment Stats '
print 'from ' + CONVERT(varchar(20), @FromDate, 1) + ' to ' + CONVERT(varchar(20), @toDate, 1)
print '***************************'
print ''

select @Total = SUM(Amount) from Payment as pa
join Member as me on pa.OwnerID = me.MemberID
join Member as re on me.ReferralID = re.MemberID
where pa.PayDate >= @FromDate AND pa.PayDate <= @ToDate

select @Customer = SUM(Amount) from Payment as pa
join Member as me on pa.OwnerID = me.MemberID
where pa.PayDate >= @FromDate AND pa.PayDate <= @ToDate
and me.Title = 0

select @Reseller = SUM(Amount) from Payment as pa
join Member as me on pa.OwnerID = me.MemberID
where pa.PayDate >= @FromDate AND pa.PayDate <= @ToDate
and me.Title = 1

select @Affiliate = SUM(Amount) from Payment as pa
join Member as me on pa.OwnerID = me.MemberID
where pa.PayDate >= @FromDate AND pa.PayDate <= @ToDate
and me.Title > 1

print 'Total Payments'
print '-----------------------'
print 'Total Payments: ' + CAST(@Total as varchar(10))
print 'Total Customer Payments: ' + CAST(@Customer as varchar(10))
print 'Customer Payment Rate: ' + CAST(@Customer/CAST(@Total AS money) as varchar(10))
print 'Total Reseller Payments: ' + CAST(@Reseller as varchar(10))
print 'Reseller Payment Rate: ' + CAST(@Reseller/CAST(@Total AS money) as varchar(10))
print 'Total Affiliate Payments: ' + CAST(@Affiliate as varchar(10))
print 'Affiliate Payment Rate: ' + CAST(@Affiliate/CAST(@Total AS money) as varchar(10))
print ''

select @Total = SUM(Amount) from Payment as pa
join Member as me on pa.OwnerID = me.MemberID
join Member as re on me.ReferralID = re.MemberID
where pa.PayDate >= @FromDate AND pa.PayDate <= @ToDate
and pa.Status = 3

select @Customer = SUM(Amount) from Payment as pa
join Member as me on pa.OwnerID = me.MemberID
where pa.PayDate >= @FromDate AND pa.PayDate <= @ToDate
and pa.Status = 3 and me.Title = 0

select @Reseller = SUM(Amount) from Payment as pa
join Member as me on pa.OwnerID = me.MemberID
where pa.PayDate >= @FromDate AND pa.PayDate <= @ToDate
and pa.Status = 3 and me.Title = 1

select @Affiliate = SUM(Amount) from Payment as pa
join Member as me on pa.OwnerID = me.MemberID
where pa.PayDate >= @FromDate AND pa.PayDate <= @ToDate
and pa.Status = 3 and me.Title > 1

print 'Total Good Payments'
print '-----------------------'
print 'Total Payments: ' + CAST(@Total as varchar(10))
print 'Total Customer Payments: ' + CAST(@Customer as varchar(10))
print 'Customer Payment Rate: ' + CAST(@Customer/CAST(@Total AS money) as varchar(10))
print 'Total Reseller Payments: ' + CAST(@Reseller as varchar(10))
print 'Reseller Payment Rate: ' + CAST(@Reseller/CAST(@Total AS money) as varchar(10))
print 'Total Affiliate Payments: ' + CAST(@Affiliate as varchar(10))
print 'Affiliate Payment Rate: ' + CAST(@Affiliate/CAST(@Total AS money) as varchar(10))
print ''

select @Total = SUM(Amount) from Payment as pa
join Member as me on pa.OwnerID = me.MemberID
where pa.PayDate >= @FromDate AND pa.PayDate <= @ToDate
and pa.Status > 3

select @Customer = SUM(Amount) from Payment as pa
join Member as me on pa.OwnerID = me.MemberID
where pa.PayDate >= @FromDate AND pa.PayDate <= @ToDate
and pa.Status > 3 and me.Title = 0

select @Reseller = SUM(Amount) from Payment as pa
join Member as me on pa.OwnerID = me.MemberID
where pa.PayDate >= @FromDate AND pa.PayDate <= @ToDate
and pa.Status > 3 and me.Title = 1

select @Affiliate = SUM(Amount) from Payment as pa
join Member as me on pa.OwnerID = me.MemberID
where pa.PayDate >= @FromDate AND pa.PayDate <= @ToDate
and pa.Status > 3 and me.Title > 1

print 'Total Bad Payments'
print '-----------------------'
print 'Total Payments: ' + CAST(@Total as varchar(10))
print 'Total Customer Payments: ' + CAST(@Customer as varchar(10))
print 'Customer Payment Rate: ' + CAST(@Customer/CAST(@Total AS money) as varchar(10))
print 'Total Reseller Payments: ' + CAST(@Reseller as varchar(10))
print 'Reseller Payment Rate: ' + CAST(@Reseller/CAST(@Total AS money) as varchar(10))
print 'Total Affiliate Payments: ' + CAST(@Affiliate as varchar(10))
print 'Affiliate Payment Rate: ' + CAST(@Affiliate/CAST(@Total AS money) as varchar(10))
print ''
