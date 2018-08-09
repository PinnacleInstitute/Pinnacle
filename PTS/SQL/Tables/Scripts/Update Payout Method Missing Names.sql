-- *****************************************
-- Update Payout Methods with Missing Names
-- *****************************************
--select * 
update bi set BillingName = me.NameFirst + ' ' + me.namelast
from Billing as bi
join Member as me on bi.BillingID = me.PayID
where me.CompanyID=5 and bi.BillingName = ''



