EXEC [dbo].pts_CheckProc 'pts_Commission_Company_7a'
GO

CREATE PROCEDURE [dbo].pts_Commission_Company_7a
   @PaymentID int ,
   @MemberID int ,
   @Amount money ,
   @Ref varchar(100) ,
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @Now datetime, @Title int, @Qualify int, @ReferralID int, @QualifyLevel int
DECLARE @Bonus money, @Level int, @ID int, @Desc varchar(100), @CommType int

SET @CompanyID = 7
SET @Count = 0
SET @Now = GETDATE()

-- Pay Member Training Bonus
--IF @Amount = 99
--BEGIN
--	Set @CommType = 10
--	SET @Bonus = 20
--	SET @Desc = @Ref
----	-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
--	EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
--	SET @Count = @Count + 1
--END

-- Pay Enroller Training Bonus
IF @Amount = 99 OR @Amount = 39 OR @Amount = 60
BEGIN
	SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID
	IF @ReferralID > 0
	BEGIN
		SELECT @Level = [Level] FROM Member WHERE MemberID = @ReferralID
--		-- Only pay this bonus for level 1 nad 2
		IF @Level >= 1 AND @Level <= 2
		BEGIN
			SET @CommType = 11
			IF @Amount = 99 SET @Bonus = 20
			IF @Amount = 39 OR @Amount = 60 SET @Bonus = 10
			SET @Desc = @Ref
--			-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
			EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
			SET @Count = @Count + 1
		END
	END
END

-- Pay Manager Training Bonus
IF @Amount = 99 OR @Amount = 60
BEGIN
	SELECT @ReferralID = ParentID FROM Downline WHERE Line = 1 AND ChildID = @MemberID
	IF @ReferralID > 0
	BEGIN
		SET @CommType = 12
--		SET @Bonus = 10
		SET @Bonus = 20
		SET @Desc = @Ref
--		-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
		SET @Count = @Count + 1
	END
END

-- Pay Director Training Bonus
IF @Amount = 99 OR @Amount = 60
BEGIN
	SELECT @ReferralID = ParentID FROM Downline WHERE Line = 2 AND ChildID = @MemberID
	IF @ReferralID > 0
	BEGIN
		SET @CommType = 13
--		SET @Bonus = 15
		SET @Bonus = 20
		SET @Desc = @Ref
--		-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
		SET @Count = @Count + 1
	END
END

-- Pay Executive Training Bonus
IF @Amount = 99 OR @Amount = 60
BEGIN
	SELECT @ReferralID = ParentID FROM Downline WHERE Line = 3 AND ChildID = @MemberID
	IF @ReferralID > 0
	BEGIN
		SET @CommType = 14
--		SET @Bonus = 5
		SET @Bonus = 10
		SET @Desc = @Ref
--		-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 1
		SET @Count = @Count + 1
	END
END

-- Update Payment Commission Status and date
UPDATE Payment SET CommStatus = 2, CommDate = @Now WHERE PaymentID = @PaymentID

GO
