-- Set Legacy Max Titles to manual adjustments
--select * from MemberTitle where MemberID = 22652

DECLARE @MemberID int, @Title int, @Title2 int, @TitleDate datetime
DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
select me.MemberID, me.Title FROM Member AS me where companyid = 14
--and memberid = 22652

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @Title
WHILE @@FETCH_STATUS = 0
BEGIN
	set @Title = 0
--	select top 1 @Title = Title, @TitleDate = TitleDate from MemberTitle where MemberID = @MemberID and isearned = 0 order by titledate desc
	select top 1 @Title2 = Title, @TitleDate = TitleDate from MemberTitle where MemberID = @MemberID and isearned = 1 order by title desc
	if @Title2 > @Title
	begin
--print @Title2
		Update Member set Title = @Title2, Title2 = @Title2  where memberid = @MemberID
		DELETE MemberTitle where MemberID = @MemberID and TitleDate > @TitleDate	
	end	
	
	FETCH NEXT FROM Member_cursor INTO @MemberID, @Title
END
CLOSE Member_cursor
DEALLOCATE Member_cursor


