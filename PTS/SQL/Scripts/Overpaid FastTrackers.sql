select me.MemberID, me.NameLast, me.NameFirst, SUM(po.amount) from Payout as po
join Member as me on po.OwnerID = me.memberid
where me.BV < 40
and me.Title >= 1
and me.IsMaster <> 0
and po.PayDate >= '11/1/12'
group by me.MemberID, me.NameLast, me.NameFirst
order by SUM(po.amount) DESC


--Vicky 5144
--mysuccess 5248
--Ijustdoit 5234
--idoitbigtime 5241
--razpeleg 5453

select * from AuthUser where LOGoN= 'razpeleg' 
select * from member where authuserid = 4344 