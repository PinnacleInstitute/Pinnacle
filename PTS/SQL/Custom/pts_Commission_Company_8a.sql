EXEC [dbo].pts_CheckProc 'pts_Commission_Company_8a'
GO
--update payment set commstatus = 1, commdate = 0 where commstatus = 2
--DECLARE @Count int EXEC pts_Commission_Company_8a 2409, 877, 40, '#877 Jayne Manziel', @Count OUTPUT PRINT @Count
--update Payment set CommStatus = 1, commdate = 0 where paymentid = 2409

CREATE PROCEDURE [dbo].pts_Commission_Company_8a
   @PaymentID int ,
   @MemberID int ,
   @Amount money ,
   @PayDate datetime ,
   @Ref varchar(100) ,
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @ID int, @Now datetime, @ReferralID int, @Level int, @PinnacleID int
DECLARE @Title int, @Bonus money, @Desc varchar(100), @CommType int, @Qualify int
DECLARE @Mode int, @Match money, @MasterID int, @FastStart money

SET @CompanyID = 8
SET @Now = GETDATE()
SET @FastStart = 0

--Single Membership
IF @Amount = 307 
BEGIN
	SET @Amount = 200
	SET @FastStart = 95
END
--Couple Membership
IF @Amount = 455 
BEGIN
	SET @Amount = 300
	SET @FastStart = 142.50
END
--Single Membership - 2 Payments
IF @Amount = 175 OR @Amount = 162
BEGIN
	SET @Amount = 100
	SET @FastStart = 47.50
END
--Couple Membership - 2 Payments
IF @Amount = 256 OR @Amount = 244
BEGIN
	SET @Amount = 150
	SET @FastStart = 71.25
END

IF @Amount <= 30
BEGIN
	SET @PinnacleID = 10751
	SET @CommType = 10
	SET @Bonus = @Amount * .03
	SET @Desc = @Ref
--	CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
	EXEC pts_Commission_Add @ID, @CompanyID, 4, @PinnacleID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
	SET @Count = @Count + 1
END

IF @FastStart > 0
BEGIN
	SET @ReferralID = 0
	SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID
	IF @ReferralID > 0
	BEGIN
		SET @CommType = 5
		SET @Bonus = @FastStart
		SET @Desc = @Ref
--		CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
		SET @Count = @Count + 1
	END
END

-- Start with the member's 2nd upline referrer
SELECT @MemberID = ReferralID FROM Member WHERE MemberID = @MemberID
IF @MemberID > 0 SELECT @MemberID = ReferralID FROM Member WHERE MemberID = @MemberID

SET @Match = 0
SET @Mode = 1
SET @Level = 1
SET @Count = 0
WHILE @MemberID > 0 AND @Mode > 0
BEGIN
--	-- Get the sponsor's info
	SET @ReferralID = -1
	SELECT @ReferralID = ReferralID, @Qualify = Qualify, @Title = Title FROM Member WHERE MemberID = @MemberID
	SET @Level = @Level + 1

--	TEST if we found the Referrer
	IF @ReferralID >= 0
	BEGIN
		SET @Bonus = 0
--		-- Calculate the Matching Bonus paid to personal enroller
		IF @Mode = 3
		BEGIN
--			-- If the personal enroller is a Master, pay him
			IF @Title = 3
			BEGIN
				SET @CommType = 4
				SET @Bonus = @Match
				SET @Desc = @Ref + ' (' + CAST( @MasterID AS VARCHAR(10) ) + ')'
			END
			SET @Mode = 0
		END
--		-- Calculate the Master Infinity bonus
		IF @Mode = 2
		BEGIN
--			-- If we found the upline Master, pay him, otherwise keep looking 		
			IF @Title = 3
			BEGIN
				SET @CommType = 3
				SET @Bonus = ROUND(@Amount * .25, 2)
--				-- Take out 20% for the upline Master
				SET @Match = ROUND(@Bonus * .20, 2)
				SET @Bonus = ROUND(@Bonus * .80, 2)
				SET @MasterID = @MemberID
				SET @Desc = @Ref + ' (' + CAST( @Level AS VARCHAR(2) ) + ')'
				SET @Mode = 3
			END
		END
--		-- Calculate the 2nd Level bonus
		IF @Mode = 1
		BEGIN
			SET @Mode = 2
			SET @Desc = @Ref + ' (' + CAST( @Level AS VARCHAR(2) ) + ')'
--			-- Check if this is a Life Coach
			IF @Title = 1
			BEGIN 
				SET @CommType = 1
				SET @Bonus = ROUND(@Amount * .125, 2)
			END
--			-- Check if this is a Senior Coach
			IF @Title = 2
			BEGIN 
				SET @CommType = 2
				SET @Bonus = ROUND(@Amount * .25, 2)
			END
--			-- Check if this is a Master Coach
			IF @Title = 3
			BEGIN 
				SET @CommType = 3
				SET @Bonus = ROUND(@Amount * .50, 2)
--				-- Take out 10% for the upline Master
				SET @Match = ROUND(@Bonus * .20, 2)
				SET @Bonus = ROUND(@Bonus * .80, 2)
--				-- If the first bonus goes to a Master, the 2nd bonus is not paid			
				SET @MasterID = @MemberID
				SET @Mode = 3
			END
		END
		
		IF @Qualify > 1 AND @Bonus > 0
		BEGIN
--			-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
			EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1, 1
			SET @Count = @Count + 1
		END
--			-- Set the memberID to get the next upline sponsor
		SET @MemberID = @ReferralID
	END
	ELSE SET @MemberID = 0
END

-- Update Payment Commission Status and date
UPDATE Payment SET CommStatus = 2, CommDate = @Now WHERE PaymentID = @PaymentID

GO
