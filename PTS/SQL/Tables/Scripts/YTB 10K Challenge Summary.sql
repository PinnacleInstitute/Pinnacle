------------------------------
-- YTB 10K Challenge Report --
------------------------------
DECLARE @Startdate datetime, @EndDate datetime
SET @Startdate = '8/1/09'
SET @Enddate = '1/1/10'

select YTBID, MemberID, Year, Month, count(id) 'DVD'
 FROM (
--	-- get non-distributed DVD leads
	select me.reference 'YTBID', me.memberID 'MemberID', YEAR(le.leaddate) 'Year', MONTH(le.leaddate) 'Month', le.leadid 'id' 
	from lead as le
	join member as me on le.memberid = me.memberid
	where me.companyid = 586 and me.reference <> '' and le.prospecttypeid = 60 and le.distributorid = 0 and me.status = 1
	and le.leaddate >= @Startdate and le.leaddate < @EndDate

	UNION

--	-- get distributed DVD leads
	select me.reference 'YTBID', me.memberID 'MemberID', YEAR(le.leaddate) 'Year', MONTH(le.leaddate) 'Month', le.leadid 'id' 
	from lead as le
	join member as me on le.distributorid = me.memberid
	where me.companyid = 586 and me.reference <> '' and le.prospecttypeid = 60 and le.distributorid > 0 and me.status = 1
	and le.leaddate >= @Startdate and le.leaddate < @EndDate

	UNION

--	-- get non-distributed DVD propsects
	select me.reference 'YTBID', me.memberID 'MemberID', YEAR(pr.createdate) 'Year', MONTH(pr.createdate) 'Month', pr.prospectid 'id' 
	from prospect as pr
	join member as me on pr.memberid = me.memberid
	where me.companyid = 586 and me.reference <> '' and pr.prospecttypeid = 60 and pr.distributorid = 0 and me.status = 1
	and pr.createdate >= @Startdate and pr.createdate < @EndDate

	UNION

--	-- get distributed DVD prospects
	select me.reference 'YTBID', me.memberID 'MemberID', YEAR(pr.createdate) 'Year', MONTH(pr.createdate) 'Month', pr.prospectid 'id' 
	from prospect as pr
	join member as me on pr.distributorid = me.memberid
	where me.companyid = 586 and me.reference <> '' and pr.prospecttypeid = 60 and pr.distributorid > 0 and me.status = 1
	and pr.createdate >= @Startdate and pr.createdate < @EndDate

) as tmp
group by YTBID, MemberID, Year, Month
order by YTBID, MemberID, Year, Month
