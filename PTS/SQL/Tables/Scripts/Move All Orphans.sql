declare @MemberID int, @SponsorID int

DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, SponsorID FROM Member as me WHERE Status > 5 AND Level = 1
AND (SELECT COUNT(*) FROM Member WHERE SponsorID = me.MemberID AND Status <=5) > 0

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @SponsorID
WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE Member SET SponsorID = @SponsorID, MentorID = @SponsorID WHERE SponsorID = @MemberID AND Status <=5
	FETCH NEXT FROM Member_cursor INTO @MemberID, @SponsorID
END
CLOSE Member_cursor
DEALLOCATE Member_cursor
