EXEC [dbo].pts_CheckProc 'pts_Commission_Company_8'
GO

--DECLARE @Count int EXEC pts_Commission_Company_8 1, '4/1/12', '6/17/12', @Count OUTPUT PRINT @Count

CREATE PROCEDURE [dbo].pts_Commission_Company_8
   @CommType int ,
   @FromDate datetime ,
   @ToDate datetime ,
   @Count int OUTPUT
AS

DECLARE @CompanyID int, @Today datetime, @tmpCount int
DECLARE @PaymentID int, @MemberID int, @Amount money, @PayDate datetime, @Ref varchar(100)

SET @CompanyID = 8
SET @Count = 0
SET @Today = GETDATE()

-- Calculate weekly bonuses
IF @CommType = 1
BEGIN
-- ************************************************************
-- 	Get all uncommisioned enrollment payments to process
-- ************************************************************
	DECLARE Payment_cursor CURSOR LOCAL STATIC FOR 
	SELECT pa.PaymentID, me.MemberID, pa.Total, pa.PayDate, LTRIM(STR(me.MemberID)) + ' ' + me.NameFirst + ' ' + me.NameLast
	FROM   Payment AS pa
	JOIN   Member AS me ON pa.OwnerID = me.MemberID 
	WHERE  me.CompanyID = @CompanyID AND pa.OwnerType = 4 
	AND    pa.Status = 3 AND pa.CommStatus = 1
	AND    pa.PayDate >= @FromDate AND dbo.wtfn_DateOnly(pa.PayDate) <= @ToDate
--	AND me.MemberID = 4282

	OPEN Payment_cursor
	FETCH NEXT FROM Payment_cursor INTO @PaymentID, @MemberID, @Amount, @PayDate, @Ref
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @tmpCount = 0
		EXEC pts_Commission_Company_8a @PaymentID, @MemberID, @Amount, @PayDate, @Ref, @tmpCount OUTPUT
		IF @tmpCount > 0 SET @Count = @Count + @tmpCount

		FETCH NEXT FROM Payment_cursor INTO @PaymentID, @MemberID, @Amount, @PayDate, @Ref
	END
	CLOSE Payment_cursor
	DEALLOCATE Payment_cursor
END

GO
