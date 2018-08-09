-- ********************************************************************************************************
-- Create Payout Methods with Paper Check if the member has none 
-- ********************************************************************************************************
DECLARE @PayID int, @MemberID int, @NameFirst varchar(30), @NameLast varchar(30)
DECLARE @Street1 varchar(60), @Street2 varchar(60), @City varchar(30), @State varchar(30), @Zip varchar(20), @CountryID int

DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, NameFirst, NameLast FROM Member WHERE CompanyID = 7 AND PayID = 0

OPEN Member_Cursor
FETCH NEXT FROM Member_Cursor INTO @MemberID, @NameFirst, @NameLast

WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT @Street1 = Street1, @Street2 = Street2, @City = City, @State = State, @Zip = Zip, @CountryID = CountryID FROM Address
	WHERE OwnerID = @MemberID AND AddressType = 2

	IF @Street1 <> ''
	BEGIN
		INSERT INTO Billing ( CountryID, BillingName, Street1, Street2, City, State, Zip, CommType )
		VALUES ( @CountryID, @NameFirst + ' ' + @NameLast, @Street1, @Street2, @City, @State, @Zip, 3 )
		SET @PayID = @@IDENTITY
		UPDATE Member SET PayID = @PayID WHERE MemberID = @MemberID
	END
	FETCH NEXT FROM Member_Cursor INTO @MemberID, @NameFirst, @NameLast
END
CLOSE Member_Cursor
DEALLOCATE Member_Cursor

