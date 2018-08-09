-- ***************************
-- Affiliate Recruiting Stats
-- ***************************
DECLARE @FromDate datetime, @ToDate datetime
SET @FromDate = '5/1/12' 
SET @ToDate = '8/1/12' 
print '***************************'
print 'Support Stats '
print 'from ' + CONVERT(varchar(20), @FromDate, 1) + ' to ' + CONVERT(varchar(20), @toDate, 1)
print '***************************'
print ''
DECLARE @SupportTotal int, @ResellerSupport int, @AffiliateSupport int, @CustomerSupport int

select @SupportTotal = COUNT(*) from Note AS nt
join Member as me on nt.OwnerType = 4 AND nt.OwnerID = me.MemberID
where nt.NoteDate > @FromDate and nt.NoteDate <= @ToDate
and nt.AuthUserID <> 1

select @ResellerSupport = COUNT(*) from Note AS nt
join Member as me on nt.OwnerType = 4 AND nt.OwnerID = me.MemberID
where nt.NoteDate > @FromDate and nt.NoteDate <= @ToDate and me.Title = 1 and me.Level = 1
and nt.AuthUserID <> 1

select @AffiliateSupport = COUNT(*) from Note AS nt
join Member as me on nt.OwnerType = 4 AND nt.OwnerID = me.MemberID
where nt.NoteDate > @FromDate and nt.NoteDate <= @ToDate and me.Title > 1 and me.Level = 1
and nt.AuthUserID <> 1

select @CustomerSupport = COUNT(*) from Note AS nt
join Member as me on nt.OwnerType = 4 AND nt.OwnerID = me.MemberID
where nt.NoteDate > @FromDate and nt.NoteDate <= @ToDate and me.Title = 0 and me.Level = 0
and nt.AuthUserID <> 1

print 'Total Support Notes'
print '-----------------------'
print 'Total Support Notes: ' + CAST(@SupportTotal as varchar(10))
print 'Total Reseller Support: ' + CAST(@ResellerSupport as varchar(10))
print 'Reseller Support Rate: ' + CAST(@ResellerSupport/CAST(@SupportTotal AS money) as varchar(10))
print 'Total Affiliate Support: ' + CAST(@AffiliateSupport as varchar(10))
print 'Reseller Support Rate: ' + CAST(@AffiliateSupport/CAST(@SupportTotal AS money) as varchar(10))
print 'Total Customer Support: ' + CAST(@CustomerSupport as varchar(10))
print 'Customer Support Rate: ' + CAST(@CustomerSupport/CAST(@SupportTotal AS money) as varchar(10))
print ''

