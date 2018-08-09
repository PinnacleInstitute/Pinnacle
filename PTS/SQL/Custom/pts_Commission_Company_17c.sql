EXEC [dbo].pts_CheckProc 'pts_Commission_Company_17c'
GO
--DECLARE @Count int EXEC pts_Commission_Company_17c 13037, 34287, 999.95, '', @Count OUTPUT PRINT @Count

CREATE PROCEDURE [dbo].pts_Commission_Company_17c
   @MemberID int ,
   @PaymentID int ,
   @Amount money,
   @Ref varchar(100),
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @ID int, @Now datetime 
DECLARE @Bonus money, @Desc varchar(100), @CommType int, @Qualify int, @SponsorID int, @ReferralID int
DECLARE @Team int, @Title int, @cnt int, @Match int

-- If missing Reference get the member info
IF @Ref = '' SELECT @Ref = LTRIM(STR(MemberID)) + ' ' + NameFirst + ' ' + NameLast FROM Member WHERE MemberID = @MemberID

-- If missing PaymentID get the latest payment
IF @PaymentID = 0 SELECT TOP 1 @PaymentID = PaymentID FROM Payment WHERE OwnerType = 4 AND OwnerID = @MemberID ORDER BY PayDate DESC

SET @CompanyID = 17
SET @Now = GETDATE()

-- ***************************************************
-- Calculate Leadership Coded Bonuses
-- ***************************************************
SET @Team = 6
WHILE @Team <= 8
BEGIN
	SET @SponsorID = 0
	SELECT @SponsorID = ParentID FROM Downline WHERE Line = @Team AND ChildID = @MemberID
	IF @SponsorID > 0
	BEGIN
		IF @Team = 6 SET @Bonus = ROUND(@Amount * .20, 2)
		IF @Team = 7 SET @Bonus = ROUND(@Amount * .10, 2)
		IF @Team = 8 SET @Bonus = ROUND(@Amount * .05, 2)

		SELECT @Qualify = Qualify, @Title = Title, @ReferralID = ReferralID FROM Member WHERE MemberID = @SponsorID
		IF @Title < @Team SET @Qualify = 0
		
--		-- IF Member NOT Bonus Qualified, Accumulate Lost Bonus
		IF @Qualify <= 1 UPDATE Member SET Retail = Retail + @Bonus WHERE MemberID = @SponsorID

		IF @Qualify > 1
		BEGIN
			SET @CommType = 2
			SET @Desc = @Ref + ' (' + CAST(@Team AS VARCHAR(2)) + ')'
--			-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
			EXEC pts_Commission_Add @ID, @CompanyID, 4, @SponsorID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
			SET @Count = @Count + 1
			
--			******************************
--			Calculate Matching Bonuses
--			******************************
			SET @Bonus = ROUND(@Bonus * .25, 2)
			SET @Match = 1
			WHILE @Match <= 4 AND @ReferralID > 0
			BEGIN
				SET @Title = -1
				SELECT @Qualify = Qualify, @Title = Title, @SponsorID = ReferralID FROM Member WHERE MemberID = @ReferralID
--				IF we found the referrer
				IF @Title >= 0
				BEGIN
--					-- IF Member NOT Bonus Qualified, Accumulate Lost Bonus
					IF @Qualify <= 1 UPDATE Member SET Retail = Retail + @Bonus WHERE MemberID = @ReferralID
				
--					-- Check if they're qualify for the match level
					IF @Title < @Match + 4 SET @Qualify = 0

					IF @Qualify > 1
					BEGIN
						SET @CommType = 3
						SET @Desc = @Ref + ' (' + CAST( @SponsorID AS VARCHAR(10) ) + '-' + CAST(@Match AS VARCHAR(2)) + ')'
--						-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
						EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
						SET @Count = @Count + 1
					END	
					SET @ReferralID = @SponsorID
				END
				ELSE SET @ReferralID = 0
					
				SET @Match = @Match + 1
			END
		END	
	END
	SET @Team = @Team + 1
END

-- ***************************************************
-- Calculate Executive Bonuses
-- ***************************************************
SET @CommType = 4
SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID
SET @Bonus = ROUND(@Amount * .02, 2, 1)
SET @cnt = 1

SET @Team = 9
WHILE @ReferralID > 0 AND @Team <= 10
BEGIN
	SET @Title = -1
	SELECT @Qualify = Qualify, @Title = Title, @SponsorID = ReferralID FROM Member WHERE MemberID = @ReferralID
--	Did we find the referrer
	IF @Title >= 0
	BEGIN
--		-- Platinum Executive Bonus	
		IF @Title >= @Team
		BEGIN
			SET @Desc = @Ref + ' (' + CAST( @cnt AS VARCHAR(10) ) + ')'
--				-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
			EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
			SET @Count = @Count + 1
			SET @Team = @Team + 1
		END 
--		-- Palladium Executive Bonus	
		IF @Title >= @Team
		BEGIN
			SET @Desc = @Ref + ' (' + CAST( @cnt AS VARCHAR(10) ) + ')'
--				-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
			EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
			SET @Count = @Count + 1
			SET @Team = @Team + 1
		END 
		SET @ReferralID = @SponsorID
		SET @cnt = @cnt + 1
	END
	ELSE SET @ReferralID = 0
END

GO

