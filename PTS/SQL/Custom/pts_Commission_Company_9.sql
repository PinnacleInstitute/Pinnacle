EXEC [dbo].pts_CheckProc 'pts_Commission_Company_9'
GO

--DECLARE @Count int EXEC pts_Commission_Company_9 1, '4/1/12', '6/17/12', @Count OUTPUT PRINT @Count

CREATE PROCEDURE [dbo].pts_Commission_Company_9
   @CommType int ,
   @FromDate datetime ,
   @ToDate datetime ,
   @Count int OUTPUT
AS

DECLARE @CompanyID int, @tmpCount int
DECLARE @PaymentID int, @MemberID int, @Amount money, @PayDate datetime, @Purpose varchar(100), @Ref varchar(100)

SET @CompanyID = 9
SET @Count = 0

-- Calculate bonuses
IF @CommType = 1
BEGIN
-- ************************************************************
-- 	Get all uncommisioned payments to process
-- ************************************************************
	DECLARE Payment_cursor CURSOR LOCAL STATIC FOR 
	SELECT pa.PaymentID
	FROM   Payment AS pa
	JOIN   SalesOrder AS so ON pa.OwnerID = so.SalesOrderID
	JOIN   Member AS me ON so.MemberID = me.MemberID 
	WHERE  me.CompanyID = @CompanyID AND pa.OwnerType = 52 
	AND    pa.Status = 3 AND pa.CommStatus = 1
	AND    pa.PayDate >= @FromDate AND dbo.wtfn_DateOnly(pa.PayDate) <= @ToDate
--	AND me.MemberID = 4282

	OPEN Payment_cursor
	FETCH NEXT FROM Payment_cursor INTO @PaymentID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @tmpCount = 0
		EXEC pts_Commission_Company_9a @PaymentID, @tmpCount OUTPUT
		SET @Count = @Count + @tmpCount

		FETCH NEXT FROM Payment_cursor INTO @PaymentID
	END
	CLOSE Payment_cursor
	DEALLOCATE Payment_cursor
END

GO
