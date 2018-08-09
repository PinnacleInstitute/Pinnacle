declare @MemberID int, @ReferralID int

DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
select memberid, ReferralID from Member as me
where Status = 1 and referralid > 0 and groupid <> 100
and (select COUNT(*) from Downline where ChildID = me.MemberID) = 0

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @ReferralID
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_Downline_Build_5 5, @ReferralID, @MemberID
	FETCH NEXT FROM Member_cursor INTO @MemberID, @ReferralID
END
CLOSE Member_cursor
DEALLOCATE Member_cursor
