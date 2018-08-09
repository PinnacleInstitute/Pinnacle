EXEC [dbo].pts_CheckProc 'pts_Commission_Company_2'
GO

--DECLARE @Count int
--EXEC pts_Commission_Company_2 1, '9/1/10', '9/30/10', @Count OUTPUT
--PRINT @Count

CREATE PROCEDURE [dbo].pts_Commission_Company_2
   @CommType int ,
   @FromDate datetime ,
   @ToDate datetime ,
   @Count int OUTPUT
AS

DECLARE @Today datetime, @PaymentID int, @MemberID int, @Title int, @Qualify int, @SponsorID int, @ReferralID int
DECLARE @Bonus money, @Level int, @ID int, @Desc varchar(100), @Ref varchar(100)

SET @Count = 0
SET @Today = GETDATE()

-- Calculate weekly enrollment bonuses
IF @CommType = 1
BEGIN
-- 	-- Get all uncommisioned enrollment payments to process
	DECLARE Payment_cursor CURSOR LOCAL STATIC FOR 
	SELECT pa.PaymentID, me.ReferralID, '#' + LTRIM(STR(me.MemberID)) + ' ' + me.NameFirst + ' ' + me.NameLast
	FROM   Payment AS pa
	JOIN   Member AS me ON pa.OwnerID = me.MemberID 
	WHERE  me.CompanyID = 2 AND pa.OwnerType = 4 
	AND    pa.Status = 3 AND pa.CommStatus = 1 AND pa.Amount > 100
	AND    pa.PayDate >= @FromDate AND dbo.wtfn_DateOnly(pa.PayDate) <= @ToDate

	OPEN Payment_cursor
	FETCH NEXT FROM Payment_cursor INTO @PaymentID, @MemberID, @Ref
	WHILE @@FETCH_STATUS = 0
	BEGIN
--print 'Commission for Payment #' + cast(@PaymentID as varchar(10))
--		-- Process the next 4 qualified upline referrers
		SET @Level = 1
		WHILE @Level <= 4 AND @MemberID > 0
		BEGIN
--			-- Get the referrer's info
			SELECT @Title = Title, @Qualify = Qualify, @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID

--			-- If this referrer is qualified to receive bonuses, otherwise skip (dynamic compression)
			IF @Qualify > 1
			BEGIN
--				-- If this referrer has the required title for this level
				IF @Title >= @Level - 1
				BEGIN
--					-- Calculate bonus amount for current level
					SET @Bonus = 
					CASE @Level
						WHEN 1 THEN 75
						WHEN 2 THEN 25
						WHEN 3 THEN 15
						WHEN 4 THEN 10
						ELSE 0
					END	
					SET @Desc = @Ref + ' (' + CAST( @Level AS VARCHAR(2) ) + ')'
--					-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
					EXEC pts_Commission_Add @ID, 2, 4, @MemberID, 0, @PaymentID, @Today, 1, 1, @Bonus, @Bonus, 0, @Desc, '', 1
--print cast(@Bonus as varchar(10)) + '  ' + cast(@MemberID as varchar(10))

					SET @Count = @Count + 1
				END 
--				-- move to next level to process, regardless if the referrer has the required title
				SET @Level = @Level + 1				
			END 
--			-- Set the memberID to get the next upline referrer
			SET @MemberID = @ReferralID
		END

--		-- Update Payment Commission Status and date
		UPDATE Payment SET CommStatus = 2, CommDate = @Today WHERE PaymentID = @PaymentID

		FETCH NEXT FROM Payment_cursor INTO @PaymentID, @MemberID, @Ref
	END
	CLOSE Payment_cursor
	DEALLOCATE Payment_cursor
END

-- Calculate monthly tuition bonuses
IF @CommType = 2
BEGIN
-- 	-- Get all uncommisioned tuition payments to process
	DECLARE Payment_cursor CURSOR LOCAL STATIC FOR 
	SELECT pa.PaymentID, me.SponsorID, '#' + LTRIM(STR(me.MemberID)) + ' ' + me.NameFirst + ' ' + me.NameLast
	FROM   Payment AS pa
	JOIN   Member AS me ON pa.OwnerID = me.MemberID 
	WHERE  me.CompanyID = 2 AND pa.OwnerType = 4 
	AND    pa.Status = 3 AND pa.CommStatus = 1 AND pa.Amount < 100
	AND    pa.PayDate >= @FromDate AND dbo.wtfn_DateOnly(pa.PayDate) <= @ToDate

	SET @Bonus = 4

	OPEN Payment_cursor
	FETCH NEXT FROM Payment_cursor INTO @PaymentID, @MemberID, @Ref
	WHILE @@FETCH_STATUS = 0
	BEGIN
--		-- Process the next 9 qualified upline sponsors
		SET @Level = 1
		WHILE @Level <= 9 AND @MemberID > 0
		BEGIN
--			-- Get the sponsor's info
			SELECT @Title = Title, @Qualify = Qualify, @SponsorID = SponsorID FROM Member WHERE MemberID = @MemberID

--			-- If this sponsor is qualified to receive bonuses, otherwise skip (dynamic compression)
			IF @Qualify > 1
			BEGIN
--				-- If this sponsor has the required title for this level
--				IF @Title >= @Level AND @Level > 1
				IF @Title >= @Level
				BEGIN
					SET @Desc = @Ref + ' (' + CAST( @Level AS VARCHAR(2) ) + ')'
--					-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
					EXEC pts_Commission_Add @ID, 2, 4, @MemberID, 0, @PaymentID, @Today, 1, 2, @Bonus, @Bonus, 0, @Desc, '', 1
					SET @Count = @Count + 1
				END 
--				-- move to next level to process, regardless if the sponsor has the required title
				SET @Level = @Level + 1				
			END 
--			-- Set the memberID to get the next upline sponsor
			SET @MemberID = @SponsorID
		END

--		-- Update Payment Commission Status and date
		UPDATE Payment SET CommStatus = 2, CommDate = @Today WHERE PaymentID = @PaymentID

		FETCH NEXT FROM Payment_cursor INTO @PaymentID, @MemberID, @Ref
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
