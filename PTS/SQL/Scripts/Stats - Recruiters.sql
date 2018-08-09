DECLARE @EnrollDate datetime, @Resellers int, @Affiliates int, @Days int
-- Set the number of days to look back at
SET @Days = 30
SET @EnrollDate = GETDATE() 
SET @EnrollDate = DATEADD(d,@Days * -1,@EnrollDate)

print 'Recruiter Totals'
print 'since ' + CONVERT(varchar(20), @EnrollDate, 1)
print '-----------------'

select @Resellers = count(*) from Member as me
join Member as re on me.ReferralID = re.memberid
where me.level = 1 and me.Title = 1 and me.EnrollDate > @EnrollDate and me.GroupID <> 100 
print 'Resellers: ' + CAST(@Resellers AS VARCHAR(10))

select @Affiliates = count(*) from Member as me
join Member as re on me.ReferralID = re.memberid
where me.level = 1 and me.Title > 1 and me.EnrollDate > @EnrollDate and me.GroupID <> 100 
print 'Affiliates: ' + CAST(@Affiliates AS VARCHAR(10))
 
select re.NameFirst, re.NameLast, count(*)'Resellers' from Member as me
join Member as re on me.ReferralID = re.memberid
where me.level = 1 and me.Title = 1 and me.EnrollDate > @EnrollDate and me.GroupID <> 100 
group by re.NameFirst, re.NameLast
order by COUNT(*) desc

select re.NameFirst, re.NameLast, count(*)'Affiliates' from Member as me
join Member as re on me.ReferralID = re.memberid
where me.level = 1 and me.Title > 1 and me.EnrollDate > @EnrollDate and me.GroupID <> 100
group by re.NameFirst, re.NameLast
order by COUNT(*) desc
