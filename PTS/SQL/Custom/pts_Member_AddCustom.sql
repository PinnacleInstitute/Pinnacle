EXEC [dbo].pts_CheckProc 'pts_Member_AddCustom'
GO

CREATE PROCEDURE [dbo].pts_Member_AddCustom
   @CompanyID int,
   @MemberID int
AS

-- Get Paid To View TV
IF @CompanyID = 6
BEGIN
--	-- Set Initial Title for Affiliates
	UPDATE Member SET Title = 1 WHERE MemberID = @MemberID AND Title = 0 AND Level = 1
--	-- Remove Initial Price for Customers
	UPDATE Member SET InitPrice = 0 WHERE MemberID = @MemberID AND Level = 2
END

-- Wealth Resource Network
IF @CompanyID = 7 EXEC pts_Member_AddCustom_7 @MemberID

-- Pinnacle Sales Team
IF @CompanyID = 1
BEGIN
--	-- Advanced Membership 
	UPDATE Member SET GroupID = MemberID WHERE MemberID = @MemberID AND Level = 1 AND GroupID = 0
END

-- Pinnacle University
IF @CompanyID = 2
BEGIN
	DECLARE @PromoID int, @GoodPromo int
	SELECT @PromoID = PromoID FROM Member WHERE MemberID = @MemberID
	SET @GoodPromo = 0
	
--	-- No $149.95 enrollment fee, set bill date to one month after enroll date
--	IF @PromoID = 100
--	BEGIN
--		UPDATE Member SET PaidDate = DATEADD(m, 1, dbo.wtfn_DateOnly(EnrollDate)) WHERE MemberID = @MemberID
--	END

--	-- No $100 enrollment fee, set bill date to the enroll date
	IF @PromoID = 200
	BEGIN
		SET @GoodPromo = 1
		UPDATE Member SET PaidDate = dbo.wtfn_DateOnly(EnrollDate) WHERE MemberID = @MemberID
	END

	IF @PromoID > 0 AND @GoodPromo = 0
	BEGIN
		UPDATE Member SET PromoID = 0 WHERE MemberID = @MemberID
	END

END

GO
