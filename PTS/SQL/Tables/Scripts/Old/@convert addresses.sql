--select distinct country from member
--select countryid, countryname from country where countryid in (37, 67, 100, 110, 161,191, 224 )
--SELECT count(*) FROM Member WHERE Street!='' AND City!='' AND State!='' AND Zip!='' AND Country!=''
--select * from country order by countryname

-- ********************************************************************************************************
-- Create Addresses 
-- ********************************************************************************************************
DECLARE @AddressID int, @MemberID int, @CountryID int, @Country varchar(30)
DECLARE @Street varchar(60), @Unit varchar(40), @City varchar(30), @State varchar(30), @Zip varchar(20)

DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, Street, Unit, City, State, Zip, Country
FROM Member WHERE Street!='' AND City!='' AND State!='' AND Zip!='' AND Country!=''

OPEN Member_Cursor
FETCH NEXT FROM Member_Cursor INTO @MemberID, @Street, @Unit, @City, @State, @Zip, @Country

WHILE @@FETCH_STATUS = 0
BEGIN
--	THEN SET @CountryID = CAST(@Country AS INT)
	SET @CountryID = 
	CASE @Country
		WHEN 'Singapore' THEN 191
		WHEN 'Australia' THEN 14
		WHEN 'BC' THEN 37
		WHEN 'CA' THEN 37
		WHEN 'Canada' THEN 37
		WHEN 'England' THEN 76
		WHEN 'Germany' THEN 56
		WHEN 'ghana' THEN 80
		WHEN 'HKSA' THEN 93
		WHEN 'HKSAR' THEN 93
		WHEN 'Hong Kong' THEN 93
		WHEN 'Hong Kong SAR' THEN 93
		WHEN 'Hong Kong, China' THEN 93
		WHEN 'India' THEN 102
		WHEN 'Indonesia' THEN 99
		WHEN 'Ireland' THEN 100
		WHEN 'Israel' THEN 101
		WHEN 'italy' THEN 107
		WHEN 'Japan' THEN 110
		WHEN 'Latvia' THEN 131
		WHEN 'Malaysia' THEN 152
		WHEN 'NIGERIA' THEN 158
		WHEN 'Norway' THEN 161
		WHEN 'Philippines' THEN 171
		WHEN 'Portugal' THEN 178
		WHEN 'Qatar' THEN 181
		WHEN 'Russia' THEN 184
		WHEN 'Spain' THEN 67
		WHEN 'South Africa' THEN 237
		WHEN 'Taiwan' THEN 219
		WHEN 'Turkey' THEN 216
		WHEN 'UK' THEN 76
		ELSE 224
        END 

	EXEC  pts_Address_Add @AddressID OUTPUT, 4, @MemberID, @CountryID, 2, @Street, @Unit, @City, @State, @Zip, 1

	FETCH NEXT FROM Member_Cursor INTO @MemberID, @Street, @Unit, @City, @State, @Zip, @Country
END
CLOSE Member_Cursor
DEALLOCATE Member_Cursor


