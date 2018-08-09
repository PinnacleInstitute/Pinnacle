-- Move all orphaned members up to an active upline

DECLARE @MemberID int, @cnt int

DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
select MemberID from Member as me
where me.companyid = 17 and me.status >= 6
and (
 0 < (select count(*) from member where referralid = me.memberid and status <= 5 )
OR 0 < (select count(*) from member where referralid = me.memberid and status <= 5 )
)

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_Pinnacle_Orphans @MemberID, 0, @cnt output
	FETCH NEXT FROM Member_cursor INTO @MemberID
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

GO
