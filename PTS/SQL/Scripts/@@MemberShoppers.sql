-- Assign Shopper Account to Affiliate
--select count(*) from member where CompanyID = 21 and Status = 1 and SponsorID > 0 --64
--Create Payout Methods
DECLARE @MemberID int, @ID int, @Email nvarchar(80)

DECLARE Member_cursor CURSOR FOR 
SELECT MemberID, Email FROM Member where CompanyID = 21 and Status = 1 and SponsorID = 0
--and Memberid = 39313
OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @Email
WHILE @@FETCH_STATUS = 0
BEGIN
	print @MemberID
	SET @ID = 0
	SELECT @ID = ConsumerID FROM Consumer WHERE Email = @Email	
	IF @ID > 0 UPDATE Member SET SponsorID = @ID WHERE MemberID = @MemberID	

	FETCH NEXT FROM Member_cursor INTO @MemberID, @Email
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

