-- List all US Citizens earning over $600 in the specified year
DECLARE @CompanyID int, @StartDate datetime, @EndDate datetime
SET @CompanyID = 17
SET @StartDate = '1/1/14'
SET @EndDate = '1/1/15'

select me.memberid, me.NameFirst + ' ' + me.NameLast 'Name', ISNULL(gv.GNumber,'') 'SSN', me.email, me.phone1, ad.street1, ad.street2, ad.City, ad.State, co.CountryName, ad.Zip, SUM(po.Amount) 'Amount'  
from Payout as po
join Member as me on po.OwnerID = me.memberid
left outer join GovID as gv on me.memberid = gv.MemberID
left outer join Address as ad on me.memberid = ad.OwnerID and ad.AddressType = 2 AND IsActive = 1
left outer join Country as co on ad.Countryid = co.countryid
where po.PaidDate >= @StartDate and po.PaidDate < @EndDate
and po.Status = 2 and po.Amount > 0
and me.CompanyID = @CompanyID
and ad.CountryID = 224
group by me.memberid, me.NameFirst + ' ' + me.NameLast, gv.GNumber, me.email, me.phone1, ad.street1, ad.street2, ad.City, ad.State, co.CountryName, ad.Zip
having SUM(po.Amount) >= 600
order by ad.zip 

--select * from Govid
--select * from Address
