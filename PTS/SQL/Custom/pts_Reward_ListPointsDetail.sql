EXEC [dbo].pts_CheckProc 'pts_Reward_ListPointsDetail'
GO

CREATE PROCEDURE [dbo].pts_Reward_ListPointsDetail
   @ConsumerID int ,
   @MerchantID int
AS

SET NOCOUNT ON

SELECT   rew.RewardID, 
         mer.MerchantName AS 'MerchantName', 
         rew.RewardDate, 
         rew.RewardType, 
         rew.Amount AS 'Points', 
         rew.Status, 
         rew.HoldDate, 
         rew.Reference, 
         rew.Note
FROM Reward AS rew (NOLOCK)
LEFT OUTER JOIN Merchant AS mer (NOLOCK) ON (rew.MerchantID = mer.MerchantID)
ORDER BY   rew.RewardDate DESC

GO