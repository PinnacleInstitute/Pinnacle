EXEC [dbo].pts_CheckProc 'pts_Commission_Company_5'
GO

--DECLARE @Count int EXEC pts_Commission_Company_5 1, '4/1/12', '6/17/12', @Count OUTPUT PRINT @Count

CREATE PROCEDURE [dbo].pts_Commission_Company_5
   @CommType int ,
   @FromDate datetime ,
   @ToDate datetime ,
   @Count int OUTPUT
AS

DECLARE @CompanyID int, @Today datetime, @PaymentID int, @MemberID int, @Title int, @Qualify int, @QualifyLevel int, @SponsorID int, @ReferralID int
DECLARE @Bonus money, @Level int, @ID int, @Desc varchar(100), @Ref varchar(100), @Amount money, @PayDate datetime
DECLARE @tmpCount int, @CommissionType int, @EnrollDate datetime, @tmpDate datetime

SET @CompanyID = 5
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
	WHERE  me.CompanyID = 5 AND pa.OwnerType = 4 
	AND    pa.Status = 3 AND pa.CommStatus = 1
	AND    pa.PayDate >= @FromDate AND dbo.wtfn_DateOnly(pa.PayDate) <= @ToDate
--	AND me.MemberID = 4282

	OPEN Payment_cursor
	FETCH NEXT FROM Payment_cursor INTO @PaymentID, @MemberID, @Amount, @PayDate, @Ref
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @tmpCount = 0
		EXEC pts_Commission_Company_5a @PaymentID, @MemberID, @Amount, @PayDate, @Ref, @tmpCount OUTPUT
		IF @tmpCount > 0 SET @Count = @Count + @tmpCount

		FETCH NEXT FROM Payment_cursor INTO @PaymentID, @MemberID, @Amount, @PayDate, @Ref
	END
	CLOSE Payment_cursor
	DEALLOCATE Payment_cursor

-- ********************************************
-- Calculate $20 Fast Start Promotion Bonuses
-- ********************************************
	SET @tmpCount = 0
	EXEC pts_Commission_Company_5b @ToDate, @tmpCount OUTPUT
	IF @tmpCount > 0 SET @Count = @Count + @tmpCount

END

GO
