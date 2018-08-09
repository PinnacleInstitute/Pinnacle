-- Set Matrix Sponsors

DECLARE @CompanyID int, @MemberID int, @EnrollDate datetime , @PaidDate datetime 
SET @CompanyID = 17

DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
select MemberID, EnrollDate from Member as me 
where  CompanyID = @CompanyID and MemberID > 22804 AND Status >= 1 AND Status <= 4
ORDER BY memberid
OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @EnrollDate
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @PaidDate = 0
	select top 1 @PaidDate = PaidDate from Payment where Status = 3 and OwnerType = 4 and OwnerID = @MemberID order by paiddate 

	IF @PaidDate > 0
	BEGIN
		IF @PaidDate > @EnrollDate
		BEGIN
--print CAST(@MemberID as varchar(10)) + ' - ' + 	CAST(@EnrollDate as varchar(20)) + ' - ' + 	CAST(@PaidDate as varchar(20))	
			UPDATE Member SET EnrollDate = @PaidDate WHERE MemberID = @MemberID
		END
	END
	FETCH NEXT FROM Member_cursor INTO @MemberID, @EnrollDate
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

GO
