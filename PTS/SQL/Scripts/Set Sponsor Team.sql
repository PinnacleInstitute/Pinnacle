declare @MemberID int, @Title int, @Team int, @PromoteDate datetime

update Member set BusAccts = 1 where CompanyID = 5 and Level = 1

DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, Title 
FROM Member WHERE CompanyID = 5 AND [Level] = 1 AND Status >= 1 AND Status <= 5 AND Title > 1
--and memberid = 763
--update Member set BusAccts=0 

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @Title
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Team = 2
	WHILE @Team <= 4
	BEGIN
		IF @Title >= @Team
		BEGIN
			SET @PromoteDate = 0
			SELECT TOP 1 @PromoteDate = TitleDate FROM MemberTitle WHERE MemberID = @MemberID AND Title = @Team ORDER BY TitleDate
			IF @PromoteDate > 0 
				UPDATE Member SET BusAccts = @Team WHERE SponsorID = @MemberID AND EnrollDate > @PromoteDate
--print cast(@Team as varchar(10)) + ' - ' + cast(@PromoteDate as varchar(10))
		END
		SET @Team = @Team + 1
	END	
	FETCH NEXT FROM Member_cursor INTO @MemberID, @Title
END
CLOSE Member_cursor
DEALLOCATE Member_cursor
