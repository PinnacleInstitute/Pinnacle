--select * 
update au set UserType = 0, UserCode = ''
from AuthUser as au
join Member as me on au.AuthUserID = me.authuserid
where usergroup = 41
and (usertype > 0 or (UserCode <> '' and UserCode <> 'RESET'))

