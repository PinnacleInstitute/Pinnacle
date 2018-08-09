EXEC [dbo].pts_CheckProc 'pts_Reward_PaymentRewards'
GO

--select * from Reward where payment2id = 160
--select * from payment2 where payment2id = 171
--update payment2 set status = 0, commstatus = 1 where payment2id = 171
--delete reward where payment2id = 158
--select * from commission order by commissionid desc

--DECLARE  @Result varchar(300) EXEC pts_Reward_PaymentRewards 156, @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_Reward_PaymentRewards
   @Payment2ID int ,
   @Result varchar(300) OUTPUT
AS
select * from payment2
SET NOCOUNT ON
SET @Result = ''

DECLARE @NXCPrice money, @ID int, @Note VARCHAR(100), @RewardType int, @RewardStatus int, @HoldDate datetime, @Today datetime, @IsAwards int  
DECLARE @MerchantID int, @ConsumerID int, @AwardID int, @PayDate datetime, @PayType int, @Status int, @Amount money, @Coin bigint

DECLARE @TotalAmount money, @NetAmount money, @Merchant money, @Cashback money, @Fee money, @PayCoins bigint, @PayRate money
DECLARE @Done int, @tmpCashback money, @RewardAmount money, @AwardAmount money, @Factor money

DECLARE @msgRewards money, @msgAwards money, @msgRedeem money, @msgTotalRewards money, @msgTotalAwards money 
DECLARE @msgConsumerName varchar(30), @msgConsumerEmail varchar(80), @msgMerchantName varchar(80), @Messages int  

SET @msgRewards = 0
SET @msgAwards = 0 
SET @msgRedeem = 0
SET @msgTotalRewards = 0 
SET @msgTotalAwards = 0 
SET @msgConsumerName = ''
SET @msgConsumerEmail = ''
SET @msgMerchantName = ''

EXEC pts_CoinPrice_GetPrice 2, 'USD', @NXCPrice OUTPUT
IF @NXCPrice = 0 SET @NXCPrice = .1
SET @HoldDate = 0
SET @RewardType = 1
SET @RewardStatus = 3
SET @IsAwards = 0
SET @Today = dbo.wtfn_DateOnly( GETDATE() )

--Check if we have already created rewards for this payment
SELECT @Done = COUNT(*) FROM Reward WHERE Payment2ID = @Payment2ID

-- Get Payment Info
SELECT @MerchantID = MerchantID, @ConsumerID = ConsumerID, @AwardID = AwardID, @PayDate = PayDate, @PayType = PayType, @Status = Status, 
@TotalAmount = Total, @NetAmount = Amount, @Merchant = Merchant, @Cashback = Cashback, @Fee = Fee, @PayCoins = PayCoins, @PayRate = PayRate
FROM Payment2 WHERE Payment2ID = @Payment2ID

IF @Done > 0
BEGIN
	-- Rewards have already been created, so calculate what the NXCPrice was then
	SELECT @Coin = Amount FROM Reward WHERE Payment2ID = @Payment2ID AND RewardType = 1 AND Amount > 0
	SET @tmpCashback = @CashBack
	SET @Amount = @Coin / 100000000.0 --Convert from satoshi
	IF @PayType = 1 SET @tmpCashback = @tmpCashback * .9
	SET @NXCPrice = @tmpCashback / @Amount
END

-- Get Merchant Info
SELECT @IsAwards = IsAwards, @msgMerchantName = MerchantName FROM Merchant WHERE MerchantID = @MerchantID

-- Get Consumer Info
SELECT @msgConsumerName = NameFirst, @msgConsumerEmail = Email2, @Messages = Messages FROM Consumer WHERE ConsumerID = @ConsumerID
IF @Messages IN (2,4) SET @msgConsumerEmail = ''

-- Set Status to Approved for Crypto payments
IF @PayType > 2 AND @Status <> 3 
BEGIN
	SET @Status = 3
	IF @Done = 0 UPDATE Payment2 SET Status = @Status WHERE  Payment2ID = @Payment2ID  
END

-- IF Redeemed Rewards then Debit Reward points (PayType 2 = Credit)
IF @PayType = 2
BEGIN
	SET @Coin = @PayCoins * -1
	SET @msgRedeem = @Coin / 100000000.0  --Convert from satoshi
	SET @Note = CAST(@TotalAmount AS VARCHAR(20)) + ' / ' + CAST(@PayRate AS VARCHAR(20)) 
	-- RewardID,MerchantID,ConsumerID,Payment2ID,AwardID,RewardDate,RewardType,Amount,Status,HoldDate,Reference,Note,UserID
	IF @Done = 0 EXEC pts_Reward_Add @ID, @MerchantID, @ConsumerID, @Payment2ID, @AwardID, @PayDate, @RewardType, @Coin, @RewardStatus, @HoldDate, '', @Note, 1
END

-- Calculate number of Reward Coins
SET @Amount = ROUND( @Cashback / @NXCPrice, 8 )
SET @Note = ''

-- IF Cash Reward give 90% coins and set 30 day hold (PayType 1 = Cash)
IF @PayType = 1
BEGIN
	SET @RewardStatus = 1
-- DISABLE THESE LIMITS TEMPORARILY
--	SET @Amount = @Amount * .9
--	SET @HoldDate = DATEADD( d, 30, @Today)
	SET @Note = 'Cash'
END
SET @msgRewards = @Amount

SET @Coin = @Amount * 100000000   --Convert to satoshi
-- Create Cashback Reward Points
-- RewardID,MerchantID,ConsumerID,Payment2ID,AwardID,RewardDate,RewardType,Amount,Status,HoldDate,Reference,Note,UserID
IF @Done = 0 EXEC pts_Reward_Add @ID, @MerchantID, @ConsumerID, @Payment2ID, @AwardID, @PayDate, @RewardType, @Coin, @RewardStatus, @HoldDate, '', @Note, 1

IF @IsAwards = 1
BEGIN
	SET @Factor = 1
	IF @AwardID > 0
	BEGIN
		SELECT @RewardAmount = Amount, @AwardAmount = Award FROM Award WHERE AwardID = @AwardID
		SET @Factor = @AwardAmount / @RewardAmount
	END
	SET @RewardType = 2
	SET @RewardStatus = 3
	SET @Amount = ROUND( @Cashback * @Factor, 2 )
	SET @msgAwards = @Amount
	SET @Coin = @Amount * 100000000 -- Convert to satoshi
	SET @HoldDate = 0
	-- RewardID,MerchantID,ConsumerID,Payment2ID,AwardID,RewardDate,RewardType,Amount,Status,HoldDate,Reference,Note,UserID
	IF @Done = 0 EXEC pts_Reward_Add @ID, @MerchantID, @ConsumerID, @Payment2ID, @AwardID, @PayDate, @RewardType, @Coin, @RewardStatus, @HoldDate, '', @Note, 1
END

-- Post Payment2 Processing if approved payment
IF @Done = 0 AND @Status = 3 EXEC pts_Nexxus_Payment2Post @Payment2ID, @Result OUTPUT 

-- Get Rewards & Awards Totals
SELECT @Coin = ISNULL(SUM(Amount),0) FROM Reward WHERE ConsumerID = @ConsumerID AND RewardType = 1 
SET @msgTotalRewards = @Coin / 100000000.0 -- convert from satoshi
SELECT @Coin = ISNULL(SUM(Amount),0) FROM Reward WHERE ConsumerID = @ConsumerID AND RewardType = 2 
SET @msgTotalAwards = @Coin / 100000000.0   -- convert from satoshi

SET @Result = CAST(@msgRewards AS VARCHAR(20)) + '|' + CAST(@msgAwards AS VARCHAR(20)) + '|' + CAST(@msgRedeem AS VARCHAR(20)) + '|' + 
CAST(@msgTotalRewards AS VARCHAR(20)) + '|' + CAST(@msgTotalAwards AS VARCHAR(20)) + '|' + @msgConsumerName + '|' + @msgConsumerEmail + '|' + @msgMerchantName

GO