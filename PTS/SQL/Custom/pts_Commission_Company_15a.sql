EXEC [dbo].pts_CheckProc 'pts_Commission_Company_15a'
GO
--update payment set commstatus = 1, commdate = 0 where commstatus = 2
--DECLARE @Count int EXEC pts_Commission_Company_15a 24601, @Count OUTPUT PRINT @Count
--update Payment set CommStatus = 1, commdate = 0 where paymentid = 2409

CREATE PROCEDURE [dbo].pts_Commission_Company_15a
   @PaymentID int ,
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @ID int, @Now datetime, @ReferralID int, @AdminID int
DECLARE @Title int, @Bonus money, @Desc varchar(100), @CommType int, @Qualify int, @Level int 
DECLARE @Amount money, @Code varchar(100), @MemberID int, @Ref varchar(100)

SET @CompanyID = 15
SET @Now = GETDATE()

SELECT @Amount = pa.Amount, @Code = pa.Purpose, @MemberID = me.MemberID, 
	   @Ref = LTRIM(STR(me.MemberID)) + ' ' + me.NameFirst + ' ' + me.NameLast, @ReferralID = me.ReferralID
FROM   Payment AS pa
JOIN   Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID 
WHERE  pa.PaymentID = @PaymentID AND pa.Status = 3 AND pa.CommStatus = 1

--	*************************************************
--	Calculate Admin Fees
--	*************************************************
SET @Bonus = 0
IF @Code = '101' SET @Bonus = 3  -- Affiliate
IF @Code = '102' SET @Bonus = 5  -- Silver
	
IF @Bonus > 0
BEGIN
	SET @CommType = 10
	SET @Desc = @Ref
--	CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
	SET @AdminID = 10251  -- Bob 
	EXEC pts_Commission_Add @ID, @CompanyID, 4, @AdminID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
	SET @Count = @Count + 1
	SET @AdminID = 10255  -- Stan
	EXEC pts_Commission_Add @ID, @CompanyID, 4, @AdminID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
	SET @Count = @Count + 1
	SET @AdminID = 10256  -- Charles
	EXEC pts_Commission_Add @ID, @CompanyID, 4, @AdminID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
	SET @Count = @Count + 1
END

-- ************************************************************
-- Calculate Unilevel Team Bonuses
-- ************************************************************
IF @Amount >  0
BEGIN
--	-- Start with the member's referrer
	SET @MemberID = @ReferralID
	
	SET @Level = 1
	WHILE @Level <= 7 AND @MemberID > 0
	BEGIN
--		-- Get the Referrer's info
		SET @ReferralID = -1
		SELECT @ReferralID = ReferralID, @Qualify = Qualify, @Title = Title FROM Member WHERE MemberID = @MemberID

--		--Did we find the member
		IF @ReferralID >= 0
		BEGIN
			SET @Bonus = 0
			IF @Code = '101'
			BEGIN 
				SET @CommType = 1
				SET @Bonus = 5
			END
			IF @Code = '102'
			BEGIN 
--				-- Must be Silver to earn Silver bonus			
				IF @Title < 2 SET @Qualify = 0
				SET @CommType = 2
				SET @Bonus = 20
			END
		
--			-- Is this member qualified to receive bonuses, otherwise skip (dynamic compression)
			IF @Qualify > 1 AND @Bonus > 0
			BEGIN
				SET @Desc = @Ref + ' (' + CAST( @Level AS VARCHAR(2) ) + ')'
--					-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
				SET @Count = @Count + 1
--				-- move to next level to process (dynamic compression)
				SET @Level = @Level + 1
			END 
--			-- Set the memberID to get the next upline Referral
			SET @MemberID = @ReferralID
		END
		ELSE SET @MemberID = 0
	END
END

-- Update Payment Commission Status and date
UPDATE Payment SET CommStatus = 2, CommDate = @Now WHERE PaymentID = @PaymentID

GO
