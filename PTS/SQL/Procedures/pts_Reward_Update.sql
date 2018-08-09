EXEC [dbo].pts_CheckProc 'pts_Reward_Update'
 GO

CREATE PROCEDURE [dbo].pts_Reward_Update ( 
   @RewardID int,
   @MerchantID int,
   @ConsumerID int,
   @Payment2ID int,
   @AwardID int,
   @RewardDate datetime,
   @RewardType int,
   @Amount bigint,
   @Status int,
   @HoldDate datetime,
   @Reference nvarchar (15),
   @Note nvarchar (100),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE rew
SET rew.MerchantID = @MerchantID ,
   rew.ConsumerID = @ConsumerID ,
   rew.Payment2ID = @Payment2ID ,
   rew.AwardID = @AwardID ,
   rew.RewardDate = @RewardDate ,
   rew.RewardType = @RewardType ,
   rew.Amount = @Amount ,
   rew.Status = @Status ,
   rew.HoldDate = @HoldDate ,
   rew.Reference = @Reference ,
   rew.Note = @Note
FROM Reward AS rew
WHERE rew.RewardID = @RewardID

GO