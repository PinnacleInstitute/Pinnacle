EXEC [dbo].pts_CheckProc 'pts_Commission_Company_7a'
GO

CREATE PROCEDURE [dbo].pts_Commission_Company_7a
   @PaymentID int ,
   @MemberID int ,
   @Amount money ,
   @Ref varchar(100) ,
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @Now datetime, @Today datetime, @ReferralID int, @SponsorID int, @tmpID int, @tmpMemberID int
DECLARE @Bonus money, @Level int, @ID int, @Desc varchar(100), @CommType int, @PayoutID int, @Pos int, @Qualify int

SET @CompanyID = 7
SET @Count = 0
SET @Now = GETDATE()
SET @Today = dbo.wtfn_DateOnly(GETDATE())

-- ***************************************************
-- Training Bonus
-- ***************************************************
SELECT @Qualify = Qualify, @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID
IF @Qualify > 1
BEGIN
	SET @CommType = 31
	SET @Bonus = 30
	SET @Desc = ''
--	CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
	EXEC pts_Commission_Add @ID OUTPUT, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
	SET @Count = @Count + 1

--	Create the payout with a Forced payment for this training bonus
--	PayoutID OUTPUT, CompanyID, OwnerType, OwnerID, PayDate, PaidDate, Amount, Status, Notes, PayType, Reference, UserID
	EXEC pts_Payout_Add @PayoutID OUTPUT, @CompanyID, 4, @MemberID, @Today, 0, @Bonus, 3, '', 0, '', 1
--	Update Commission for this payout
	UPDATE Commission SET PayoutID = @PayoutID, Status = 2 WHERE CommissionID = @ID
END

-- ***************************************************
-- Enroller Bonuses
-- ***************************************************
SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID
IF @ReferralID > 0
BEGIN
	SELECT @Qualify = Qualify, @SponsorID = @ReferralID FROM Member WHERE MemberID = @ReferralID
	IF @Qualify = 1
	BEGIN
		SET @CommType = 32
		SET @Bonus = 40
		SET @Desc = @Ref + ' (1)'
--		-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
		EXEC pts_Commission_Add @ID OUTPUT, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
		SET @Count = @Count + 1
	END
	IF @SponsorID > 0
	BEGIN
		SET @ReferralID = @SponsorID
		SELECT @Qualify = Qualify, @SponsorID = @ReferralID FROM Member WHERE MemberID = @ReferralID
		IF @Qualify = 1
		BEGIN
			SET @CommType = 32
			SET @Bonus = 15
			SET @Desc = @Ref + ' (2)'
--			-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
			EXEC pts_Commission_Add @ID OUTPUT, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
			SET @Count = @Count + 1
		END
		IF @SponsorID > 0
		BEGIN
			SET @ReferralID = @SponsorID
			SELECT @Qualify = Qualify, @SponsorID = @ReferralID FROM Member WHERE MemberID = @ReferralID
			IF @Qualify = 1
			BEGIN
				SET @CommType = 32
				SET @Bonus = 10
				SET @Desc = @Ref + ' (3)'
--				-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
				EXEC pts_Commission_Add @ID OUTPUT, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
				SET @Count = @Count + 1
			END
		END
	END
END

-- ***************************************************
-- Process Leadership Bonuses and Sponsorship Bonuses
-- ***************************************************
SET @tmpMemberID = @MemberID
-- Pay Manager Team Bonus and Sponsor Bonus
SET @MemberID = 0
SELECT @MemberID = ParentID FROM Downline WHERE Line = 1 AND ChildID = @tmpMemberID
IF @MemberID > 0
BEGIN
	SELECT @Qualify = Qualify FROM Member WHERE MemberID = @MemberID
	IF @Qualify > 1
	BEGIN
		SET @CommType = 33
		SET @Bonus = 10
		SET @Desc = @Ref + ' (Manager)'
--		CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
		SET @Count = @Count + 1
		
--		Pay Sponsorship Bonus
		SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID
		IF @ReferralID > 0
		BEGIN
			SELECT @Qualify = Qualify FROM Member WHERE MemberID = @ReferralID
			IF @Qualify > 1
			BEGIN
				SET @CommType = 34
				SET @Bonus = 2
				SET @Desc = @Ref + ' (Manager:' + CAST(@MemberID AS VARCHAR(10)) + ')'
--				CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
				SET @Count = @Count + 1
			END	
		END	
	END	
END

-- Pay Director Team Bonus and Sponsor Bonus
SET @MemberID = 0
SELECT @MemberID = ParentID FROM Downline WHERE Line = 2 AND ChildID = @tmpMemberID
IF @MemberID > 0
BEGIN
	SELECT @Qualify = Qualify FROM Member WHERE MemberID = @MemberID
	IF @Qualify > 1
	BEGIN
		SET @CommType = 33
		SET @Bonus = 10
		SET @Desc = @Ref + ' (Director)'
--		CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
		SET @Count = @Count + 1
		
--		Pay Sponsorship Bonus
		SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID
		IF @ReferralID > 0
		BEGIN
			SELECT @Qualify = Qualify FROM Member WHERE MemberID = @ReferralID
			IF @Qualify > 1
			BEGIN
				SET @CommType = 34
				SET @Bonus = 2
				SET @Desc = @Ref + ' (Director:' + CAST(@MemberID AS VARCHAR(10)) + ')'
--				CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
				SET @Count = @Count + 1
			END	
		END	
	END	
END

-- Pay Executive Team Bonus and Sponsor Bonus
SET @MemberID = 0
SELECT @MemberID = ParentID FROM Downline WHERE Line = 3 AND ChildID = @tmpMemberID
IF @MemberID > 0
BEGIN
	SELECT @Qualify = Qualify FROM Member WHERE MemberID = @MemberID
	IF @Qualify > 1
	BEGIN
		SET @CommType = 33
		SET @Bonus = 5
		SET @Desc = @Ref + ' (Executive)'
--		CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
		SET @Count = @Count + 1
		
--		Pay Sponsorship Bonus
		SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID
		IF @ReferralID > 0
		BEGIN
			SELECT @Qualify = Qualify FROM Member WHERE MemberID = @ReferralID
			IF @Qualify > 1
			BEGIN
				SET @CommType = 34
				SET @Bonus = 2
				SET @Desc = @Ref + ' (Executive:' + CAST(@MemberID AS VARCHAR(10)) + ')'
--				CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
				SET @Count = @Count + 1
			END	
		END	
	END	
END

-- Update Payment Commission Status and date
UPDATE Payment SET CommStatus = 2, CommDate = @Now WHERE PaymentID = @PaymentID

GO
