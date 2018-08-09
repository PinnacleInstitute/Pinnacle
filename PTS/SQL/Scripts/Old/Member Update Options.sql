DECLARE @ID int, @IsSales bit, @Projects int, @Options varchar(20)

DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT  MemberID, IsSales, Projects FROM Member

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @ID, @IsSales, @Projects

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Options = ''

	IF @IsSales > 0 SET @Options = @Options + 'E'
	IF @Projects = 2 SET @Options = @Options + 'F'
	IF @Projects = 3 SET @Options = @Options + 'f'

	IF @Options <> ''
		UPDATE member SET Options = @Options WHERE memberid = @ID

	FETCH NEXT FROM Member_cursor INTO @ID, @IsSales, @Projects
END

CLOSE Member_cursor
DEALLOCATE Member_cursor

