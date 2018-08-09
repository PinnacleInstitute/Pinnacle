-- *******************************
-- List Members By Country
-- *******************************
DECLARE @FromDate datetime, @ToDate datetime, @CompanyID int
SET @FromDate = '1/1/12'
SET @ToDate = '12/31/13'
SET @CompanyID = 9

SELECT co.CountryName, COUNT(*) 
FROM Member AS me
join Address AS ad ON me.MemberID = ad.OwnerID
join Country AS co ON ad.CountryID = co.CountryID
WHERE me.CompanyID = @CompanyID AND me.EnrollDate >= @FromDate AND me.EnrollDate <= @ToDate
AND me.Status > 0 
--AND co.CountryID <> 224
GROUP BY co.CountryName
ORDER BY COUNT(*) DESC


SELECT co.CountryName, me.MemberID, me.NameFirst, me.NameLast, me.Level, me.Title, me.EnrollDate 
FROM Member AS me
join Address AS ad ON me.MemberID = ad.OwnerID
join Country AS co ON ad.CountryID = co.CountryID
WHERE me.EnrollDate >= @FromDate AND me.EnrollDate <= @ToDate
AND me.Status > 0 
--AND co.CountryID <> 224
ORDER BY co.CountryName, me.EnrollDate DESC



