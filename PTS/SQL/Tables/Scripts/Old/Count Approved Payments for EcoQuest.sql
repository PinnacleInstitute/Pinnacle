select count(*) from payment as pa
join member as me on (pa.ownerid = me.memberid and pa.ownertype = 4)
where me.companyid = 13
and pa.status = 3
and pa.paydate >= '4/1/05'
and pa.paydate < '5/1/05'
