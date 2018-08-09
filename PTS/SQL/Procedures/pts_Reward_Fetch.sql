EXEC [dbo].pts_CheckProc 'pts_Reward_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Reward_Fetch ( 
   @RewardID int,
   @MerchantID int OUTPUT,
   @ConsumerID int OUTPUT,
   @Payment2ID int OUTPUT,
   @AwardID int OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @ConsumerName nvarchar (62) OUTPUT,
   @MerchantName nvarchar (80) OUTPUT,
   @AwardName nvarchar (100) OUTPUT,
   @RewardDate datetime OUTPUT,
   @RewardType int OUTPUT,
   @Amount bigint OUTPUT,
   @Points money OUTPUT,
   @Status int OUTPUT,
   @HoldDate datetime OUTPUT,
   @Reference nvarchar (15) OUTPUT,
   @Note nvarchar (100) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MerchantID = rew.MerchantID ,
   @ConsumerID = rew.ConsumerID ,
   @Payment2ID = rew.Payment2ID ,
   @AwardID = rew.AwardID ,
   @NameFirst = csm.NameFirst ,
   @NameLast = csm.NameLast ,
   @ConsumerName = LTRIM(RTRIM(csm.NameFirst)) +  ' '  + LTRIM(RTRIM(csm.NameLast)) ,
   @MerchantName = mer.MerchantName ,
   @AwardName = awd.Description ,
   @RewardDate = rew.RewardDate ,
   @RewardType = rew.RewardType ,
   @Amount = rew.Amount ,
   @Points = LTRIM(RTRIM(rew.Amount)) ,
   @Status = rew.Status ,
   @HoldDate = rew.HoldDate ,
   @Reference = rew.Reference ,
   @Note = rew.Note
FROM Reward AS rew (NOLOCK)
LEFT OUTER JOIN Consumer AS csm (NOLOCK) ON (rew.ConsumerID = csm.ConsumerID)
LEFT OUTER JOIN Merchant AS mer (NOLOCK) ON (rew.MerchantID = mer.MerchantID)
LEFT OUTER JOIN Award AS awd (NOLOCK) ON (rew.AwardID = awd.AwardID)
WHERE rew.RewardID = @RewardID

GO