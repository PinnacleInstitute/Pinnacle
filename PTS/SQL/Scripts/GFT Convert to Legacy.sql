-- GFT Convert to Legacy
------------------------------------------------
--select CompanyID, EnrollDate, Reference, referral, icons, * from Member where CompanyID = 19 order by memberid desc

DECLARE @TestID int
SET @TestID = 10800

--SELECT memberid, Sponsor2ID, Title2, Title, Status, Level, Options2, CompanyID FROM Member WHERE Companyid = 13
--Update Member SET CompanyID = 13 WHERE MemberID = @TestID
--SELECT memberid, Sponsor2ID, Title2, Title, Status, Level, Options2, CompanyID FROM Member WHERE MemberID = @TestID

--Create Payout Methods
DECLARE @MemberID int
DECLARE Member_cursor CURSOR FOR 
SELECT MemberID FROM Member WHERE CompanyID = 13
--AND MemberID = @TestID
OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID
WHILE @@FETCH_STATUS = 0
BEGIN

	UPDATE Member 
	SET Sponsor2ID = 13, Title2 = Title, Title = 5, Status = 2, Level = 3, Options2 = '', CompanyID = 14
	WHERE MemberID = @MemberID
	
	FETCH NEXT FROM Member_cursor INTO @MemberID
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

--SELECT memberid, Sponsor2ID, Title2, Title, Status, Level, Options2, CompanyID FROM Member WHERE MemberID = @TestID


--select * from SalesOrder where CompanyID = 13 and Status < 3
--Set pending orders to back-ordered
--update SalesOrder set Status = 6 where CompanyID = 13 and Status < 3

--select * from Payment where CompanyID = 13 and CommStatus < 2
--Set  payments to none commissions
--update payment set commstatus = 3 where CompanyID = 13 and CommStatus < 2

--select * from Commission where CompanyID = 13 and PayoutID = 0
--No pending commissions

--select * from Payout where CompanyID = 13 and Status = 6
--Set submitted Payouts to cancelled
--update Payout set Status = 6 where CompanyID = 13 and Status = 1

update member set NameLast = '**' + namelast where CompanyID = 14 and Sponsor2ID = 13