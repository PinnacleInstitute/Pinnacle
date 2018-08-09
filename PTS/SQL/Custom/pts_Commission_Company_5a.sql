EXEC [dbo].pts_CheckProc 'pts_Commission_Company_5a'
GO
--update payment set commstatus = 1, commdate = 0 where commstatus = 2
--DECLARE @Count int EXEC pts_Commission_Company_5a 2409, 877, 40, '#877 Jayne Manziel', @Count OUTPUT PRINT @Count
--update Payment set CommStatus = 1, commdate = 0 where paymentid = 2409

CREATE PROCEDURE [dbo].pts_Commission_Company_5a
   @PaymentID int ,
   @MemberID int ,
   @Amount money ,
   @PayDate datetime ,
   @Ref varchar(100) ,
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @Now datetime, @Today datetime, @ReferralID int, @SponsorID int, @EnrollDate datetime, @Days int, @FastStart int
DECLARE @tmpID int, @Title int, @Bonus money, @Level int, @ID int, @Desc varchar(100), @CommType int, @PayoutID int, @Pos int, @Qualify int
DECLARE @BV money, @PayTitle int, @FastTrack int

SET @CompanyID = 5
SET @Count = 0
SET @Now = GETDATE()
SET @Today = dbo.wtfn_DateOnly(GETDATE())
SET @tmpID = @MemberID
SET @FastStart = 0

SELECT @Level = Level, @SponsorID = SponsorID, @ReferralID = ReferralID, @EnrollDate = EnrollDate, @PayTitle = Title2 FROM Member WHERE MemberID = @MemberID

-- Fast Start if first $40 payment (within 7 days of enrollment)
-- OR the amount is $299 (FastTrack)
SET @Days = DATEDIFF( d, @EnrollDate, @PayDate )
IF @Days <= 7 AND @Amount >= 40 SET @FastStart = 1
IF @Amount = 299 SET @FastStart = 1

-- ********************************************************************
-- Process Fast Start/Track Bonuses for the next 2 qualified upline sponsors
-- ********************************************************************
IF @FastStart = 1 
BEGIN
--	-- Start with the member's referrer
	SET @MemberID = @ReferralID

	SET @Level = 1
	WHILE @Level <= 2 AND @MemberID > 0
	BEGIN
--		-- Get the referrer's info
		SET @ReferralID = -1
		SELECT @ReferralID = ReferralID, @Qualify = Qualify, @PayTitle = Title2, @FastTrack = IsMaster FROM Member WHERE MemberID = @MemberID
--		--TEST if we found the affiliate (Resellers are not qualified for fast start bonuses)
		IF @ReferralID >= 0 AND @PayTitle >= 2 
		BEGIN
--			-- Fast Track bonuses only to Fast Track members
			IF @Amount = 299 AND @FastTrack = 0 SET @Qualify = 0
			
--			-- If this enroller is qualified to receive bonuses
			IF @Qualify > 1
			BEGIN
				IF @Amount = 299
				BEGIN
					SET @CommType = 41
					IF @Level = 1 SET @Bonus = 100 ELSE SET @Bonus = 50  
				END
				ELSE
				BEGIN
					SET @CommType = 31
					IF @Level = 1 SET @Bonus = 10 ELSE SET @Bonus = 5  
				END
				
				SET @Desc = @Ref + ' (' + CAST( @Level AS VARCHAR(2) ) + ')'
				
--				-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1, 1
				SET @Count = @Count + 1
			END 
--			-- move to next level to process
			SET @Level = @Level + 1
--			-- Set the memberID to get the next upline sponsor
			SET @MemberID = @ReferralID
		END
		ELSE SET @MemberID = 0
	END
END

-- **************************************************************
-- Process Team Bonuses for the next 7 qualified upline sponsors
-- **************************************************************
IF @FastStart = 0 
BEGIN
--	-- Start with the member's sponsor (if affiliate) or referrer (if customer)
	IF @Level = 1 SET @MemberID = @SponsorID ELSE SET @MemberID = @ReferralID

	SET @Level = 1
	WHILE @Level <= 7 AND @MemberID > 0
	BEGIN
--		-- Get the sponsor's info
		SET @SponsorID = -1
		SELECT @SponsorID = SponsorID, @Qualify = Qualify, @PayTitle = Title2 FROM Member WHERE MemberID = @MemberID
--		--TEST if we found the affiliate
		IF @SponsorID >= 0
		BEGIN
--			-- Resellers are not qualified for bonuses past level 1
			IF @PayTitle <= 1 AND @Level > 1 SET @Qualify = 0
			
--			-- If this sponsor is qualified to receive bonuses, otherwise skip (dynamic compression)
			IF @Qualify > 1
			BEGIN
				SET @CommType = 1
				IF @Level = 1 SET @Bonus = ROUND(@Amount * .10, 2) ELSE SET @Bonus = ROUND(@Amount * .05, 2)  
				SET @Desc = @Ref + ' (' + CAST( @Level AS VARCHAR(2) ) + ')'
				
--				-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1, 1
				SET @Count = @Count + 1

--				-- move to next level to process
				SET @Level = @Level + 1
			END 
--			-- Set the memberID to get the next upline sponsor
			SET @MemberID = @SponsorID
		END
		ELSE SET @MemberID = 0
	END
END

SET @MemberID = @tmpID
-- ***************************************************
-- Process Manager Leadership Bonus
-- ***************************************************
SET @SponsorID = 0
SELECT @SponsorID = ParentID FROM Downline WHERE Line = 2 AND ChildID = @MemberID
IF @SponsorID > 0
BEGIN
	SELECT @Qualify = Qualify, @ReferralID = ReferralID, @FastTrack = IsMaster FROM Member WHERE MemberID = @SponsorID

--	Fast Track bonuses only to Fast Track members
	IF @Amount = 299 AND @FastTrack = 0 SET @Qualify = 0
	
	IF @Qualify > 1
	BEGIN
		SET @CommType = 11
		IF @Amount = 299 SET @Bonus = 25 ELSE SET @Bonus = ROUND(@Amount * .10, 2)
		SET @Desc = @Ref
--			CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @SponsorID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1, 1
		SET @Count = @Count + 1

--			Pay Matching Bonus
		IF @ReferralID > 0
		BEGIN
			SELECT @Qualify = Qualify, @Title = Title2 FROM Member WHERE MemberID = @ReferralID
			IF @Qualify > 1
			BEGIN
				SET @CommType = 21
				IF @Title = 2 OR @Title = 3 SET @Bonus = ROUND(@Bonus * .10, 2)
				IF @Title = 4 SET @Bonus = ROUND(@Bonus * .15, 2)
				IF @Title = 5 SET @Bonus = ROUND(@Bonus * .20, 2)
				IF @Title = 6 SET @Bonus = ROUND(@Bonus * .25, 2)
				SET @Desc = @Ref + ' (Mgr:' + CAST(@SponsorID AS VARCHAR(10)) + ' Title:' + CAST(@Title AS VARCHAR(10)) + ')'
--					CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1, 1
				SET @Count = @Count + 1
			END	
		END	
	END	
END
-- ***************************************************
-- Process Director Leadership Bonus
-- ***************************************************
SET @SponsorID = 0
SELECT @SponsorID = ParentID FROM Downline WHERE Line = 3 AND ChildID = @MemberID
IF @SponsorID > 0
BEGIN
	SELECT @Qualify = Qualify, @ReferralID = ReferralID, @FastTrack = IsMaster FROM Member WHERE MemberID = @SponsorID

--	Fast Track bonuses only to Fast Track members
	IF @Amount = 299 AND @FastTrack = 0 SET @Qualify = 0
	
	IF @Qualify > 1
	BEGIN
		SET @CommType = 12
		IF @Amount = 299 SET @Bonus = 25 ELSE SET @Bonus = ROUND(@Amount * .05, 2)
		SET @Desc = @Ref
--			CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @SponsorID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1, 1
		SET @Count = @Count + 1

--			Pay Matching Bonus
		IF @ReferralID > 0
		BEGIN
			SELECT @Qualify = Qualify, @Title = Title2 FROM Member WHERE MemberID = @ReferralID
			IF @Qualify > 1
			BEGIN
				SET @CommType = 22
				IF @Title = 2 OR @Title = 3 SET @Bonus = ROUND(@Bonus * .10, 2)
				IF @Title = 4 SET @Bonus = ROUND(@Bonus * .15, 2)
				IF @Title = 5 SET @Bonus = ROUND(@Bonus * .20, 2)
				IF @Title = 6 SET @Bonus = ROUND(@Bonus * .25, 2)
				SET @Desc = @Ref + ' (Dir:' + CAST(@SponsorID AS VARCHAR(10)) + ' Title:' + CAST(@Title AS VARCHAR(10)) + ')'
--					CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1, 1
				SET @Count = @Count + 1
			END	
		END	
	END	
END

-- ***************************************************
-- Process Executive Leadership Bonus
-- ***************************************************
SET @SponsorID = 0
SELECT @SponsorID = ParentID FROM Downline WHERE Line = 4 AND ChildID = @MemberID
IF @SponsorID > 0
BEGIN
	SELECT @Qualify = Qualify, @ReferralID = ReferralID, @FastTrack = IsMaster FROM Member WHERE MemberID = @SponsorID

--	Fast Track bonuses only to Fast Track members
	IF @Amount = 299 AND @FastTrack = 0 SET @Qualify = 0
	
	IF @Qualify > 1
	BEGIN
		SET @CommType = 13
		IF @Amount = 299 SET @Bonus = 25 ELSE SET @Bonus = ROUND(@Amount * .05, 2)
		SET @Desc = @Ref
--			CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @SponsorID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1, 1
		SET @Count = @Count + 1

--			Pay Matching Bonus
		IF @ReferralID > 0
		BEGIN
			SELECT @Qualify = Qualify, @Title = Title2 FROM Member WHERE MemberID = @ReferralID
			IF @Qualify > 1
			BEGIN
				SET @CommType = 23
				IF @Title = 2 OR @Title = 3 SET @Bonus = ROUND(@Bonus * .10, 2)
				IF @Title = 4 SET @Bonus = ROUND(@Bonus * .15, 2)
				IF @Title = 5 SET @Bonus = ROUND(@Bonus * .20, 2)
				IF @Title = 6 SET @Bonus = ROUND(@Bonus * .25, 2)
				SET @Desc = @Ref + ' (Exec:' + CAST(@SponsorID AS VARCHAR(10)) + ' Title:' + CAST(@Title AS VARCHAR(10)) + ')'
--					CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1, 1
				SET @Count = @Count + 1
			END	
		END	
	END	
END

-- Update Payment Commission Status and date
UPDATE Payment SET CommStatus = 2, CommDate = @Now WHERE PaymentID = @PaymentID

GO
