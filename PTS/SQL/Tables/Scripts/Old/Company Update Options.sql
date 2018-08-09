DECLARE @ID int, @MemberSupport int, @IsSales bit, @IsSalesLookup bit, @IsSalesLeads bit
DECLARE @IsProjects bit, @IsMemberSupport bit, @Options varchar(40)

DECLARE Company_cursor CURSOR LOCAL STATIC FOR 
SELECT  CompanyID, MemberSupport, IsMemberSupport, IsSales, IsSalesLookup, IsSalesLeads, IsProjects FROM Company

OPEN Company_cursor
FETCH NEXT FROM Company_cursor INTO @ID, @MemberSupport, @IsMemberSupport, @IsSales, @IsSalesLookup, @IsSalesLeads, @IsProjects

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Options = 'ABCD'

	IF @IsSales = 1 SET @Options = @Options + 'E'
	IF @IsProjects = 1 SET @Options = @Options + 'F'

	SET @Options = @Options + 'GHIJKLMNOPQ'

	IF @MemberSupport = 2 SET @Options = @Options + 'R'
	IF @MemberSupport = 3 SET @Options = @Options + 'S'
	IF @MemberSupport = 4 SET @Options = @Options + 'RS'

	SET @Options = @Options + 'TUVWXY'

	IF @IsSalesLeads = 1 SET @Options = @Options + 'Z'
	IF @IsSalesLookup = 1 SET @Options = @Options + '1'
	IF @IsMemberSupport = 1 SET @Options = @Options + '2'

	UPDATE Company SET Options = @Options WHERE Companyid = @ID

	FETCH NEXT FROM Company_cursor INTO @ID, @MemberSupport, @IsMemberSupport, @IsSales, @IsSalesLookup, @IsSalesLeads, @IsProjects
END

CLOSE Company_cursor
DEALLOCATE Company_cursor

