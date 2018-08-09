EXEC [dbo].pts_CheckProc 'pts_Commission_Company_6a'
GO

CREATE PROCEDURE [dbo].pts_Commission_Company_6a
   @PaymentID int ,
   @MemberID int ,
   @Ref varchar(100) ,
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @Today datetime, @Title int, @Qualify int, @ReferralID int, @QualifyLevel int
DECLARE @Bonus money, @Level int, @ID int, @Desc varchar(100)

SET @CompanyID = 6
SET @Count = 0
SET @Today = GETDATE()

-- Process the next 7 qualified upline referrers
SET @Level = 1
WHILE @Level <= 7 AND @MemberID > 0
BEGIN
--	-- Get the referrer's info
	SELECT @Title = Title, @Qualify = Qualify, @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID

--	-- If this referrer is qualified to receive bonuses, otherwise skip (dynamic compression)
	IF @Qualify > 1
	BEGIN
		SET @QualifyLevel =  
		CASE @Title
			WHEN 1 THEN 5
			WHEN 2 THEN 6
			WHEN 3 THEN 7
			WHEN 4 THEN 7
			ELSE 0
		END	

--		-- If this referrer has the required title for this level
		IF @Level <= @QualifyLevel
		BEGIN
--			-- Calculate bonus amount for current level
			SET @Bonus = 
			CASE @Level
				WHEN 1 THEN 20
				WHEN 2 THEN 5
				WHEN 3 THEN 5
				WHEN 4 THEN 5
				WHEN 5 THEN 5
				WHEN 6 THEN 10
				WHEN 7 THEN 10
				ELSE 0
			END	
			SET @Desc = @Ref + ' (' + CAST( @Level AS VARCHAR(2) ) + ')'
--			-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
			EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Today, 1, 1, @Bonus, @Bonus, 0, @Desc, '', 1
--print cast(@Bonus as varchar(10)) + '  ' + cast(@MemberID as varchar(10))

			SET @Count = @Count + 1
		END 
--		-- move to next level to process, regardless if the referrer has the required title
		SET @Level = @Level + 1				
	END 
--	-- Set the memberID to get the next upline referrer
	SET @MemberID = @ReferralID
END

--		-- Update Payment Commission Status and date
UPDATE Payment SET CommStatus = 2, CommDate = @Today WHERE PaymentID = @PaymentID

GO
