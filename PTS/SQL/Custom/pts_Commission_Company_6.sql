EXEC [dbo].pts_CheckProc 'pts_Commission_Company_6'
GO

--DECLARE @Count int
--EXEC pts_Commission_Company_6 1, '9/1/10', '9/30/10', @Count OUTPUT
--PRINT @Count

CREATE PROCEDURE [dbo].pts_Commission_Company_6
   @CommType int ,
   @FromDate datetime ,
   @ToDate datetime ,
   @Count int OUTPUT
AS

DECLARE @CompanyID int, @Today datetime, @PaymentID int, @MemberID int, @Title int, @Qualify int, @QualifyLevel int, @SponsorID int, @ReferralID int, @ViewerID int
DECLARE @Bonus money, @Level int, @ID int, @Desc varchar(100), @Ref varchar(100)
DECLARE @tmpCount int

SET @CompanyID = 6
SET @Count = 0
SET @Today = GETDATE()

-- Calculate weekly bonuses
IF @CommType = 1
BEGIN
-- 	-- Get all uncommisioned enrollment payments to process
	DECLARE Payment_cursor CURSOR LOCAL STATIC FOR 
	SELECT pa.PaymentID, me.ReferralID, me.MemberID, '#' + LTRIM(STR(me.MemberID)) + ' ' + me.NameFirst + ' ' + me.NameLast
	FROM   Payment AS pa
	JOIN   Member AS me ON pa.OwnerID = me.MemberID 
	WHERE  me.CompanyID = @CompanyID AND pa.OwnerType = 4 
	AND    pa.Status = 3 AND pa.CommStatus = 1 AND pa.Amount > 100
	AND    pa.PayDate >= @FromDate AND dbo.wtfn_DateOnly(pa.PayDate) <= @ToDate

	OPEN Payment_cursor
	FETCH NEXT FROM Payment_cursor INTO @PaymentID, @MemberID, @ViewerID, @Ref
	WHILE @@FETCH_STATUS = 0
	BEGIN
--		-- caclulate the initial bonuses from the initial payment
		SET @tmpCount = 0
		EXEC pts_Commission_Company_6a @PaymentID, @MemberID, @Ref, @tmpCount OUTPUT
		IF @tmpCount > 0 SET @Count = @Count + @tmpCount

--		-- We also caclulate the monthly bonuses from the initial payment
		SET @tmpCount = 0
		EXEC pts_Commission_Company_6b @PaymentID, @MemberID, @ViewerID, @Ref, 1, @tmpCount OUTPUT
		IF @tmpCount > 0 SET @Count = @Count + @tmpCount

		FETCH NEXT FROM Payment_cursor INTO @PaymentID, @MemberID, @ViewerID, @Ref
	END
	CLOSE Payment_cursor
	DEALLOCATE Payment_cursor
END

-- Calculate monthly bonuses
IF @CommType = 2
BEGIN
-- 	-- Get all uncommisioned tuition payments to process
	DECLARE Payment_cursor CURSOR LOCAL STATIC FOR 
	SELECT pa.PaymentID, me.SponsorID, me.MemberID, '#' + LTRIM(STR(me.MemberID)) + ' ' + me.NameFirst + ' ' + me.NameLast
	FROM   Payment AS pa
	JOIN   Member AS me ON pa.OwnerID = me.MemberID 
	WHERE  me.CompanyID = @CompanyID AND pa.OwnerType = 4 
	AND    pa.Status = 3 AND pa.CommStatus = 1 AND pa.Amount < 100
	AND    pa.PayDate >= @FromDate AND dbo.wtfn_DateOnly(pa.PayDate) <= @ToDate

	OPEN Payment_cursor
	FETCH NEXT FROM Payment_cursor INTO @PaymentID, @MemberID, @ViewerID, @Ref
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @tmpCount = 0
		EXEC pts_Commission_Company_6b @PaymentID, @MemberID, @ViewerID, @Ref, 0, @tmpCount OUTPUT
		IF @tmpCount > 0 SET @Count = @Count + @tmpCount

		FETCH NEXT FROM Payment_cursor INTO @PaymentID, @MemberID, @ViewerID, @Ref
	END
	CLOSE Payment_cursor
	DEALLOCATE Payment_cursor
END

-- Calculate fast start bonuses
IF @CommType = 3
BEGIN
	PRINT 'Pending...'
END

-- Calculate leadership bonuses
IF @CommType = 4
BEGIN
	PRINT 'Pending...'
END

GO
