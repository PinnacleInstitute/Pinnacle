EXEC [dbo].pts_CheckProc 'pts_Company_Custom_1'
GO

--declare @Result int
--EXEC pts_Company_Custom_1 5, 0, 86912, 0, @Result output
--print @Result

CREATE PROCEDURE [dbo].pts_Company_Custom_1
   @Status int ,
   @EnrollDate datetime ,
   @Quantity int ,
   @Amount int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON
SET @Result = 0

DECLARE @CompanyID int, @MemberID int, @ReferralID int, @Now datetime
SET @CompanyID = 1

-- *******************************************************************
-- Status 1 ... Calculate downline personal and group referral totals 
-- *******************************************************************
IF @Status = 1
BEGIN
	DECLARE @SponsorID int, @BV int, @QV int, @Total int

--	-- Clear personal(BV) and group(QV) recruiting numbers
	UPDATE Member SET BV = 0, QV = 0, BV2 = 0, QV2 = 0 WHERE CompanyID = @CompanyID AND (BV > 0 OR QV > 0)

--	-- Get the number of direct recruits for each member (store in BV)
	UPDATE me SET BV = ( SELECT COUNT(*) FROM Member WHERE SponsorID = me.MemberID AND Status >= 1 AND Status <= 4 ) 
	FROM Member AS me WHERE me.CompanyID = @CompanyID
--	-- Set the personal sponsored to the same as personal enrolled	
	UPDATE me SET BV2 = BV FROM Member AS me WHERE me.CompanyID = @CompanyID

--	-- Process all members at the bottom of the hierarchy (BV=0 they have no recruits)
--	-- Walk up the sponsor line and store the total group referrals for each member in QV
--	-- accumulate the totals the first time through a member 
	DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
	SELECT SponsorID FROM Member 
	WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND BV = 0

	OPEN Member_cursor
	FETCH NEXT FROM Member_cursor INTO @MemberID
	WHILE @@FETCH_STATUS = 0
	BEGIN
--print 'Member: ' + CAST(@Test as VARCHAR(10))
		SET @Result = @Result + 1			
		SET @Total = 0
		WHILE @MemberID > 0
		BEGIN
--			-- Get the current Member's personal and group, and sponsor
			SELECT @BV = BV, @QV = QV, @SponsorID = SponsorID FROM Member WHERE MemberID = @MemberID
--			-- If the group has not been set, it's the first time through, so add in the personal
			IF @QV = 0 SET @Total = @Total + @BV
--print '   Sponsor: ' + CAST(@MemberID as VARCHAR(10))  + ' BV: ' + CAST(@BV as VARCHAR(10)) + ' QV: ' + CAST(@QV as VARCHAR(10)) + ' Total: ' + CAST(@Total as VARCHAR(10))
--			-- Add the total to the existing group 
			UPDATE Member SET QV = QV + @Total, QV2 = QV2 + @Total WHERE MemberID = @MemberID
--			-- setup for the next upline sponsor
			SET @MemberID = @SponsorID
		END
		FETCH NEXT FROM Member_cursor INTO @MemberID
	END
	CLOSE Member_cursor
	DEALLOCATE Member_cursor
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
	WHERE CompanyID = @CompanyID AND Status = 1 AND ( Qualify = 1 OR  Qualify = 2 )
	
	UPDATE Member SET Qualify = 0 
	WHERE CompanyID = @CompanyID AND Status = 1 AND Qualify = 3 AND QualifyDate > 0 AND QualifyDate < @EnrollDate

--	--------------------------------------------------------------------------------------------------------
--	set all active member's bonus qualified flag if they are active
--	--------------------------------------------------------------------------------------------------------
	UPDATE Member SET Qualify = 2 WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Qualify = 0

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
	WHERE CompanyID = @CompanyID AND Billing = 3 AND PaidDate <= @OneMonth
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
-- Status 6 ... Mark New Consultant Mailings "In Process"
-- *******************************************************************
IF @Status = 6
BEGIN
	SELECT @Result = COUNT(me.MemberID)
	FROM Member AS me
	JOIN Address AS ad ON me.MemberID = ad.OwnerID AND ad.OwnerType = 4
	WHERE me.CompanyID = @CompanyID AND me.Process = 0 AND ad.AddressType = 2

	UPDATE Me SET Process = 1
	FROM Member AS me
	JOIN Address AS ad ON me.MemberID = ad.OwnerID AND ad.OwnerType = 4
	JOIN Country AS co ON ad.CountryID = co.CountryID
	WHERE me.CompanyID = @CompanyID AND me.Process = 0 AND ad.AddressType = 2
END

-- *******************************************************************
-- Status 7 ... Mark New Consultant Mailings "Mailing Complete"
-- *******************************************************************
IF @Status = 7
BEGIN
	SELECT @Result = COUNT(MemberID) FROM Member WHERE CompanyID = @CompanyID AND Process = 1
	UPDATE Member SET Process = 2 WHERE CompanyID = @CompanyID AND Process = 1
END


-- *******************************************************************
-- Status 100 ... New Member Activation
--  - Accumulate downline totals
--  - Process Advancements
-- *******************************************************************
IF @Status = 100
BEGIN
	DECLARE @cnt int, @AdvanceID int

	SET @MemberID = @Quantity
		
--	-- *************************************************************
--	-- Accumulate downline totals and process upline advancements
--	-- *************************************************************
	SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID
--	-- Check if this referrer has an Advance record
	SET @AdvanceID = 0
	SELECT @AdvanceID = AdvanceID FROM Advance WHERE MemberID = @ReferralID
	IF @AdvanceID = 0 INSERT INTO Advance ( MemberID ) VALUES ( @ReferralID )
		
--	-- Increment personal total for the personal enroller of this new member	
	SET @cnt = 1
	WHILE @ReferralID > 0
	BEGIN
--		-- update upline personal and group counts
		UPDATE Member SET BV = BV + @cnt, BV2 = BV2 + @cnt, QV = QV + 1, QV2 = QV2 + 1 WHERE MemberID = @ReferralID 
		UPDATE Advance SET Personal = Personal + @cnt, [Group] = [Group] + 1 WHERE MemberID = @ReferralID 
		SET @cnt = 0

--		-- check for advancement for this referrer
		EXEC pts_Commission_CalcAdvancement_6 @ReferralID, 0
		
		SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @ReferralID
	END
END

GO