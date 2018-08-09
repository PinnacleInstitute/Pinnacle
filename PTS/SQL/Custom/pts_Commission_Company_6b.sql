EXEC [dbo].pts_CheckProc 'pts_Commission_Company_6b'
GO

CREATE PROCEDURE [dbo].pts_Commission_Company_6b
   @PaymentID int ,
   @MemberID int ,
   @ViewerID int ,
   @Ref varchar(100) ,
   @Weekly int ,
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @Now datetime, @Today datetime, @Title int, @Qualify int, @SponsorID int, @QualifyLevel int
DECLARE @Bonus money, @Level int, @ID int, @Desc varchar(100), @EnrollDate datetime, @cnt int

SET @CompanyID = 6
SET @Count = 0
SET @Now = GETDATE()
SET @Today = dbo.wtfn_DateOnly(@Now)

-- If this is for the initial payment, set the commission date to next month on the 10th. 
IF @Weekly = 1
BEGIN
	SET @Now = DATEADD(month, 1, @Now)
	SET @Now = CAST( CAST(MONTH(@Now) AS VARCHAR(2)) + '/10/' +  CAST(YEAR(@Now) AS VARCHAR(4)) AS datetime )  
END

-- Check for Fast Start Bonus
-- Check if past first month but not second month
SELECT @EnrollDate = dbo.wtfn_DateOnly(EnrollDate) FROM Member WHERE MemberID = @ViewerID
IF @Today > DATEADD( month, 1, @EnrollDate ) AND @Today <= DATEADD( month, 2, @EnrollDate ) 
BEGIN
-- 	-- Check for 3 or more active referrals in first month
	SELECT @cnt = COUNT(*) FROM Member WHERE ReferralID = @ViewerID AND Status = 1 AND EnrollDate <= DATEADD( month, 1, @EnrollDate ) 
	IF @cnt >= 3
	BEGIN
		SET @Bonus = 50
		SET @Desc = ''
--		-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @ViewerID, 0, 0, @Now, 1, 4, @Bonus, @Bonus, 0, @Desc, '', 1
		SET @Count = @Count + 1
	END
END 

-- Process the next 9 qualified upline sponsors
SET @Bonus = 2
SET @Level = 1
WHILE @Level <= 9 AND @MemberID > 0
BEGIN
--	-- Get the sponsor's info
	SELECT @Title = Title, @Qualify = Qualify, @SponsorID = SponsorID FROM Member WHERE MemberID = @MemberID

--	-- If this sponsor is qualified to receive bonuses, otherwise skip (dynamic compression)
	IF @Qualify > 1
	BEGIN
		SET @QualifyLevel =  
		CASE @Title
			WHEN 1 THEN 7
			WHEN 2 THEN 8
			WHEN 3 THEN 9
			WHEN 4 THEN 9
			ELSE 0
		END	

--		-- If this sponsor has the required title for this level
		IF @Level <= @QualifyLevel
		BEGIN
			SET @Desc = @Ref + ' (' + CAST( @Level AS VARCHAR(2) ) + ')'
--			-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
			EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, @PaymentID, @Now, 1, 2, @Bonus, @Bonus, 0, @Desc, '', 1
			SET @Count = @Count + 1
		END 
--		-- move to next level to process, regardless if the sponsor has the required title
		SET @Level = @Level + 1				
	END 
--	-- Set the memberID to get the next upline sponsor
	SET @MemberID = @SponsorID
END

--		-- Update Payment Commission Status and date
UPDATE Payment SET CommStatus = 2, CommDate = @Today WHERE PaymentID = @PaymentID

GO
