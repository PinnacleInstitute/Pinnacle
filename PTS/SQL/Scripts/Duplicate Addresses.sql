declare @MemberID int, @AddressID int, @cnt int

DECLARE Address_cursor CURSOR LOCAL STATIC FOR 
SELECT OwnerID, min(addressid), count(*) 
FROM Address AS ad
join member as me on ad.ownerid = me.memberid
where me.companyid = 7
and ad.addresstype = 2 
and ad.isactive = 1
GROUP BY OwnerID 
HAVING count(*) > 1
order by count(*) desc

OPEN Address_cursor
FETCH NEXT FROM Address_cursor INTO @MemberID, @AddressID, @cnt
WHILE @@FETCH_STATUS = 0
BEGIN
print @MemberID
print @AddressID
print @cnt
print ''
--	DELETE Address WHERE OwnerID = @MemberID AND AddressID > @AddressID	
	FETCH NEXT FROM Address_cursor INTO @MemberID, @AddressID, @cnt
END
CLOSE Address_cursor
DEALLOCATE Address_cursor

