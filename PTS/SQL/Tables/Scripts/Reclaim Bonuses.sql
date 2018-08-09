declare @PaymentID int, @Result varchar(1000)

DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
select PaymentID from payment as pa
where CommStatus = 4
and (select COUNT(*) from Commission where RefID = pa.PaymentID and Amount < 0 ) = 0

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @PaymentID
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_CloudZow_Reclaim @PaymentID, @Result output
	FETCH NEXT FROM Member_cursor INTO @PaymentID
END
CLOSE Member_cursor
DEALLOCATE Member_cursor
