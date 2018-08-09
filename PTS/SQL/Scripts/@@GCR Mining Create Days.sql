----------------------------
-- Create Mining Order Days
----------------------------

DECLARE @PaymentID int, @MemberID int, @PaidDate datetime, @Purpose varchar(100), @Reference varchar(30), @Hash int, @x int, @Today datetime, @tmpDate datetime, @StartDate datetime
SET @StartDate = '7/1/14'
SET @Today = DATEADD(d,-1,dbo.wtfn_DateOnly(GETDATE()))

UPDATE Payment SET Token = 0 WHERE CompanyID = 17 -- AND MiningDate >= @StartDate
DELETE Mining -- WHERE MiningDate >= @StartDate

DECLARE Payment_cursor CURSOR LOCAL STATIC FOR 
SELECT PaymentID, OwnerID, PaidDate, Purpose, Reference FROM Payment 
WHERE CompanyID = 17 AND Status = 3 AND Token = 0 AND PaidDate >= @StartDate AND PaidDate <= @Today 
AND Left(Reference, 2) != '**'

OPEN Payment_cursor
FETCH NEXT FROM Payment_cursor INTO @PaymentID, @MemberID, @PaidDate, @Purpose, @Reference
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Hash = 0
	
	IF @Purpose IN ('103', '203' ) SET @Hash = 150
	IF @Purpose IN ('104', '204' ) SET @Hash = 450
	IF @Purpose IN ('105', '205' ) SET @Hash = 1024 -- 1M
	IF @Purpose IN ('106', '206' ) SET @Hash = 2048 -- 3M
	IF @Purpose IN ('107', '207' ) SET @Hash = 3584 -- 3.5M
	IF @Purpose IN ('108', '208' ) SET @Hash = 12288 -- 12M
	IF @Purpose IN ('109', '209' ) SET @Hash = CAST(@Reference AS INT)

	IF @Hash > 0 
	BEGIN
		--Create 31 mining days for each order 
		SET @x = 0
		WHILE @x < 31	
		BEGIN
			SET @tmpDate = DATEADD( d, @x, @PaidDate) 
			INSERT INTO Mining ( MemberID, MiningDate, Hash) VALUES ( @MemberID, @tmpDate, @Hash)
			SET @x = @x + 1
		END
		UPDATE Payment SET Token = 1 WHERE PaymentID = @PaymentID
	END
	FETCH NEXT FROM Payment_cursor INTO @PaymentID, @MemberID, @PaidDate, @Purpose, @Reference
END
CLOSE Payment_cursor
DEALLOCATE Payment_cursor

GO

--delete mining
--select * from mining
--UPDATE Payment SET Token = 0 WHERE CompanyID = 17
--UPDATE Payment SET Purpose = '209', Reference='100000' WHERE PaymentID = 79835


