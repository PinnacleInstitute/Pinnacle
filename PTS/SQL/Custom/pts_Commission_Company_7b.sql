EXEC [dbo].pts_CheckProc 'pts_Commission_Company_7b'
GO

CREATE PROCEDURE [dbo].pts_Commission_Company_7b
   @PaymentID int ,
   @MemberID int ,
   @Ref varchar(100) ,
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @Now datetime, @Today datetime, @Title int, @Qualify int, @SponsorID int, @ReferralID int, @QualifyLevel int
DECLARE @Bonus money, @Level int, @ID int, @Desc varchar(100), @EnrollDate datetime, @cnt int, @CommType int
DECLARE @tmpMemberID int

SET @tmpMemberID = @MemberID
SET @CompanyID = 7
SET @Count = 0
SET @Now = GETDATE()

-- Get the member's sponsor
SELECT @MemberID = SponsorID FROM Member WHERE MemberID = @MemberID

-- ********************************************************************
-- Process Monthly Bonuses for the next 5 qualified upline sponsors
-- ********************************************************************
SET @Level = 1
WHILE @Level <= 5 AND @MemberID > 0
BEGIN
--	-- Get the sponsor's info
	SELECT @Qualify = Qualify, @SponsorID = SponsorID FROM Member WHERE MemberID = @MemberID

--	-- If this sponsor is qualified to receive bonuses, otherwise skip (dynamic compression)
	IF @Qualify > 1
	BEGIN
		SET @CommType = 35
		IF @Level = 1 SET @Bonus = 5
		IF @Level = 2 SET @Bonus = 4
		IF @Level = 3 SET @Bonus = 3
		IF @Level = 4 SET @Bonus = 2
		IF @Level = 5 SET @Bonus = 4
		
		SET @Desc = @Ref + ' (' + CAST( @Level AS VARCHAR(2) ) + ')'
--		-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
		SET @Count = @Count + 1

--		-- move to next level to process
		SET @Level = @Level + 1
	END 
--	-- Set the memberID to get the next upline sponsor
	SET @MemberID = @SponsorID
END

-- ***************************************************
-- Process Leadership Bonuses and Sponsorship Bonuses
-- ***************************************************
-- Pay Manager Team Bonus and Sponsor Bonus
SET @MemberID = 0
SELECT @MemberID = ParentID FROM Downline WHERE Line = 1 AND ChildID = @tmpMemberID
IF @MemberID > 0
BEGIN
	SELECT @Qualify = Qualify FROM Member WHERE MemberID = @MemberID
	IF @Qualify > 1
	BEGIN
		SET @CommType = 36
		SET @Bonus = 5
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
				SET @CommType = 37
				SET @Bonus = 1
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
		SET @CommType = 36
		SET @Bonus = 3
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
				SET @CommType = 37
				SET @Bonus = 1
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
		SET @CommType = 36
		SET @Bonus = 2
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
				SET @CommType = 37
				SET @Bonus = 1
				SET @Desc = @Ref + ' (Executive:' + CAST(@MemberID AS VARCHAR(10)) + ')'
--				CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
				SET @Count = @Count + 1
			END	
		END	
	END	
END

--		-- Update Payment Commission Status and date
UPDATE Payment SET CommStatus = 2, CommDate = @Now WHERE PaymentID = @PaymentID

GO
