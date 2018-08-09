-- **************************************************** --
-- Clean out old data from the Pinnacle database
-- **************************************************** --

DECLARE @CleanDate datetime
SET @CleanDate = '1/1/09'

-- ***************************** --
-- DELETE Company Child Entities --
-- ***************************** --
--select * 
delete me
from member as me
left outer join company as co on me.companyid = co.companyid
where co.companyid IS NULL
and me.companyid > 0

--select * 
delete org
from org as org
left outer join company as co on org.companyid = co.companyid
where co.companyid IS NULL
and org.companyid > 0

--select * 
delete oc
from orgCourse as oc
left outer join org as org on oc.orgid = org.orgid
where org.orgid IS NULL

--select * 
delete ca
from calendar as ca
left outer join company as co on ca.companyid = co.companyid
where co.companyid IS NULL
and ca.companyid > 0

--select * 
delete ass
from assessment as ass
left outer join company as co on ass.companyid = co.companyid
where co.companyid IS NULL
and ass.companyid > 0

--select * 
delete aq
from AssessQuestion as aq
left outer join Assessment as ass on aq.Assessmentid = ass.Assessmentid
where ass.Assessmentid IS NULL

--select * 
delete ac
from AssessChoice as ac
left outer join AssessQuestion as aq on ac.AssessQuestionid = aq.AssessQuestionid
where aq.AssessQuestionid IS NULL

--select * 
delete att
from attachment as att
left outer join company as co on att.companyid = co.companyid
where co.companyid IS NULL
and att.companyid > 0

--select * 
delete ch
from channel as ch
left outer join company as co on ch.companyid = co.companyid
where co.companyid IS NULL

--select * 
delete ne
from news as ne
left outer join channel as ch on ne.channelid = ch.channelid
where ch.channelid IS NULL

--select * 
delete cp
from CommPlan as cp
left outer join company as co on cp.companyid = co.companyid
where co.companyid IS NULL

--select * 
delete ct
from CommType as ct
left outer join company as co on ct.companyid = co.companyid
where co.companyid IS NULL

--select * 
delete ge
from Genealogy as ge
left outer join company as co on ge.companyid = co.companyid
where co.companyid IS NULL

--select * 
delete go
from Goal as go
left outer join company as co on go.companyid = co.companyid
where co.companyid IS NULL
and go.companyid > 0

--select * 
delete em
from Email as em
left outer join company as co on em.companyid = co.companyid
where co.companyid IS NULL
and em.companyid > 0

--select * 
delete el
from EmailList as el
left outer join company as co on el.companyid = co.companyid
where co.companyid IS NULL
and el.companyid > 0

--select * 
delete em
from Emailee as em
left outer join EmailList as el on em.EmailListid = el.EmailListid
where el.EmailListid IS NULL
and em.EmailListid > 0

--select * 
delete lc
from LeadCampaign as lc
left outer join Company as co on lc.CompanyID = co.CompanyID
where co.CompanyID IS NULL

--select * 
delete lp
from LeadPage as lp
left outer join LeadCampaign as lc on lp.LeadCampaignID = lc.LeadCampaignID
where lc.LeadCampaignID IS NULL

--select * 
delete nl
from Newsletter as nl
left outer join Company as co on nl.CompanyID = co.CompanyID
where co.CompanyID IS NULL
and nl.companyID > 0
and nl.memberid = 0

--select * 
delete nt
from note as nt
left outer join company as co on nt.ownertype=38 and nt.ownerid = co.companyid
where co.companyid IS NULL
and nt.ownertype=38

--select * 
delete pa
from Page as pa
left outer join Company as co on pa.CompanyID = co.CompanyID
where co.CompanyID IS NULL
and pa.companyID > 0
and pa.memberid = 0

--select * 
delete ps
from PageSection as ps
left outer join Company as co on ps.CompanyID = co.CompanyID
where co.CompanyID IS NULL
and ps.companyID > 0

--select * 
delete pr
from Product as pr
left outer join Company as co on pr.CompanyID = co.CompanyID
where co.CompanyID IS NULL
and pr.companyID > 0

--select * 
delete pt
from ProductType as pt
left outer join Company as co on pt.CompanyID = co.CompanyID
where co.CompanyID IS NULL
and pt.companyID > 0

--select * 
delete pr
from Promotion as pr
left outer join Company as co on pr.CompanyID = co.CompanyID
where co.CompanyID IS NULL
and pr.companyID > 0

--select * 
delete pt
from ProspectType as pt
left outer join Company as co on pt.CompanyID = co.CompanyID
where co.CompanyID IS NULL
and pt.companyID > 0

--select * 
delete qu
from Question as qu
left outer join Company as co on qu.CompanyID = co.CompanyID
where co.CompanyID IS NULL
and qu.companyID > 0

--select * 
delete qt
from QuestionType as qt
left outer join Company as co on qt.CompanyID = co.CompanyID
where co.CompanyID IS NULL
and qt.companyID > 0

--select * 
delete sc
from SalesCampaign as sc
left outer join Company as co on sc.CompanyID = co.CompanyID
where co.CompanyID IS NULL

--select * 
delete ss
from SalesStep as ss
left outer join SalesCampaign as sc on ss.SalesCampaignid = sc.SalesCampaignid
where ss.SalesCampaignid IS NULL

--select * 
delete su
from Suggestion as su
left outer join Org as org on su.Orgid = org.Orgid
where org.Orgid IS NULL

--select * 
delete su
from Survey as su
left outer join Org as org on su.Orgid = org.Orgid
where org.Orgid IS NULL

--select * 
delete sq
from SurveyQuestion as sq
left outer join Survey as su on sq.Surveyid = su.Surveyid
where su.Surveyid IS NULL

--select * 
delete sc
from SurveyChoice as sc
left outer join SurveyQuestion as sq on sc.SurveyQuestionid = sq.SurveyQuestionid
where sq.SurveyQuestionid IS NULL

--select * 
delete sa
from SurveyAnswer as sa
left outer join SurveyQuestion as sq on sa.SurveyQuestionid = sq.SurveyQuestionid
where sq.SurveyQuestionid IS NULL

--select * 
delete ti
from Title as ti
left outer join Company as co on ti.CompanyID = co.CompanyID
where co.CompanyID IS NULL


-- **************************** --
-- DELETE Member Child Entities --
-- **************************** --
--select * 
delete au
from AuthUser as au
left outer join member as me on au.authuserid = me.authuserid
where me.authuserid IS NULL
and au.usertype = 4

--select * 
delete ad
from address as ad
left outer join member as me on ad.ownertype=4 and ad.ownerid = me.memberid
where me.memberid IS NULL
and ad.ownertype=4

--select * 
delete att
from attachment as att
left outer join member as me on att.parenttype=4 and att.parentid = me.memberid
where me.memberid IS NULL
and att.parenttype=4

--select * 
delete go
from Goal as go
left outer join member as me on go.memberid = me.memberid
where me.memberid IS NULL
and go.memberid > 0

-- goal notes
--select * 
delete nt
from note as nt
left outer join goal as go on nt.ownertype=70 and nt.ownerid = go.goalid
where go.goalid IS NULL
and nt.ownertype=70

--select *
delete le
from lead as le
left outer join member as me on le.memberid = me.memberid
where me.memberid IS NULL
and le.memberid > 0

--select *
delete pr
from prospect as pr
left outer join member as me on pr.memberid = me.memberid
where me.memberid IS NULL
and pr.memberid > 0

--select *
delete bo
from Bonus as bo
left outer join member as me on bo.memberid = me.memberid
where me.memberid IS NULL
and bo.memberid > 0

--select *
delete bi
from BonusItem as bi
left outer join member as me on bi.memberid = me.memberid
where me.memberid IS NULL
and bi.memberid > 0

--select * 
delete co
from commission as co
left outer join member as me on co.ownertype=4 and co.ownerid = me.memberid
where me.memberid IS NULL
and co.ownertype=4

--select * 
delete ca
from calendar as ca
left outer join member as me on ca.memberid = me.memberid
where me.memberid IS NULL
and ca.memberid > 0

--select * 
delete ma
from memberassess as ma
left outer join member as me on ma.memberid = me.memberid
where me.memberid IS NULL
and ma.memberid > 0

--select * 
delete aa
from AssessAnswer as aa
left outer join MemberAssess as ma on aa.MemberAssessid = ma.MemberAssessid
where ma.MemberAssessid IS NULL

--select * 
delete mn
from memberNews as mn
left outer join member as me on mn.memberid = me.memberid
where me.memberid IS NULL

--select * 
delete ms
from memberSales as ms
left outer join member as me on ms.memberid = me.memberid
where me.memberid IS NULL

--select * 
delete mt
from memberTax as mt
left outer join member as me on mt.memberid = me.memberid
where me.memberid IS NULL

--select * 
delete mt
from memberTitle as mt
left outer join member as me on mt.memberid = me.memberid
where me.memberid IS NULL

--select * 
delete ex
from expense as ex
left outer join member as me on ex.memberid = me.memberid
where me.memberid IS NULL

--select * 
delete fa
from favorite as fa
left outer join member as me on fa.memberid = me.memberid
where me.memberid IS NULL

--select * 
delete lc
from LeadCampaign as lc
left outer join member as me on lc.groupid = me.memberid
where me.memberid IS NULL
and lc.groupid > 0

--select * 
delete sc
from SalesCampaign as sc
left outer join member as me on sc.groupid = me.memberid
where me.memberid IS NULL
and sc.groupid > 0

--select * 
delete ss
from SalesStep as ss
left outer join SalesCampaign as sc on ss.SalesCampaignid = sc.SalesCampaignid
where ss.SalesCampaignid IS NULL

--select * 
delete lp
from LeadPage as lp
left outer join LeadCampaign as lc on lp.LeadCampaignID = lc.LeadCampaignID
where lc.LeadCampaignID IS NULL

--select * 
delete ll
from LeadLog as ll
left outer join member as me on ll.memberid = me.memberid
where me.memberid IS NULL
and ll.memberid > 0

--select * 
delete ll
from LeadLog as ll
left outer join LeadPage as lp on ll.leadpageid = lp.leadpageid
where lp.leadpageid IS NULL
or ll.LogDate < @CleanDate

--select * 
delete ma
from Mail as ma
left outer join member as me on ma.memberid = me.memberid
where me.memberid IS NULL
and ma.memberid > 0

--select * 
delete nl
from Newsletter as nl
left outer join member as me on nl.memberid = me.memberid
where me.memberid IS NULL
and nl.memberid > 0

--select * 
delete nt
from note as nt
left outer join member as me on nt.ownertype=4 and nt.ownerid = me.memberid
where me.memberid IS NULL
and nt.ownertype=4

-- mentoring notes
--select * 
delete nt
from note as nt
left outer join member as me on nt.ownertype=-4 and nt.ownerid = me.memberid
where me.memberid IS NULL
and nt.ownertype=-4

--select * 
delete pa
from Page as pa
left outer join Member as me on pa.MemberID = me.MemberID
where me.MemberID IS NULL
and pa.memberid > 0

--select * 
delete si
from Signature as si
left outer join Member as me on si.MemberID = me.MemberID
where me.MemberID IS NULL


-- ****************************** --
-- DELETE AuthUser Child Entities --
-- ****************************** --
--select * 
delete al
from AuthLog as al
left outer join AuthUser as au on al.authuserid = au.authuserid
where au.authuserid IS NULL
or LogDate < @CleanDate
--or LogDate < '1/1/10'

--select * 
delete ad
from Audit as ad
left outer join AuthUser as au on ad.authuserid = au.authuserid
where au.authuserid IS NULL

--select * 
delete sc
from Shortcut as sc
left outer join AuthUser as au on sc.authuserid = au.authuserid
where au.authuserid IS NULL


-- DELETE Prospect Child Entities
-- ***********************************************************************
--select * 
delete ev
from event as ev
left outer join prospect as pr on ev.ownertype = 81 and ev.ownerid = pr.prospectid
where pr.prospectid IS NULL
and ev.ownertype = 81

--select * 
delete att
from attachment as att
left outer join prospect as pr on att.parenttype=81 and att.parentid = pr.prospectid
where pr.prospectid IS NULL
and att.parenttype=81

--select * 
delete nt
from note as nt
left outer join prospect as pr on nt.ownertype=81 and nt.ownerid = pr.prospectid
where pr.prospectid IS NULL
and nt.ownertype=81

--select * 
delete ma
from mail as ma
left outer join prospect as pr on ma.ownertype=81 and ma.ownerid = pr.prospectid
where pr.prospectid IS NULL
and ma.ownertype=81
and ma.memberid > 0

--select * 
delete ma
from mail as ma
left outer join prospect as pr on ma.ownertype=-81 and ma.ownerid = pr.prospectid
where pr.prospectid IS NULL
and ma.ownertype=-81
and ma.memberid > 0

-- Delete Lead Mail 
--select * 
delete ma
from mail as ma
left outer join lead as le on ma.ownertype=22 and ma.ownerid = le.leadid
where le.leadid IS NULL
and ma.ownertype=22
and ma.memberid > 0


-- DELETE Calendar Child Entities
-- ***********************************************************************
--select * 
delete ap
from appt as ap
left outer join calendar as ca on ap.calendarid = ca.calendarid
where ca.calendarid IS NULL

--select * 
delete pa
from party as pa
left outer join appt as ap on pa.apptid = ap.apptid
where ap.apptid IS NULL

--select * 
delete gu
from guest as gu
left outer join party as pa on gu.partyid = pa.partyid
where pa.partyid IS NULL

-- party notes
--select * 
delete nt
from note as nt
left outer join party as pa on nt.ownertype=25 and nt.ownerid = pa.partyid
where pa.partyid IS NULL
and nt.ownertype=25
