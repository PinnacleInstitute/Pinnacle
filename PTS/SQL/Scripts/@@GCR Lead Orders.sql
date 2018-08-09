DECLARE @StartDate datetime, @EndDate datetime
SET @StartDate = '11/6/15'
SET @EndDate = '12/31/15'

select dbo.wtfn_DateOnlyStr(paiddate) 'Date', ownerid 'MemberID',
      CASE Purpose
         WHEN '104' THEN 'Silver'
         WHEN '204' THEN 'Silver'
         WHEN '105' THEN 'Gold'
         WHEN '205' THEN 'Gold'
      END 'Package'
from Payment 
where CompanyID = 17 and Status = 3 and PaidDate >= @StartDate and PaidDate <= @EndDate and Purpose in ('104','204','105','205') 
order by PaidDate 


