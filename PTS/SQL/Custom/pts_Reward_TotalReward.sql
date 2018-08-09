EXEC [dbo].pts_CheckProc 'pts_Reward_TotalReward'
GO

--DECLARE @Result money EXEC pts_Reward_TotalReward 1, 1, @Result output print @Result
--select * from Reward

CREATE PROCEDURE [dbo].pts_Reward_TotalReward
   @ConsumerID int ,
   @MerchantID int ,
   @Result bigint OUTPUT
AS

SET NOCOUNT ON
SET @Result = 0

IF @MerchantID = 0 
BEGIN
	SELECT @Result = SUM(Amount) / 100000000 FROM Reward WHERE ConsumerID = @ConsumerID AND RewardType = 1 AND Status = 3
END

IF @MerchantID > 0 
BEGIN
	SELECT @Result = SUM(Amount) / 100000000 FROM Reward WHERE ConsumerID = @ConsumerID AND MerchantID = @MerchantID AND RewardType = 2 AND Status = 3
END

GO