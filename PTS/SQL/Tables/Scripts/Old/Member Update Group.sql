DECLARE @ID int, @Grp varchar(25), @Pos int

DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT  MemberID, Grp FROM Member WHERE CompanyID = 13 AND Grp != ''

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @ID, @Grp

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @pos = CHARINDEX('-', @Grp)

	IF @pos > 0
	BEGIN
		UPDATE member set Grp = SUBSTRING(@Grp, @Pos+1, 25) where memberid = @ID
	END 

--print @Grp + ' : ' + cast(@pos as varchar(10)) + ' : ' + cast(@ID as varchar(10))

	FETCH NEXT FROM Member_cursor INTO @ID, @Grp
END

CLOSE Member_cursor
DEALLOCATE Member_cursor

