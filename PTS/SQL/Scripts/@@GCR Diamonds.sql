select me.MemberID, me.namefirst, me.namelast, me.email, au.logon, me.title from Member as me
join AuthUser as au on me.AuthUserID = au.authuserid
where CompanyID = 17 and Title in (6,7,8)
order by title, me.namelast, me.namefirst

