EXEC [dbo].pts_CheckProc 'pts_Consumer_Custom'
GO

--DECLARE @Result nvarchar (1000) EXEC pts_Consumer_Custom 1, 2, 1, 0, '', @Result OUTPUT PRINT @Result
--DECLARE @Result nvarchar (1000) EXEC pts_Consumer_Custom 1, 2, 2, 0, '', @Result OUTPUT PRINT @Result
--DECLARE @Result nvarchar (1000) EXEC pts_Consumer_Custom 1, 3, 0, 0, '', @Result OUTPUT PRINT @Result

CREATE PROCEDURE [dbo].pts_Consumer_Custom
   @ConsumerID int ,
   @Status int ,
   @MemberID int ,
   @EnrollDate datetime ,
   @Email nvarchar (80) ,
   @Result nvarchar (1000) OUTPUT
AS

SET NOCOUNT ON

SET @Result = ''

DECLARE @cnt int, @Refer int, @Reward1 money, @Reward2 money, @Reward3 money, @Reward4 money 
DECLARE @ReferType int, @MerchantID int, @merchants int, @Today datetime, @ID int
SET @Today = dbo.wtfn_DateOnly(GETDATE())

-- Get total number of rewards for a shopper
IF @Status = 1
BEGIN
	SELECT @Refer = COUNT(*) FROM Consumer WHERE ReferID = @ConsumerID

	SELECT @Reward1 = ISNULL(SUM(Amount),0) FROM Reward WHERE ConsumerID = @ConsumerID AND RewardType = 1 AND Status <= 2
	SELECT @Reward2 = ISNULL(SUM(Amount),0) FROM Reward WHERE ConsumerID = @ConsumerID AND RewardType = 1 AND Status = 4
	SELECT @Reward3 = ISNULL(SUM(Amount),0) FROM Reward WHERE ConsumerID = @ConsumerID AND RewardType = 1 AND Status = 3
	SELECT @Reward4 = ISNULL(SUM(Amount),0) FROM Reward WHERE ConsumerID = @ConsumerID AND RewardType = 2 
	SET @Reward1 = @Reward1 / 100000000
	SET @Reward2 = @Reward2 / 100000000
	SET @Reward3 = @Reward3 / 100000000
	SET @Reward4 = @Reward4 / 100000000

	SET @Result = CAST(@Refer AS VARCHAR(10)) + '|' + CAST(@Reward1 AS VARCHAR(10)) + '|' + CAST(@Reward2 AS VARCHAR(10)) + '|' + CAST(@Reward3 AS VARCHAR(10)) + '|' + CAST(@Reward4 AS VARCHAR(10))
END

-- Get total number of personal and group referrals for user
IF @Status = 2
BEGIN
	SET @ReferType = @MemberID
	-- Get Consumer Referrals
	IF @ReferType = 1
	BEGIN
		SELECT @Refer = COUNT(*) FROM Consumer WHERE ConsumerID = @ConsumerID
		SET @Result = CAST(@Refer AS VARCHAR(10))
	END
	-- Get Merchant Referrals
	IF @ReferType = 2
	BEGIN
		SET @MerchantID = @ConsumerID
		SELECT @Refer = COUNT(*) FROM Consumer WHERE MerchantID = @MerchantID AND ReferID = 0
		SELECT @cnt = COUNT(*) FROM Consumer WHERE MerchantID = @MerchantID
		SET @Result = CAST(@Refer AS VARCHAR(10)) + '|' + CAST(@cnt AS VARCHAR(10))
	END
	-- Get Affiliate Referrals
	IF @ReferType = 3
	BEGIN
		SET @MemberID = @ConsumerID
		SELECT @Refer = COUNT(*) FROM Consumer WHERE MemberID = @MemberID AND ReferID = 0
		SELECT @cnt = COUNT(*) FROM Consumer WHERE MemberID = @MemberID
		-- get affiliate merchant's shopper networks
		SELECT @merchants = COUNT(*) 
		FROM Consumer AS co
		JOIN Merchant AS me ON co.MerchantID = me.MerchantID
		 WHERE me.MemberID = @MemberID
		SET @Result = CAST(@Refer AS VARCHAR(10)) + '|' + CAST(@cnt AS VARCHAR(10)) + '|' + CAST(@merchants AS VARCHAR(10))
	END
END

-- Get available rewards for a shopper
IF @Status = 3
BEGIN
	SELECT @Reward1 = ISNULL(SUM(Amount),0) FROM Reward WHERE ConsumerID = @ConsumerID AND RewardType = 1 AND Status = 3
	SET @Reward1 = @Reward1 / 100000000
	SET @Result = CAST(@Reward1 AS VARCHAR(10))
END

-- Initialize a new shopper
IF @Status = 99
BEGIN
	--	Give new shopper 5 free ad credits
	-- BarterCreditID,OwnerType,OwnerID,BarterAdID,CreditDate,Amount,Status,CreditType,StartDate,EndDate,Reference,Notes,UserID
	EXEC pts_BarterCredit_Add @ID, 151, @ConsumerID, 0, @Today, 5, 1, 1, 0, 0, 'WELCOME', '', 1
END

GO

