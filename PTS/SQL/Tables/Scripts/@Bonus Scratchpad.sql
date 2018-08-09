select * from bonus where companyid = 582 and bonusdate = '11/1/08'
select * from bonusitem where bonusid > 0 order by bonusid, commtype 
--delete bonus
--delete bonusitem

-- get total bonuses
select sum(total) from bonus

-- Testing Upline for Builder, UniLevel, Matching, Infinity Bonuses
select * from bonus where bonusid = 50003
select memberid,title,qualify,bv,referralid,sponsorid,NameFirst+' '+NameLast from member where memberid = 68963
select memberid,title,qualify,bv,referralid,sponsorid,NameFirst+' '+NameLast from member where memberid = 9473
select memberid,title,qualify,bv,referralid,sponsorid,NameFirst+' '+NameLast from member where memberid = 75185
select memberid,title,qualify,bv,referralid,sponsorid,NameFirst+' '+NameLast from member where memberid = 3689

-- #   BonusID Company MemberID      CommType  Amount  Reference
224400	50003	582	75185	50710	2	10.0000	2 - 0.10
224401	50003	582	3689	50694	2	10.0000	3 - 0.10

-- bonus summary by type
select commtype, sum(amount)
from bonusitem
group by commtype
order by commtype

-- select all bonuses
select bo.*, me.NameFirst + ' ' + NameLast 
from bonus as bo
join member as me on bo.memberid = me.memberid
where bo.companyid = 582 and bo.bonusdate = '11/1/08'
order by total desc


-- select all bonus checks for printing
select bo.MemberID, me.Reference,
CASE IsCompany
	WHEN 0 THEN me.NameFirst + ' ' + NameLast 
	WHEN 1 THEN me.CompanyName
END AS Name, bo.Total, ad.street1, ad.street2, ad.city, ad.state, ad.zip, co.countryname  
from bonus as bo
join member as me on bo.memberid = me.memberid
left outer join address as ad on ( ad.ownertype=4 AND me.memberid = ad.ownerid AND ( ad.addresstype=2) AND ad.IsActive = 1)
left outer join country as co on ad.countryid = co.countryid
where bo.companyid = 582 
and bo.bonusdate = '11/1/08'
and bo.Total >= 10
order by bo.total desc

-- Set PaidDate for Bonuses
UPDATE Bonus SET PaidDate = '11/16/08' 
WHERE CompanyID = 582 AND BonusDate = '11/1/08' AND Total >= 10


-- recalculate order total BV
DECLARE @SalesOrderID int, @BV money
DECLARE SalesOrder_Cursor CURSOR LOCAL STATIC FOR 
SELECT SalesOrderID, SUM(BV)
FROM SalesItem 
GROUP BY SalesOrderID
OPEN SalesOrder_Cursor
FETCH NEXT FROM SalesOrder_Cursor INTO @SalesOrderID, @BV
WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE SalesOrder SET BV = @BV WHERE SalesOrderID = @SalesOrderID
	FETCH NEXT FROM SalesOrder_Cursor INTO @SalesOrderID, @BV
END
CLOSE SalesOrder_Cursor
DEALLOCATE SalesOrder_Cursor


select sum(so.bv) 
from salesorder as so
join member as me on so.memberid = me.memberid
where so.companyid = 582
and me.enrolldate >= '6/20/08'
and orderdate >= '10/1/08'
and orderdate < '11/1/08'

select sum(bv) from member 
where companyid=582
and enrolldate >= '6/20/08'

select sum(bv), sum(total) from bonus

select * from bonus
update bonus set isprivate = 0

select * from salesitem where salesorderid = 7966
select * from salesorder where salesorderid = 7959
select * from salesorder where bv = 450

select * from salesitem where salesorderid in (
	select salesorderid from salesorder where bv < 0
)
update salesorder set bv = 450 where bv = -550

 