
SET NOCOUNT ON

DECLARE	@CompanyID int, @BillingID int,
   @BillingName nvarchar (60),
   @Street nvarchar (60),
   @Unit nvarchar (40),
   @City nvarchar (30),
   @State nvarchar (30),
   @Zip nvarchar (20),
   @Country nvarchar (30),
   @PayType int,
   @CommType int,
   @CardType int,
   @CardNumber nvarchar (30),
   @CardMo int,
   @CardYr int,
   @CardName nvarchar (50),
   @CardCode nvarchar (10),
   @CheckBank nvarchar (50),
   @CheckRoute nvarchar (9),
   @CheckAccount nvarchar (20),
   @CheckNumber nvarchar (6),
   @CheckName nvarchar (50)

DECLARE Member_Cursor CURSOR FOR 
SELECT MemberID, NameFirst + ' ' + NameLast AS 'BillingName',
   Street,Unit,City,State,Zip,Country,
   PayType,CommType,CardType,CardNumber,CardMo,CardYr,CardName,CardCode,
   CheckBank,CheckRoute,CheckAccount,CheckNumber,CheckName
FROM Member

OPEN Member_Cursor

FETCH NEXT FROM Member_Cursor INTO 
   @MemberID,@BillingName,@Street,@Unit,@City,@State,@Zip,@Country ,
   @PayType,@CommType,@CardType,@CardNumber,@CardMo,@CardYr,@CardName,
   @CardCode,@CheckBank,@CheckRoute,@CheckAccount,@CheckNumber,@CheckName

WHILE @@FETCH_STATUS = 0
BEGIN

print @BillingName
	
--	EXEC pts_Billing_Add ( @BillingID OUTPUT,
--	   @BillingName,@Street,@Unit,@City,@State,@Zip,@Country ,
--	   @PayType,@CommType,@CardType,@CardNumber,@CardMo,@CardYr,@CardName,
--	   @CardCode,@CheckBank,@CheckRoute,@CheckAccount,@CheckNumber,@CheckName, 1)

	Update Member Set BillingID = @BillingID Where MemberID = @MemberID
	
	FETCH NEXT FROM Member_Cursor INTO 
	   @MemberID,@BillingName,@Street,@Unit,@City,@State,@Zip,@Country ,
	   @PayType,@CommType,@CardType,@CardNumber,@CardMo,@CardYr,@CardName,
	   @CardCode,@CheckBank,@CheckRoute,@CheckAccount,@CheckNumber,@CheckName
END

CLOSE Member_Cursor
DEALLOCATE Member_Cursor

