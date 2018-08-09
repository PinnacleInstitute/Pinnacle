EXEC [dbo].pts_CheckProc 'pts_Company_Custom_2'
GO

--declare @Result int
--EXEC pts_Company_Custom_2 5, 0, 86912, 0, @Result output
--print @Result

CREATE PROCEDURE [dbo].pts_Company_Custom_2
   @Status int ,
   @EnrollDate datetime ,
   @Quantity int ,
   @Amount int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON
SET @Result = 0

DECLARE @MemberID int, @Now datetime

-- *******************************************************************
-- Status 1 ... Calculate downline personal and group referral totals 
-- *******************************************************************
IF @Status = 1
BEGIN
	DECLARE @SponsorID int, @BV int, @QV int, @Total int

--	-- Clear personal(BV) and group(QV) recruiting numbers
	UPDATE Member SET BV = 0, QV = 0 WHERE CompanyID = 2 AND (BV > 0 OR QV > 0)

--	-- Get the number of direct recruits for each member (store in BV)
	UPDATE me SET BV = (SELECT COUNT(*) FROM Member WHERE SponsorID = me.MemberID AND Status < 5) FROM Member AS me
	WHERE me.CompanyID = 2

--	-- Process all members at the bottom of the hierarchy (BV=0 they have no recruits)
--	-- Walk up the sponsor line and store the total group referrals for each member in QV
--	-- accumulate the totals the first time through a member 
	DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
	SELECT SponsorID FROM Member 
	WHERE CompanyID = 2 AND Status < 5 AND BV = 0

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
			UPDATE Member SET QV = QV + @Total WHERE MemberID = @MemberID
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
		WHERE CompanyID = 2 AND Status < 5 AND BV > 0

	SELECT @Result = COUNT(*) 
	FROM MemberSales AS ms 
	JOIN Member AS me ON ms.MemberID = me.MemberID
	WHERE me.CompanyID = 2 AND ms.SalesDate = @EnrollDate
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
	WHERE CompanyID = 2 AND Status = 1 AND ( Qualify = 1 OR  Qualify = 2 )
	
	UPDATE Member SET Qualify = 0 
	WHERE CompanyID = 2 AND Status = 1 AND Qualify = 3 AND QualifyDate > 0 AND QualifyDate < @EnrollDate

--	--------------------------------------------------------------------------------------------------------
--	set all active member's bonus qualified flag if they are active
--	--------------------------------------------------------------------------------------------------------
	UPDATE Member SET Qualify = 2 WHERE CompanyID = 2 AND Status < 5 AND Qualify = 0

--	return number of qualified members
	SELECT @Result = COUNT(*) FROM Member WHERE CompanyID = 2 AND Qualify > 1
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
	WHERE CompanyID = 2 AND Billing = 3 AND PaidDate <= @OneMonth
	AND MemberID IN (
		SELECT OwnerID FROM Payout
		WHERE CompanyID = 2 AND Status = 1
		GROUP BY OwnerID Having SUM(Amount) >= me.Price
	)
	
	OPEN Member_cursor
	FETCH NEXT FROM Member_cursor INTO @MemberID
	WHILE @@FETCH_STATUS = 0
	BEGIN
--		-- Process Payment Credit
		EXEC pts_Payment_CreditPayment @MemberID
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
	EXEC pts_Payment_CreditPayment @MemberID
	SET @Result = 1
END

GO