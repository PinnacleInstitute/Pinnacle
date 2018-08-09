EXEC [dbo].pts_CheckProc 'pts_Commission_Company_1'
GO

CREATE PROCEDURE [dbo].pts_Commission_Company_1
   @CompanyID int ,
   @CommPlan int ,
   @PaymentID int ,
   @ProductCode int ,
   @CommDate datetime ,
   @MemberID int ,
   @Amount money ,
   @PromotionID int
AS
-- ***************************************
-- Commission Plans
-- ---------------------------------------
-- 1 ..... Weekly Commissions
-- 2 ..... Monthly Commissions
-- ***************************************
-- ***************************************
-- Commissionable Product Codes
-- ---------------------------------------
-- RTA ..... RTA Travel Agent Package
-- CTA ..... CTA Travel Agent Package
-- RCMO	.... RTA / CTA Monthly Subscription
-- EXMO	.... Executive Monthly Subscription
-- TRVL .... Retail Travel
-- ***************************************
-- ***************************************
-- Agent Titles
-- ---------------------------------------
-- 1 .... Associate
-- 2 .... RTA
-- 3 .... CTA
-- 4 .... Executive
-- 5 .... Regional Executive
-- 6 .... National Executive
-- 7 .... International Executive
-- 8 .... Presidential Executive
-- ***************************************
SET NOCOUNT ON

DECLARE @CommType int, @Bonus money, @ID int, @OwnerID int, @CodeID int, @Pos int, @Title int

-- Process Weekly Commissions
IF @CommPlan = 1 AND ( @ProductCode = 'RTA' OR @ProductCode = 'CTA' )
BEGIN
--	********************************************************************************************************
--	Process Enrollment Bonus
--	********************************************************************************************************
	SET @OwnerID = 0
--	Get the Enroller of the Member (Enroller Downline #0)
	SELECT @OwnerID = ParentID FROM Downline WHERE Line = 0 AND ChildID = @MemberID

	IF @OwnerID > 0
	BEGIN
		SELECT @CommType = 1, @Bonus = 50
--		If CTA Product, lookup Title and calculate Bonus based on title
		IF @ProductCode = 'CTA'
		BEGIN
--			Get member's title for this commission run
			SELECT @Title = Title FROM Member WHERE MemberID = @OwnerID
			IF @Title <= 2 SET @Bonus = 75 
			IF @Title = 3 SET @Bonus = 100 
			IF @Title >= 4 SET @Bonus = 120 
		END
--		CommissionID OUTPUT, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @OwnerID, 0, @PaymentID, @CommDate, 1, @CommType, @Bonus, @Bonus, 0, '', '', 1
	END
	
--	********************************************************************************************************
--	Process Coded Bonus ($20)
--	********************************************************************************************************
	SET @OwnerID = 0
--	Get the upline RTA+ coded to the Member (2up Downline #2)
	SELECT @OwnerID = ParentID FROM Downline WHERE Line = 2 AND ChildID = @MemberID

	IF @OwnerID > 0
	BEGIN
--		Get member's title for this commission run
		SELECT @Title = Title FROM Member WHERE MemberID = @OwnerID

		SELECT @CommType = 2, @Bonus = 20
--		If CTA Product, calculate Bonus based on title
		IF @ProductCode = 'CTA'
		BEGIN
			IF @Title = 2 SET @Bonus = 30 
			IF @Title = 3 SET @Bonus = 40 
			IF @Title >= 4 SET @Bonus = 60 
		END
--		CommissionID OUTPUT, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @OwnerID, 0, @PaymentID, @CommDate, 1, @CommType, @Bonus, @Bonus, 0, '', '', 1

--		****************************************************************
--		Process Matching Coded Bonus to the enroller of the coded bonus
--		****************************************************************
		SET @CodeID = @OwnerID
		SET @OwnerID = 0
--		Get the upline enroller of the coded Member (Enroller Downline #0)
		SELECT @OwnerID = ParentID, @Pos = Position FROM Downline WHERE Line = 0 AND ChildID = @CodeID

		IF @OwnerID > 0
		BEGIN
--			Get member's title for this commission run
			SELECT @Title = Title FROM Member WHERE MemberID = @OwnerID
	
--			Matching Coded Bonuses are only for RTA+
			IF @Title >= 2
			BEGIN
				IF @Pos < 3
				BEGIN
--					Process 150% Matching Coded Bonus
					SELECT @CommType = 3, @Bonus = @Bonus * 1.5
--					CommissionID OUTPUT, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
					EXEC pts_Commission_Add @ID, @CompanyID, 4, @OwnerID, 0, @PaymentID, @CommDate, 1, @CommType, @Bonus, @Bonus, 0, '', '', 1
				END
				ELSE
				BEGIN
--					Process 100% Matching Coded Bonus
					SET @CommType = 4
--					CommissionID OUTPUT, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
					EXEC pts_Commission_Add @ID, @CompanyID, 4, @OwnerID, 0, @PaymentID, @CommDate, 1, @CommType, @Bonus, @Bonus, 0, '', '', 1
				END
			END
		END
	END

--	********************************************************************************************************
--	Process Builder Bonus 
--	********************************************************************************************************
	SET @OwnerID = 0
--	Get the upline executive coded to the Member (6up Downline #3)
	SELECT @OwnerID = ParentID FROM Downline WHERE Line = 3 AND ChildID = @MemberID

	IF @OwnerID > 0
	BEGIN
--		Get member's title for this commission run
		SELECT @Title = Title FROM Member WHERE MemberID = @OwnerID

		SELECT @CommType = 5, @Bonus = 0
--		calculate executive Bonus based on title
		IF @Title = 4 SET @Bonus = 5 
		IF @Title = 5 SET @Bonus = 7 
		IF @Title = 6 SET @Bonus = 10 
		IF @Title = 7 SET @Bonus = 12 
		IF @Title >= 8 SET @Bonus = 15 
--		CommissionID OUTPUT, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @OwnerID, 0, @PaymentID, @CommDate, 1, @CommType, @Bonus, @Bonus, 0, '', '', 1

--		*************************************************************************
--		Process 100% Matching Builder Bonus to the enroller of the builder bonus
--		*************************************************************************
		SET @CodeID = @OwnerID
		SET @OwnerID = 0

--		Get the upline enroller of the coded Member (Enroller Downline #0)
		SELECT @OwnerID = ParentID, @Pos = Position FROM Downline WHERE Line = 0 AND ChildID = @CodeID

		IF @OwnerID > 0
		BEGIN
--			Get member's title for this commission run
			SELECT @Title = Title FROM Member WHERE MemberID = @OwnerID
	
--			Matching Builder Bonuses are only for Executives+
			IF @Title >= 4
			BEGIN
				SELECT @CommType = 6
--				CommissionID OUTPUT, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @OwnerID, 0, @PaymentID, @CommDate, 1, @CommType, @Bonus, @Bonus, 0, '', '', 1
			END
		END
	END
END

-- Process Monthly Commissions
IF @CommPlan = 2 AND ( @ProductCode = 'RCMO' OR @ProductCode = 'EXMO' )
BEGIN
--	Get the enrollment date of this member 

--	********************************************************************************************************
--	Process Monthly Coded Bonus ($5)
--	********************************************************************************************************
	SET @OwnerID = 0
--	Get the upline coded to the Member (2up Downline #2)
	SELECT @OwnerID = ParentID FROM Downline WHERE Line = 2 AND ChildID = @MemberID

	IF @OwnerID > 0
	BEGIN
		SELECT @CommType = 11, @Bonus = 5
--		CommissionID OUTPUT, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @OwnerID, 0, @PaymentID, @CommDate, 1, @CommType, @Bonus, @Bonus, 0, '', '', 1

--		************************************************************************
--		Process Matching Monthly Coded Bonus to the enroller of the coded bonus
--		************************************************************************
		SET @CodeID = @OwnerID
		SELECT @OwnerID = 0

--		Get the enroller of the coded Member (Enroller Downline #0)
		SELECT @OwnerID = ParentID FROM Downline WHERE Line = 0 AND ChildID = @CodeID

		IF @OwnerID > 0
		BEGIN
			SELECT @Title = Title FROM Member WHERE MemberID = @OwnerID

--			Matching Monthly Coded Bonuses are only for RTA+
			IF @Title >= 2 
			BEGIN
				SELECT @CommType = 12, @Bonus = 5
--				CommissionID OUTPUT, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @OwnerID, 0, @PaymentID, @CommDate, 1, @CommType, @Bonus, @Bonus, 0, '', '', 1
			END
		END
	
		IF @ProductCode = 'EXMO'
		BEGIN
--			********************************************************************************************************
--			Process Monthly Executive Coded Bonus
--			********************************************************************************************************
			SET @OwnerID = 0
--			Get the upline executive coded to the Member (6up Downline #3)
			SELECT @OwnerID = ParentID FROM Downline WHERE Line = 3 AND ChildID = @MemberID
		
			IF @OwnerID > 0
			BEGIN
--				Get member's title for this commission run
				SELECT @Title = Title FROM Member WHERE MemberID = @OwnerID
		
				SELECT @CommType = 13, @Bonus = 0
--				calculate executive coded Bonus based on title
				IF @Title = 4 SET @Bonus = 5 
				IF @Title = 5 SET @Bonus = 6 
				IF @Title = 6 SET @Bonus = 8 
				IF @Title = 7 SET @Bonus = 10 
				IF @Title >= 8 SET @Bonus = 12 

--				CommissionID OUTPUT, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @OwnerID, 0, @PaymentID, @CommDate, 1, @CommType, @Bonus, @Bonus, 0, '', '', 1
		
--				****************************************************************
--				Process Matching Executive Bonus to the enroller of the coded bonus
--				****************************************************************
				SET @CodeID = @OwnerID
				SET @OwnerID = 0
--				Get the upline coded to the Member
				SELECT @OwnerID = ParentID FROM Downline WHERE Line = 0 AND ChildID = @CodeID
		
				IF @OwnerID > 0
				BEGIN
--					Get member's title for this commission run
					SELECT @Title = Title FROM Member WHERE MemberID = @OwnerID
			
--					Matching Executive Coded Bonuses are only for Executives+
					IF @Title >= 4
					BEGIN
						SET @CommType = 14
--						CommissionID OUTPUT, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
						EXEC pts_Commission_Add @ID, @CompanyID, 4, @OwnerID, 0, @PaymentID, @CommDate, 1, @CommType, @Bonus, @Bonus, 0, '', '', 1
					END
				END
			END
		END
	END
	
--	********************************************************************************************************
--	Process Matrix Bonus
--	********************************************************************************************************
	DECLARE @Level int, @RequiredTitle int, @RequiredEnrollees int, @Enrollees int, @ChildID int
	SELECT @CommType = 15, @OwnerID = @MemberID, @Level = 1

--	Process up to 9 upline members in the Matrix
	WHILE @Level <= 9 AND @OwnerID > 0
	BEGIN
--		Save the current member for the query, and initialize OwnerID to 0 to test if we found an upline parent
		SET @ChildID = @OwnerID	
		SET @OwnerID = 0
--		Get the upline member from the Compressed Matrix Downline #5
		SELECT @OwnerID = ParentID FROM Downline WHERE Line = 5 AND ChildID = @ChildID

		IF @OwnerID > 0
		BEGIN
--			Get member's title for this commission run
			SELECT @Title = Title FROM Member WHERE MemberID = @OwnerID

--			Get the required title for this level (1 char per level)
			SELECT @RequiredTitle =     CAST(SUBSTRING('222222456', @Level, 1) AS int)
--			Get the required enrollees for this level (1 char per level)
			SELECT @RequiredEnrollees = CAST(SUBSTRING('111123400', @Level, 1) AS int)
--			Get Default Bonuses (2 chars per level)
			SELECT @Bonus = CAST(SUBSTRING('000610050404030202', (@Level*2)-1, 2) AS money) 
--			Get Regional Bonuses (2 chars per level)
			IF @Title = 5 SELECT @Bonus = CAST(SUBSTRING('000610050404030100', (@Level*2)-1, 2) AS money) 
--			Get National Bonuses (2 chars per level)
			IF @Title = 6 SELECT @Bonus = CAST(SUBSTRING('000610050404030201', (@Level*2)-1, 2) AS money) 

--			Check if there is a bonus amount for this level
			IF @Bonus > 0
			BEGIN
--				Check if this member's title meets the requirement for this level
				IF @Title >= @RequiredTitle
				BEGIN
					SET @Enrollees = 0
--					Get the number of this member's enrollees if required
					IF @RequiredEnrollees > 0 EXEC pts_Downline_QualifyEnrollee @OwnerID, 2, 0, 0, @Enrollees OUTPUT
	
--					Check if this member's enrollees meets the requirement for this level
					IF @Enrollees >= @RequiredEnrollees
					BEGIN
--						CommissionID OUTPUT, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
						EXEC pts_Commission_Add @ID, @CompanyID, 4, @OwnerID, 0, @PaymentID, @CommDate, 1, @CommType, @Bonus, @Bonus, 0, '', '', 1
					END
				END 
			END
		END
		SET @Level = @Level + 1
	END
END


-- Process Monthly Commissions for retail travel
IF @CommPlan = 2 AND @ProductCode = 'TRVL' 
BEGIN
	SELECT @CommType = 21, @Bonus = 0

--	Calculate Travel Commission
--	Website Booking .............. 70%
--	Referred Booking ............. 20%
--	Certified Booking ............ 70%
--	Referred Certified Booking ... 50%
--	IATA Booking ................. 80%
--	Referred IATA Booking ........ 50%

END

GO
