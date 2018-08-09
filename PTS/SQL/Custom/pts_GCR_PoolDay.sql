EXEC [dbo].pts_CheckProc 'pts_GCR_PoolDay'
GO

--DECLARE @Result int EXEC pts_GCR_PoolDay '7/2/15', @Result OUTPUT PRINT @Result 
--select * from miningday 
--update miningday set status = 1 where miningdate = '6/30/15'
--update miningday set status = 0 where miningdate = '7/7/15'

CREATE PROCEDURE [dbo].pts_GCR_PoolDay
   @MiningDate datetime,
   @Result int OUTPUT
AS

SET NOCOUNT ON

-- MiningDay.Status = 0  ... Day Orders Not created yet
-- MiningDay.Status = 1  ... Day Orders created

DECLARE @Coins int, @Status int
DECLARE @PaymentID int, @MemberID int, @PaidDate datetime, @Purpose varchar(100), @Reference varchar(30), @Hash int, @x int, @tmpDate datetime

--If no date is specified, select yesterday
IF @MiningDate = 0 SET @MiningDate = DATEADD(d,-1,dbo.wtfn_DateOnly(GETDATE()))

SET @Coins = 0
SET @Status = 0
SELECT @Coins = Coins, @Status = Status FROM MiningDay WHERE MiningDate = @MiningDate

-- The Last day for new mining orders was 11/18/15
IF @Coins > 0 AND @Status = 0 AND @MiningDate < '11/19/15'
BEGIN

	DECLARE Payment_cursor CURSOR LOCAL STATIC FOR 
	SELECT PaymentID, OwnerID, PaidDate, Purpose, Reference FROM Payment 
	WHERE CompanyID = 17 AND Status = 3 AND Token = 0 AND PaidDate >= '6/1/15' AND PaidDate <= @MiningDate 

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
				SET @tmpDate = DATEADD( d, @x, @MiningDate) 
				INSERT INTO Mining ( MemberID, MiningDate, Hash) VALUES ( @MemberID, @tmpDate, @Hash)
				SET @x = @x + 1
			END
			UPDATE Payment SET Token = 1 WHERE PaymentID = @PaymentID
			IF @MiningDate <> @PaidDate UPDATE Payment SET Notes = Notes + ' Mining Started: ' + dbo.wtfn_DateOnlyStr(@MiningDate) WHERE PaymentID = @PaymentID 
		END
		FETCH NEXT FROM Payment_cursor INTO @PaymentID, @MemberID, @PaidDate, @Purpose, @Reference
	END
	CLOSE Payment_cursor
	DEALLOCATE Payment_cursor

	UPDATE MiningDay SET Status = 1 WHERE MiningDate = @MiningDate
	SET @Result = 1
END	
ELSE
BEGIN
	IF @Coins = 0 SET @Result = -1 ELSE SET @Result = -2
END

GO

