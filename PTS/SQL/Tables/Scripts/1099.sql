select me.NameFirst + ' ' + me.NameLast, gv.GNumber, ad.street1, ad.street2, ad.City, ad.State, co.CountryName, ad.Zip, SUM(po.Amount) 
from Payout as po
join Member as me on po.OwnerID = me.memberid
left outer join GovID as gv on me.memberid = gv.MemberID
left outer join Address as ad on me.memberid = ad.OwnerID and ad.AddressType = 2 AND IsActive = 1
left outer join Country as co on ad.Countryid = co.countryid
where po.PaidDate >= '1/1/2012' and po.PaidDate < '1/1/2013'
and po.Status = 2
group by me.NameFirst + ' ' + me.NameLast, gv.GNumber, ad.street1, ad.street2, ad.City, ad.State, co.CountryName, ad.Zip
having SUM(po.Amount) >= 600
order by co.countryname, ad.zip 

--select * from Govid
--select * from Address
