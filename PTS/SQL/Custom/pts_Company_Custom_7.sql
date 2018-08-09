EXEC [dbo].pts_CheckProc 'pts_Company_Custom_7'
GO

--declare @Result int EXEC pts_Company_Custom_7 1, 0, 0, 0, @Result output print @Result
--declare @Result int EXEC pts_Company_Custom_7 3, 0, 0, 0, @Result output print @Result
--declare @Result int EXEC pts_Company_Custom_7 6, 0, 0, 0, @Result output print @Result

--select * from member where memberid = 90228
--update member set sponsorid = 87230 where memberid = 90228
--select * from member where memberid = 87230
--declare @Result int EXEC pts_Company_Custom_7 100, 0, 90228, 0, @Result output print @Result
--select * from member where memberid = 87230

CREATE PROCEDURE [dbo].pts_Company_Custom_7
   @Status int ,
   @EnrollDate datetime ,
   @Quantity int ,
   @Amount int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON
SET @Result = 0

DECLARE @CompanyID int, @MemberID int, @MemberID2 int, @ReferralID int, @SponsorID int, @Now datetime, @cnt int, @inc int
DECLARE @Level int, @Position int, @AdvanceID int, @EnrollerID int, @tmpID int, @Pos int

SET @CompanyID = 7

-- *******************************************************************
-- Status 1 ... Calculate downline personal and group referral totals 
-- *******************************************************************
IF @Status = 1
BEGIN
	DECLARE @BV int, @QV int, @Total int, @BV2 int, @QV2 int, @BV3 int, @QV3 int, @BV4 int, @QV4 int 
	DECLARE @loss int, @L1 int, @L2 int, @L3 int, @L4 int, @L5 int, @L6 int, @L7 int, @L8 int

--	-- Clear personal(BV) and group(QV) recruiting numbers
	UPDATE Member SET BV = 0, QV = 0, BV2 = 0, QV2 = 0, BV3 = 0, QV3 = 0, BV4 = 0, QV4 = 0 
	WHERE CompanyID = @CompanyID AND (BV != 0 OR QV != 0 OR BV2 != 0 OR QV2 != 0 OR BV3 != 0 OR QV3 != 0 OR BV4 != 0 OR QV4 != 0)

--	************************************************************************************************
--	*** Enroller Downline
--	************************************************************************************************
--	-- Get the number of direct recruits for each member (store in BV)
	UPDATE me SET BV = (SELECT COUNT(*) FROM Member WHERE ReferralID = me.MemberID AND Status >= 1 AND Status <= 5) 
	FROM Member AS me WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 5

--	-- Process all members at the bottom of the enroller hierarchy (BV=0 they have no recruits)
--	-- Walk up the enroller line and store the total group referrals for each member in QV
--	-- accumulate the totals the first time through a member 
	DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
	SELECT ReferralID FROM Member 
	WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 5 AND BV = 0

	OPEN Member_cursor
	FETCH NEXT FROM Member_cursor INTO @MemberID
	WHILE @@FETCH_STATUS = 0
	BEGIN
--print 'Member: ' + CAST(@Test as VARCHAR(10))
		SET @Result = @Result + 1
		SET @Total = 0
		WHILE @MemberID > 0
		BEGIN
			SET @BV = 0 SET @QV = 0
			SET @ReferralID = -1
--			-- Get the current Member's personal and group, and enroller
			SELECT @BV = BV, @QV = QV, @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID
--			-- TEST if we found the member
			IF @ReferralID >= 0
			BEGIN
--				-- If the group has not been set, it's the first time through, so add in the personal
				IF @QV = 0 SET @Total = @Total + @BV
--print '   Sponsor: ' + CAST(@MemberID as VARCHAR(10))  + ' BV: ' + CAST(@BV as VARCHAR(10)) + ' QV: ' + CAST(@QV as VARCHAR(10)) + ' Total: ' + CAST(@Total as VARCHAR(10))
--				-- Add the total to the existing group 
				UPDATE Member SET QV = QV + @Total WHERE MemberID = @MemberID
--				-- setup for the next upline sponsor
				SET @MemberID = @ReferralID
			END
			ELSE SET @MemberID = 0
		END
		FETCH NEXT FROM Member_cursor INTO @MemberID
	END
	CLOSE Member_cursor
	DEALLOCATE Member_cursor

--	************************************************************************************************
--	*** Community Matrix Downline
--	************************************************************************************************
--	-- Get the number of sponsorees for each member (store in BV2)
--	UPDATE me SET BV2 = (SELECT COUNT(*) FROM Member WHERE SponsorID = me.MemberID AND me.Status >= 1 AND me.Status <= 5 ) 
--	FROM Member AS me WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 5

--	-- Process all members at the bottom of the sponsor hierarchy (BV2=0 they have no one under them)
--	-- Walk up the sponsor line and store the total group sponsorings for each member in QV2
--	-- accumulate the totals the first time through a member 
--	DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
--	SELECT SponsorID FROM Member 
--	WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 5 AND BV2 = 0

--	OPEN Member_cursor
--	FETCH NEXT FROM Member_cursor INTO @MemberID
--	WHILE @@FETCH_STATUS = 0
--	BEGIN
--		SET @L8 = 0 SET @L7 = 0 SET @L6 = 0 SET @L5 = 0 SET @L4 = 0 SET @L3 = 0 SET @L2 = 0 SET @L1 = 0
--		SET @Total = 0
--		SET @cnt = 0
--		SET @loss = 0
--		WHILE @MemberID > 0
--		BEGIN
--			SET @cnt = @cnt + 1
--			SET @BV2 = 0 SET @QV2 = 0
--			SET @SponsorID = -1
--			-- Get the current Member's personal and group, and enroller
--			SELECT @BV2 = BV2, @QV2 = QV2, @SponsorID = SponsorID FROM Member WHERE MemberID = @MemberID
--			-- TEST if we found the member
--			IF @SponsorID >= 0 
--			BEGIN
--				-- If the group has not been set, it's the first time through, so add in the personal
--				IF @QV2 = 0 SET @Total = @Total + @BV2
--print '   Sponsor: ' + CAST(@MemberID as VARCHAR(10))  + ' BV2: ' + CAST(@BV2 as VARCHAR(10)) + ' QV2: ' + CAST(@QV2 as VARCHAR(10)) + ' Total: ' + CAST(@Total as VARCHAR(10))
	
--				-- Keep track of 8 levels of totals
--				SET @L8 = @L7 SET @L7 = @L6 SET @L6 = @L5 SET @L5 = @L4 SET @L4 = @L3 SET @L3 = @L2 SET @L2 = @L1 SET @L1 = @Total + @QV2
--				-- If we are more than 7 levels deep, subtract levels 8+
--				IF @QV2 = 0 AND @cnt > 7 SET @loss = @L8
	
--				-- Add the total to the existing group 
--				UPDATE Member SET QV2 = ( QV2 + @Total ) - @loss WHERE MemberID = @MemberID
--				UPDATE Member SET QV2 = QV2 + @Total WHERE MemberID = @MemberID
--				-- setup for the next upline sponsor
--				SET @MemberID = @SponsorID
--			END
--			ELSE SET @MemberID = 0
--		END

--		FETCH NEXT FROM Member_cursor INTO @MemberID
--	END
--	CLOSE Member_cursor
--	DEALLOCATE Member_cursor

--	************************************************************************************************
--	*** Introductory Matrix Downline
--	************************************************************************************************
--	-- Get the number of sponsorees(2) for each member (store in BV3)
--	UPDATE me SET BV3 = (SELECT COUNT(*) FROM Member WHERE Sponsor2ID = me.MemberID AND me.Status >= 1 AND me.Status <= 5 ) 
--	FROM Member AS me WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 5

--	-- Process all members at the bottom of the sponsor2 hierarchy (BV3=0 they have no one under them)
--	-- Walk up the sponsor line and store the total group sponsorings for each member in QV3
--	-- accumulate the totals the first time through a member 
--	DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
--	SELECT Sponsor2ID FROM Member 
--	WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 5 AND BV3 = 0

--	OPEN Member_cursor
--	FETCH NEXT FROM Member_cursor INTO @MemberID
--	WHILE @@FETCH_STATUS = 0
--	BEGIN
-- print '   Member..... ' + CAST(@MemberID as VARCHAR(10))
--		SET SET @L5 = 0 SET @L4 = 0 SET @L3 = 0 SET @L2 = 0 SET @L1 = 0
--		SET @Total = 0
--		SET @cnt = 0
--		SET @loss = 0
--		WHILE @MemberID > 0
--		BEGIN
--			SET @cnt = @cnt + 1
--			SET @BV3 = 0 SET @QV3 = 0
--			SET @SponsorID = -1
--			-- Get the current Member's personal and group, and enroller
--			SELECT @BV3 = BV3, @QV3 = QV3, @SponsorID = Sponsor2ID FROM Member WHERE MemberID = @MemberID
--			-- TEST if we found the member
--			IF @SponsorID >= 0 
--			BEGIN
--				-- If the group has not been set, it's the first time through, so add in the personal
--				IF @QV3 = 0 SET @Total = @Total + @BV3
	
--				-- Keep track of five levels of totals
--				SET @L5 = @L4 SET @L4 = @L3 SET @L3 = @L2 SET @L2 = @L1 SET @L1 = @Total + @QV3
--				-- If we are more than 4 levels deep, subtract levels 5+
--				IF @QV3 = 0 AND @cnt > 4 SET @loss = @L5
	
-- print '   Sponsor: ' + CAST(@MemberID as VARCHAR(10))  + ' BV3: ' + CAST(@BV3 as VARCHAR(10)) + ' QV3: ' + CAST(@QV3 as VARCHAR(10)) + ' Total: ' + CAST(@Total as VARCHAR(10)) + ' Loss: ' + CAST(@loss as VARCHAR(10))

--				-- Add the total to the existing group 
--				UPDATE Member SET QV3 = ( QV3 + @Total ) - @loss WHERE MemberID = @MemberID
--				-- setup for the next upline sponsor
--				SET @MemberID = @SponsorID
--			END
--			ELSE SET @MemberID = 0
--		END
--		FETCH NEXT FROM Member_cursor INTO @MemberID
--	END
--	CLOSE Member_cursor
--	DEALLOCATE Member_cursor

--	************************************************************************************************
--	*** 2-By Infinity Downline
--	************************************************************************************************
--	-- Get the number of sponsorees(3) for each member (store in BV4)
--	UPDATE me SET BV4 = (SELECT COUNT(*) FROM Member WHERE Sponsor3ID = me.MemberID AND me.Status >= 1 AND me.Status <= 5 ) 
--	FROM Member AS me WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 5

--	-- Process all members at the bottom of the sponsor hierarchy (BV4=0 they have no one under them)
--	-- Walk up the sponsor line and store the total group sponsorings for each member in QV4
--	-- accumulate the totals the first time through a member 
--	DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
--	SELECT Sponsor3ID FROM Member 
--	WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 5 AND BV4 = 0

--	OPEN Member_cursor
--	FETCH NEXT FROM Member_cursor INTO @MemberID
--	WHILE @@FETCH_STATUS = 0
--	BEGIN
--		SET @Total = 0
--		WHILE @MemberID > 0
--		BEGIN
--			SET @BV4 = 0 SET @QV4 = 0
--			SET @SponsorID = -1
--			-- Get the current Member's personal and group, and enroller
--			SELECT @BV4 = BV4, @QV4 = QV4, @SponsorID = Sponsor3ID FROM Member WHERE MemberID = @MemberID
--			-- TEST if we found the member
--			IF @SponsorID >= 0 
--			BEGIN
--				-- If the group has not been set, it's the first time through, so add in the personal
--				IF @QV4 = 0 SET @Total = @Total + @BV4
--print '   Sponsor: ' + CAST(@MemberID as VARCHAR(10))  + ' BV2: ' + CAST(@BV2 as VARCHAR(10)) + ' QV2: ' + CAST(@QV2 as VARCHAR(10)) + ' Total: ' + CAST(@Total as VARCHAR(10))
--				-- Add the total to the existing group 
--				UPDATE Member SET QV4 = QV4 + @Total WHERE MemberID = @MemberID
--				-- setup for the next upline sponsor
--				SET @MemberID = @SponsorID
--			END
--			ELSE SET @MemberID = 0
--		END

--		FETCH NEXT FROM Member_cursor INTO @MemberID
--	END
--	CLOSE Member_cursor
--	DEALLOCATE Member_cursor

--	-- Reset the personal sponsored to the same as personal enrolled
--	UPDATE me SET BV2 = BV, BV3 = BV, BV4 = BV FROM Member AS me WHERE me.CompanyID = @CompanyID
END

-- *******************************************************************
-- Status 2 ... Post Monthly Referrals in the Member Sales Summary
-- *******************************************************************
IF @Status = 2
BEGIN
--	-- Create a record for each member that has any referrals (BV)
	INSERT INTO MemberSales (MemberID, SalesDate, PV, GV ) 
		SELECT MemberID, @EnrollDate, BV, QV
		FROM Member
		WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND BV > 0

	SELECT @Result = COUNT(*) 
	FROM MemberSales AS ms 
	JOIN Member AS me ON ms.MemberID = me.MemberID
	WHERE me.CompanyID = @CompanyID AND ms.SalesDate = @EnrollDate
END

-- *******************************************************************
-- Status 3 ... Specify qualified member's that can receive bonuses
-- *******************************************************************
IF @Status = 3
BEGIN
--	--------------------------------------------------------------------------------------------------------
--	initialize all active member's bonus qualified flag to 0 if not locked (2)
--	initialize all active member's bonus qualified flag to 0 if locked (2) and QualifyDate is set and is past
--	--------------------------------------------------------------------------------------------------------
	UPDATE Member SET Qualify = 0 
	WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 2 AND ( Qualify = 1 OR  Qualify = 2 )
	
	UPDATE Member SET Qualify = 0 
	WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 2 AND Qualify = 3 AND QualifyDate > 0 AND QualifyDate < @EnrollDate

--	--------------------------------------------------------------------------------------------------------
--	set all active member's bonus qualified flag if they are active and level 1
--	--------------------------------------------------------------------------------------------------------
	UPDATE me SET Qualify = 2 
	FROM Member AS me
	WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 4 AND me.Qualify = 0
	AND me.Level = 1
	
--	dis-qualify international members
	UPDATE me SET Qualify = 1 
	FROM Member AS me
	LEFT OUTER JOIN Address AS aa ON me.MemberID = aa.OwnerID
	WHERE me.companyid = @CompanyID and aa.countryid != 224

--	return number of qualified members
	SELECT @Result = COUNT(*) FROM Member WHERE CompanyID = @CompanyID AND Qualify > 1
END

-- *******************************************************************
-- Status 4 ... Create Payment Credits from unpaid commissions
-- *******************************************************************
IF @Status = 4
BEGIN
	DECLARE @Count int, @OneMonth datetime
	SET @OneMonth = DATEADD(month,1,GETDATE())
	
--	Check for any members with bill dates within next 30 days
--	AND they have payouts totaling more than payment amount
	DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
	SELECT MemberID FROM Member AS me
	WHERE CompanyID = @CompanyID AND Billing = 3 AND PaidDate <= @OneMonth AND Process = 0
	AND MemberID IN (
		SELECT OwnerID FROM Payout
		WHERE CompanyID = @CompanyID AND Status = 1
		GROUP BY OwnerID Having SUM(Amount) >= me.Price
	)
	
	OPEN Member_cursor
	FETCH NEXT FROM Member_cursor INTO @MemberID
	WHILE @@FETCH_STATUS = 0
	BEGIN
--		-- Process Payment Credit
		EXEC pts_Payment_CreditPayment @CompanyID, @MemberID
		FETCH NEXT FROM Member_cursor INTO @MemberID
		SET @Result = @Result + 1
	END
	CLOSE Member_cursor
	DEALLOCATE Member_cursor
END

-- *******************************************************************
-- Status 5 ... Create individual Payment Credit
-- *******************************************************************
IF @Status = 5
BEGIN
	SET @MemberID = @Quantity
	EXEC pts_Payment_CreditPayment @CompanyID, @MemberID
	SET @Result = 1
END

-- *******************************************************************
-- Status 6 ... Specify qualified member's that can receive a payout
-- *******************************************************************
IF @Status = 6
BEGIN
--	-- ***** START by marking all members not qualified *****
	UPDATE Member SET Qualify = 1 WHERE CompanyID = 7
	
--	-- ***** Check for a verified Payout ACH or a Paper Check *****
	UPDATE me SET Qualify = 2
	FROM Member AS me
	LEFT OUTER JOIN Billing AS b2 ON me.PayID = b2.BillingID
	WHERE me.CompanyID = 7
	AND me.Level = 1
	AND ( b2.commtype = 2 OR b2.commtype = 3 )
--	AND ( b2.Verified = 2 OR b2.commtype = 3 ) AND me.Qualify <> 2
	
--	-- ***** Mark International NOT Qualified to receive a check ***********
	UPDATE me SET Qualify = 1
	FROM Member AS me
	LEFT OUTER JOIN Address AS aa ON me.MemberID = aa.OwnerID
	where me.companyid = 7 and aa.countryid != 224 AND me.Qualify <> 1
	
--	-- ***** Mark Unprocessed Payments NOT Qualified to receive a check ***********
--	UPDATE me SET Qualify = 1
--	FROM Member AS me
--	LEFT OUTER JOIN Payment AS pa ON me.MemberID = pa.OwnerID
--	WHERE me.CompanyID = 7 AND pa.Status = 0 AND me.Qualify = 2

--	-- ***** Levels 1 -3 dont get checks
--	UPDATE me SET Qualify = 1
--	FROM Member AS me
--	WHERE me.CompanyID = 7 AND title >= 11 and Title <= 13 AND me.Qualify = 2

--	return number of qualified members
	SELECT @Result = COUNT(*) FROM Member WHERE CompanyID = 7 AND Qualify > 1
END

-- *******************************************************************
-- Status 20 ... auto-upgrade introductory members (if process = 0).
-- *******************************************************************
--IF @Status = 20
--BEGIN
--	DECLARE @Title int, @newTitle int, @Amt money, @Price money, @ID int, @Notes varchar(100) 
--	SET @Now = dbo.wtfn_DateOnly( GETDATE() )
--	SET @Result = 0

--	-- Get all intro members that have earned commissions greater than their next upgrade level
--	DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
--	SELECT MemberID, Title FROM Member AS me
--	WHERE CompanyID = @CompanyID AND me.Status = 1 AND me.Level = 3 AND Title >= 11 AND Title <= 13 AND Process = 0
--	WHERE CompanyID = @CompanyID AND me.Status = 1 AND me.Level = 3 AND Title >= 11 AND Title <= 13
--	AND MemberID IN (
--		SELECT OwnerID FROM Payout
--		WHERE CompanyID = @CompanyID AND Status = 1
--		GROUP BY OwnerID Having SUM(Amount) >= 13.95
--	)

--	OPEN Member_cursor
--	FETCH NEXT FROM Member_cursor INTO @MemberID, @Title
--	WHILE @@FETCH_STATUS = 0
--	BEGIN
--		-- Get total earnings credit
--		SELECT @Amt = SUM(Amount) FROM Payout WHERE OwnerType = 4 AND OwnerID = @MemberID AND Status = 1

--		-- Check if they can be upgraded to more than one level
--		SET @Price = 0
--		IF @Title = 11
--		BEGIN
--			IF @Amt >= 13.95 BEGIN SET @newTitle = 12 SET @Price = 13.95 END
--			IF @Amt >= 34.95 BEGIN SET @newTitle = 13 SET @Price = 34.95 END
--			IF @Amt >= 76.95 BEGIN SET @newTitle = 14 SET @Price = 76.95 END
--		END		
--		IF @Title = 12
--		BEGIN
--			IF @Amt >= 24.95 BEGIN SET @newTitle = 13 SET @Price = 24.95 END
--			IF @Amt >= 66.95 BEGIN SET @newTitle = 14 SET @Price = 66.95 END
--		END		
--		IF @Title = 13
--		BEGIN
--			IF @Amt >= 46.95 BEGIN SET @newTitle = 14 SET @Price = 46.95 END
--		END		

--		IF @Price > 0
--		BEGIN
--			-- Create the upgrade payment
--			SET @Notes = 'Intro Upgrade: ' + CAST(@Title AS VARCHAR(10)) + ' to ' + CAST(@newTitle AS VARCHAR(10))
--			-- Create Payment Record - PaymentID OUTPUT,CompanyID,OwnerType,OwnerID,BillingID,@ProductID,@PaidID,PayDate,PaidDate,PayType,
--			--	Amount,Total,Credit,Retail,Commission,Description,Purpose,Status,Reference,Notes,CommStatus, CommDate,UserID
--			EXEC pts_Payment_Add @ID OUTPUT, 0, 4, @MemberID, 0, 0, 0, @Now, @Now, 90, 
--			    @Price, @Price, 0, 0, 0, '', '', 3, '', @Notes, 1, 0, 1

--			-- Create the payout debit
--			SET @Price = @Price * -1
--			--	PayoutID OUTPUT, CompanyID, OwnerType, OwnerID, PayDate, PaidDate, Amount, Status, Notes, PayType, Reference, UserID
--			EXEC pts_Payout_Add @ID, @CompanyID, 4, @MemberID, @Now, 0, @Price, 1, '', 4, @Notes, 1

--			-- Upgrade the member's title
--			UPDATE Member SET Title = @newTitle WHERE MemberID = @MemberID

--			SET @Result = @Result + 1
--		END
--		FETCH NEXT FROM Member_cursor INTO @MemberID, @Title
--	END
--	CLOSE Member_cursor
--	DEALLOCATE Member_cursor
--END

-- *******************************************************************
-- Status 100 ... New Member Activation
--  - Accumulate downline totals (level 1-2)
--  - Process Advancements (level 1-2)
--  - Assign Downlines (level 1-2)
-- *******************************************************************
IF @Status = 100
BEGIN
	SET @MemberID = @Quantity
		
	SELECT @ReferralID = ReferralID, @Level = [Level] FROM Member WHERE MemberID = @MemberID
	SET @EnrollerID = @ReferralID

--	 *************************************************************
--	 Accumulate downline totals and process upline advancements
--	 *************************************************************
--	 Check if this referrer has an Advance record
	SET @AdvanceID = 0
	SELECT @AdvanceID = AdvanceID FROM Advance WHERE MemberID = @ReferralID
	IF @AdvanceID = 0 INSERT INTO Advance ( MemberID ) VALUES ( @ReferralID )

--	Increment personal total for the personal enroller of this new member
	SET @cnt = 1
	WHILE @ReferralID > 0
	BEGIN
--		-- update upline personal and group counts
		UPDATE Member SET BV = BV + @cnt, QV = QV + 1 WHERE MemberID = @ReferralID 
		UPDATE Advance SET Personal = Personal + @cnt, [Group] = [Group] + 1, Title1 = Title1 + 1 WHERE MemberID = @ReferralID 
		SET @cnt = 0

--		-- check for advancement for this referrer
		EXEC pts_Commission_CalcAdvancement_7 @ReferralID, 0
			
		SET @tmpID = 0
		SELECT @tmpID = ReferralID FROM Member WHERE MemberID = @ReferralID
		SET @ReferralID = @tmpID
	END

--	-- *************************************************************
--	-- Assign new member to downlines
--	-- *************************************************************
	SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID
	IF @ReferralID > 0
	BEGIN
--		IF @Level = 1 OR @Level = 2
		IF @Level = 1
		BEGIN
--			-- Place Member on the 3 leadership teams (coding)
			EXEC pts_Downline_Build_7 @CompanyID, @ReferralID, @MemberID
		END

		SET @SponsorID = @ReferralID
		SET @Result = @SponsorID * -1
	END	

--		-- *************************************************************
--		-- Place Member in the Community Matrix
--		-- *************************************************************
--		-- This new member has already been assigned to his sponsor
--		-- If the sponsor has more than 3 children, we need to reasign a new sponsor
--		SELECT @cnt = COUNT(*) FROM Member WHERE SponsorID = @SponsorID AND Status >= 1 AND Status <= 5 
--		IF @cnt > 3
--		BEGIN
--			UPDATE Member SET SponsorID = 0 FROM Member WHERE MemberID = @MemberID
--			EXEC pts_Member_PlaceSponsor 3, @SponsorID OUTPUT, 0, 0
--			SET @Result = @SponsorID
--			UPDATE Member SET SponsorID = @SponsorID FROM Member WHERE MemberID = @MemberID
--		END
--		-- -------------------------------------------------------------
--		-- Accumulate matrix downline totals
--		-- -------------------------------------------------------------
--		SELECT @SponsorID = SponsorID FROM Member WHERE MemberID = @MemberID
--		-- Increment personal total for the sponsors of this new member	
--		-- only increment 7 levels up
--		SET @cnt = 0
--		WHILE @SponsorID > 0
--		BEGIN
--			-- update upline personal and group counts
--			UPDATE Member SET BV2 = BV, QV2 = QV2 + 1 WHERE MemberID = @SponsorID 
--			SET @tmpID = 0
--			SELECT @tmpID = SponsorID FROM Member WHERE MemberID = @SponsorID
--			SET @SponsorID = @tmpID
--			SET @cnt = @cnt + 1
--			IF @cnt = 7 SET @SponsorID = 0
--		END

--		-- *************************************************************
--		-- Place Member in the 2-By Infinity
--		-- *************************************************************
--		-- get the next position
--		SET @tmpID = @EnrollerID
--		EXEC pts_Member_PlaceBinary3 @tmpID OUTPUT, @Pos OUTPUT
--		UPDATE Member SET Sponsor3ID = @tmpID, Pos = @Pos WHERE MemberID = @MemberID
--		-- -------------------------------------------------------------
--		-- Accumulate 2-By Infinity downline totals
--		-- -------------------------------------------------------------
--		SELECT @SponsorID = Sponsor3ID FROM Member WHERE MemberID = @MemberID
--		-- Increment personal total for the sponsors of this new member	
--		WHILE @SponsorID > 0
--		BEGIN
--			-- update upline personal and group counts
--			UPDATE Member SET BV4 = BV, QV4 = QV4 + 1 WHERE MemberID = @SponsorID 
--			SET @tmpID = 0
--			SELECT @tmpID = Sponsor3ID FROM Member WHERE MemberID = @SponsorID
--			SET @SponsorID = @tmpID
--		END
--	END	

--	IF @Level = 3
--	BEGIN

--		-- *************************************************************
--		-- Assign new member to Intro Matrix
--		-- *************************************************************
--		SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID
--		IF @ReferralID > 0
--		BEGIN
--			SET @SponsorID = @ReferralID
--			-- Place Member in the Intro Matrix
--			-- This new member has already been assigned to his sponsor2
--			-- If the sponsor has more than 4 children, we need to reasign a new sponsor
--			SELECT @cnt = COUNT(*) FROM Member WHERE Sponsor2ID = @SponsorID AND Status >= 1 AND Status <= 5 
--			IF @cnt > 4
--			BEGIN
--				UPDATE Member SET Sponsor2ID = 0 FROM Member WHERE MemberID = @MemberID
--				EXEC pts_Member_PlaceSponsor2 4, @SponsorID OUTPUT, 0, 0
--				UPDATE Member SET Sponsor2ID = @SponsorID FROM Member WHERE MemberID = @MemberID
--			END
--		END	
--		-- -------------------------------------------------------------
--		-- Accumulate Intro matrix downline totals
--		-- -------------------------------------------------------------
--		SELECT @SponsorID = Sponsor2ID FROM Member WHERE MemberID = @MemberID
--		-- Increment personal total for the sponsors of this new member	
--		-- only increment 4 levels up
--		SET @cnt = 0
--		WHILE @SponsorID > 0
--		BEGIN
--			-- update upline personal and group counts
--			UPDATE Member SET BV3 = BV, QV3 = QV3 + 1 WHERE MemberID = @SponsorID 
--			SET @tmpID = 0
--			SELECT @tmpID = Sponsor2ID FROM Member WHERE MemberID = @SponsorID
--			SET @SponsorID = @tmpID
--			SET @cnt = @cnt + 1
--			IF @cnt = 4 SET @SponsorID = 0
--		END
--	END
END

-- *******************************************************************
-- Status 101 ... Intro Member Upgrade to Regular Membership
--  - Assign Downlines for Leadership Bonuses
-- *******************************************************************
--IF @Status = 101
--BEGIN
--	SET @MemberID = @Quantity
		
--	SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID

--	-- Check if this referrer has an Advance record
--	SET @AdvanceID = 0
--	SELECT @AdvanceID = AdvanceID FROM Advance WHERE MemberID = @ReferralID
--	IF @AdvanceID = 0 INSERT INTO Advance ( MemberID ) VALUES ( @ReferralID )

--	-- *************************************************************
--	-- Assign new member to downlines
--	-- *************************************************************
--	SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID
--	IF @ReferralID > 0
--	BEGIN
--		-- Place Member on the 3 leadership teams (coding)
--		EXEC pts_Downline_Build_7 @CompanyID, @ReferralID, @MemberID
--	END
--END

GO