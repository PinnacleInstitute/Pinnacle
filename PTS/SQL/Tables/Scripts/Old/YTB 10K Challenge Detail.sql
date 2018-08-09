-------------------------------------
-- YTB 10K Challenge Detail Report --
-------------------------------------
DECLARE @Startdate datetime, @EndDate datetime
SET @Startdate = '8/1/09'
SET @Enddate = '1/1/10'

select YTBID, MemberID, Date, First, Last, Email, Phone1, Phone2, Code, RefID, Status 
 FROM (
--	-- get non-distributed DVD leads
	select me.reference 'YTBID', me.MemberID 'MemberID', le.leaddate 'Date', le.NameFirst 'First', le.NameLast 'Last', le.Email 'Email', le.Phone1 'Phone1' , le.Phone2 'Phone2', 'C' 'Code', le.LeadID 'RefID', le.Code 'Status' 
	from lead as le
	join member as me on le.memberid = me.memberid
	where me.companyid = 586 and me.reference <> '' and le.prospecttypeid = 60 and le.distributorid = 0 and me.status = 1
	and le.leaddate >= @Startdate and le.leaddate < @EndDate

	UNION

--	-- get distributed DVD leads
	select me.reference 'YTBID', me.MemberID 'MemberID', le.leaddate 'Date', le.NameFirst 'First', le.NameLast 'Last', le.Email 'Email', le.Phone1 'Phone1' , le.Phone2 'Phone2', 'CD' 'Code', le.LeadID 'RefID', le.Code 'Status'  
	from lead as le
	join member as me on le.distributorid = me.memberid
	where me.companyid = 586 and me.reference <> '' and le.prospecttypeid = 60 and le.distributorid > 0 and me.status = 1
	and le.leaddate >= @Startdate and le.leaddate < @EndDate

	UNION

--	-- get non-distributed DVD propsects
	select me.reference 'YTBID', me.MemberID 'MemberID', pr.createdate 'Date', pr.NameFirst 'First', pr.NameLast 'Last', pr.Email 'Email', pr.Phone1 'Phone1', pr.Phone2 'Phone2', 'P' 'Code', pr.ProspectID 'RefID', pr.Code 'Status'  
	from prospect as pr
	join member as me on pr.memberid = me.memberid
	where me.companyid = 586 and me.reference <> '' and pr.prospecttypeid = 60 and pr.distributorid = 0 and me.status = 1
	and pr.createdate >= @Startdate and pr.createdate < @EndDate

	UNION

--	-- get distributed DVD prospects
	select me.reference 'YTBID', me.MemberID 'MemberID', pr.createdate 'Date', pr.NameFirst 'First', pr.NameLast 'Last', pr.Email 'Email', pr.Phone1 'Phone1', pr.Phone2 'Phone2', 'PD' 'Code', pr.ProspectID 'RefID', pr.Code 'Status'  
	from prospect as pr
	join member as me on pr.distributorid = me.memberid
	where me.companyid = 586 and me.reference <> '' and pr.prospecttypeid = 60 and pr.distributorid > 0 and me.status = 1
	and pr.createdate >= @Startdate and pr.createdate < @EndDate

) as tmp
order by YTBID, Date
