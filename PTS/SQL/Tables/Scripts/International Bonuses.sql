select po.ownerid, Me.namefirst, me.namelast, me.email, SUM(po.amount) 
from Payout as po
join Address as ad on po.OwnerID = ad.OwnerID 
join Member as me on po.OwnerID = me.memberID 
where po.status = 1
and ad.CountryID <> 224
group by po.ownerid, Me.namefirst, me.namelast, me.email
order by SUM(amount) desc
