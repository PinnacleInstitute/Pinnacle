-- ***************************
-- Affiliate Recruiting Stats
-- ***************************
DECLARE @FromDate datetime, @ToDate datetime
SET @FromDate = '4/1/12' 
SET @ToDate = '8/1/12' 
print '***************************'
print 'Recruiting Stats '
print 'from ' + CONVERT(varchar(20), @FromDate, 1) + ' to ' + CONVERT(varchar(20), @toDate, 1)
print '***************************'
print ''
DECLARE @RecruitTotal int, @ResellerTotal int, @AffiliateTotal int
select @RecruitTotal = COUNT(*) from Member as me join Member as sp on me.ReferralID = sp.Memberid
where me.Status = 1 and me.Level = 1 AND me.EnrollDate >= @FromDate and me.EnrollDate <= @ToDate 
select @ResellerTotal = COUNT(*) from Member as me join Member as sp on me.ReferralID = sp.Memberid
where me.Status = 1 and me.Level = 1 and sp.Title <= 1 AND me.EnrollDate >= @FromDate and me.EnrollDate <= @ToDate 
select @AffiliateTotal = COUNT(*) from Member as me join Member as sp on me.ReferralID = sp.Memberid
where me.Status = 1 and me.Level = 1 and sp.Title > 1 AND me.EnrollDate >= @FromDate and me.EnrollDate <= @ToDate 
print 'Total Recruits enrolled'
print '-----------------------'
print 'Total Recruits: ' + CAST(@RecruitTotal as varchar(10))
print 'Total Reseller Recruits: ' + CAST(@ResellerTotal as varchar(10))
print 'Reseller Recruiting Rate: ' + CAST(@ResellerTotal/CAST(@RecruitTotal AS money) as varchar(10))
print 'Total Affiliate Recruits: ' + CAST(@AffiliateTotal as varchar(10))
print 'Reseller Recruiting Rate: ' + CAST(@AffiliateTotal/CAST(@RecruitTotal AS money) as varchar(10))
print ''
DECLARE @RecruitTotal2 int, @ResellerTotal2 int, @AffiliateTotal2 int
select @RecruitTotal2 = COUNT(*) from Member as me join Member as sp on me.ReferralID = sp.Memberid
where me.Status = 1 and me.Level = 1 AND sp.EnrollDate >= @FromDate and sp.EnrollDate <= @ToDate 
select @ResellerTotal2 = COUNT(*) from Member as me join Member as sp on me.ReferralID = sp.Memberid
where me.Status = 1 and me.Level = 1 and sp.Title <= 1 AND sp.EnrollDate >= @FromDate and sp.EnrollDate <= @ToDate 
select @AffiliateTotal2 = COUNT(*) from Member as me join Member as sp on me.ReferralID = sp.Memberid
where me.Status = 1 and me.Level = 1 and sp.Title > 1 AND sp.EnrollDate >= @FromDate and sp.EnrollDate <= @ToDate 
print 'Total Recruits by Resellers/Affiliates enrolled'
print '-----------------------------------------------'
print 'Total Recruits: ' + CAST(@RecruitTotal2 as varchar(10))
print 'Total Reseller Recruits: ' + CAST(@ResellerTotal2 as varchar(10))
print 'Reseller Recruiting Rate: ' + CAST(@ResellerTotal2/CAST(@RecruitTotal2 AS money) as varchar(10))
print 'Total Affiliate Recruits: ' + CAST(@AffiliateTotal2 as varchar(10))
print 'Affiliate Recruiting Rate: ' + CAST(@AffiliateTotal2/CAST(@RecruitTotal2 AS money) as varchar(10))
print ''

DECLARE @RecruitTotal3 int, @ResellerTotal3 int, @AffiliateTotal3 int
select @RecruitTotal3 = COUNT(*) from Member as me
where me.Level = 1 AND me.EnrollDate >= @FromDate and me.EnrollDate <= @ToDate
and (Select COUNT(*) from Member where ReferralID = me.MemberID) > 0 
select @ResellerTotal3 = COUNT(*) from Member as me
where me.Level = 1 and me.Title <= 1 AND me.EnrollDate >= @FromDate and me.EnrollDate <= @ToDate
and (Select COUNT(*) from Member where ReferralID = me.MemberID) > 0 
select @AffiliateTotal3 = COUNT(*) from Member as me
where me.Level = 1 and me.Title > 1 AND me.EnrollDate >= @FromDate and me.EnrollDate <= @ToDate
and (Select COUNT(*) from Member where ReferralID = me.MemberID) > 0 
print 'Total Resellers/Affiliates doing any recruiting'
print '-----------------------------------------------'
print 'Total Recruiting: ' + CAST(@RecruitTotal3 as varchar(10))
print 'Total Resellers Recruiting: ' + CAST(@ResellerTotal3 as varchar(10))
print 'Reseller Recruiting Rate: ' + CAST(@ResellerTotal3/CAST(@RecruitTotal3 AS money) as varchar(10))
print 'Total Affiliate Recruiting: ' + CAST(@AffiliateTotal3 as varchar(10))
print 'Affiliate Recruiting Rate: ' + CAST(@AffiliateTotal3/CAST(@RecruitTotal3 AS money) as varchar(10))
print ''

DECLARE @RecruitTotal4 int, @ResellerTotal4 int, @AffiliateTotal4 int
select @RecruitTotal4 = COUNT(*) from Member as me
where me.Level = 1 AND me.EnrollDate >= @FromDate and me.EnrollDate <= @ToDate
and (Select COUNT(*) from Member where ReferralID = me.MemberID and BV < 40) > 0 
select @ResellerTotal4 = COUNT(*) from Member as me
where me.Level = 1 and me.Title <= 1 AND me.EnrollDate >= @FromDate and me.EnrollDate <= @ToDate
and (Select COUNT(*) from Member where ReferralID = me.MemberID and BV < 40) > 0 
select @AffiliateTotal4 = COUNT(*) from Member as me
where me.Level = 1 and me.Title > 1 AND me.EnrollDate >= @FromDate and me.EnrollDate <= @ToDate
and (Select COUNT(*) from Member where ReferralID = me.MemberID and BV < 40) > 0 
print 'Total Resellers/Affiliates doing any recruiting of Resellers'
print '-------------------------------------------------------------------'
print 'Total Recruiting: ' + CAST(@RecruitTotal4 as varchar(10))
print 'Total Resellers Recruiting: ' + CAST(@ResellerTotal4 as varchar(10))
print 'Reseller Recruiting Rate: ' + CAST(@ResellerTotal4/CAST(@RecruitTotal4 AS money) as varchar(10))
print 'Total Affiliate Recruiting: ' + CAST(@AffiliateTotal4 as varchar(10))
print 'Affiliate Recruiting Rate: ' + CAST(@AffiliateTotal4/CAST(@RecruitTotal4 AS money) as varchar(10))
print ''

DECLARE @RecruitTotal5 int, @ResellerTotal5 int, @AffiliateTotal5 int
select @RecruitTotal5 = COUNT(*) from Member as me
where me.Level = 1 AND me.EnrollDate >= @FromDate and me.EnrollDate <= @ToDate
and (Select COUNT(*) from Member where ReferralID = me.MemberID and BV >= 40) > 0 
select @ResellerTotal5 = COUNT(*) from Member as me
where me.Level = 1 and me.Title <= 1 AND me.EnrollDate >= @FromDate and me.EnrollDate <= @ToDate
and (Select COUNT(*) from Member where ReferralID = me.MemberID and BV >= 40) > 0 
select @AffiliateTotal5 = COUNT(*) from Member as me
where me.Level = 1 and me.Title > 1 AND me.EnrollDate >= @FromDate and me.EnrollDate <= @ToDate
and (Select COUNT(*) from Member where ReferralID = me.MemberID and BV >= 40) > 0 
print 'Total Resellers/Affiliates doing any recruiting of Affiliates ($40)'
print '-------------------------------------------------------------------'
print 'Total Recruiting: ' + CAST(@RecruitTotal5 as varchar(10))
print 'Total Resellers Recruiting: ' + CAST(@ResellerTotal5 as varchar(10))
print 'Reseller Recruiting Rate: ' + CAST(@ResellerTotal5/CAST(@RecruitTotal5 AS money) as varchar(10))
print 'Total Affiliate Recruiting: ' + CAST(@AffiliateTotal5 as varchar(10))
print 'Affiliate Recruiting Rate: ' + CAST(@AffiliateTotal5/CAST(@RecruitTotal5 AS money) as varchar(10))
print ''

DECLARE @RecruitTotal6 int, @ResellerTotal6 int, @AffiliateTotal6 int
select @RecruitTotal6 = COUNT(*) from Member as me
where me.Level = 1 AND me.EnrollDate >= @FromDate and me.EnrollDate <= @ToDate
and (Select COUNT(*) from Member where ReferralID = me.MemberID and QV >= 100) > 0 
select @ResellerTotal6 = COUNT(*) from Member as me
where me.Level = 1 and me.Title <= 1 AND me.EnrollDate >= @FromDate and me.EnrollDate <= @ToDate
and (Select COUNT(*) from Member where ReferralID = me.MemberID and QV >= 100) > 0 
select @AffiliateTotal6 = COUNT(*) from Member as me
where me.Level = 1 and me.Title > 1 AND me.EnrollDate >= @FromDate and me.EnrollDate <= @ToDate
and (Select COUNT(*) from Member where ReferralID = me.MemberID and QV >= 100) > 0 
print 'Total Resellers/Affiliates doing any recruiting of Affiliates with $100+ Group Volume'
print '-------------------------------------------------------------------------------------'
print 'Total Recruiting: ' + CAST(@RecruitTotal6 as varchar(10))
print 'Total Resellers Recruiting: ' + CAST(@ResellerTotal6 as varchar(10))
print 'Reseller Recruiting Rate: ' + CAST(@ResellerTotal6/CAST(@RecruitTotal6 AS money) as varchar(10))
print 'Total Affiliate Recruiting: ' + CAST(@AffiliateTotal6 as varchar(10))
print 'Affiliate Recruiting Rate: ' + CAST(@AffiliateTotal6/CAST(@RecruitTotal6 AS money) as varchar(10))
print ''
