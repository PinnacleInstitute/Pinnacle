select re.memberid, re.title, re.namefirst, re.namelast, COUNT(*) 
from Member as me
join Member as re on me.ReferralID = re.MemberID
where ( me.EnrollDate >= '5/16/12' and me.enrolldate < '5/23/12' and me.BV >= 40 )
or (me.BV >= 40 and me.QV4 < 40)
group by re.memberid, re.title, re.namefirst, re.namelast
having COUNT(*) >= 2  
order by COUNT(*) desc


--select EnrollDate, BV, * from Member where ReferralID = 630 and BV >= 40 and EnrollDate >= '5/16/12' and enrolldate < '5/23/12'
