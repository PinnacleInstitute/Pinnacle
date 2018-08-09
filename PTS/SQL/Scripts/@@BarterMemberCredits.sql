-- Give all exsitng shopper 5 Ad Credits

--Create Payout Methods
DECLARE @ConsumerID int, @ID int, @Today datetime
SET @Today = dbo.wtfn_DateOnly(GETDATE())

DECLARE Consumer_cursor CURSOR FOR 
SELECT ConsumerID FROM Consumer
--where consumerid = 1
OPEN Consumer_cursor
FETCH NEXT FROM Consumer_cursor INTO @ConsumerID
WHILE @@FETCH_STATUS = 0
BEGIN
	print @ConsumerID
--	EXEC pts_BarterCredit_Add @ID, 151, @ConsumerID, 0, @Today, 5, 1, 1, 0, 0, 'WELCOME', '', 1
	FETCH NEXT FROM Consumer_cursor INTO @ConsumerID
END
CLOSE Consumer_cursor
DEALLOCATE Consumer_cursor

