EXEC [dbo].pts_CheckProc 'pts_Commission_Company_21_Reward'
GO

--DECLARE @Count int EXEC pts_Commission_Company_21_Reward 1, '3/1/14', '10/5/16', @Count OUTPUT PRINT @Count
--select * from payment2 where commstatus = 2
--SELECT * FROM Payment2 AS pa WHERE  pa.Status = 3 AND pa.CommStatus = 1
--update payment2 set commstatus = 3 where payment2id in (1,22)


CREATE PROCEDURE [dbo].pts_Commission_Company_21_Reward
   @CommType int ,
   @FromDate datetime ,
   @ToDate datetime ,
   @Count int OUTPUT
AS

DECLARE @CompanyID int, @tmpCount int, @Payment2ID int

SET @CompanyID = 21
SET @Count = 0

-- Calculate bonuses
IF @CommType = 1
BEGIN
-- ************************************************************
-- 	Get all uncommisioned payments to process
-- ************************************************************
	DECLARE Payment_cursor CURSOR LOCAL STATIC FOR 
	SELECT pa.Payment2ID
	FROM   Payment2 AS pa
	WHERE  pa.Status = 3 AND pa.CommStatus = 1
	AND    pa.PayDate >= @FromDate AND dbo.wtfn_DateOnly(pa.PayDate) <= @ToDate
--	AND pa.MerchantID = 1

	OPEN Payment_cursor
	FETCH NEXT FROM Payment_cursor INTO @Payment2ID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @tmpCount = 0
		EXEC pts_Commission_Company_21r @Payment2ID, @tmpCount OUTPUT
		SET @Count = @Count + @tmpCount

		FETCH NEXT FROM Payment_cursor INTO @Payment2ID
	END
	CLOSE Payment_cursor
	DEALLOCATE Payment_cursor
END

GO
