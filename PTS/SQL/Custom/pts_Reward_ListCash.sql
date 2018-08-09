EXEC [dbo].pts_CheckProc 'pts_Reward_ListCash'
GO

--EXEC pts_Reward_ListCash 1

CREATE PROCEDURE [dbo].pts_Reward_ListCash
   @ConsumerID int
AS

SET NOCOUNT ON

SELECT TOP 5 rew.RewardID, 
         mer.MerchantName AS 'MerchantName', 
         rew.RewardDate, 
         rew.RewardType, 
         rew.Amount, 
         rew.Status, 
         rew.HoldDate, 
         rew.Reference, 
         rew.Note
FROM Reward AS rew (NOLOCK)
LEFT OUTER JOIN Merchant AS mer (NOLOCK) ON (rew.MerchantID = mer.MerchantID)
WHERE rew.ConsumerID = @ConsumerID AND RewardType = 1
ORDER BY rew.RewardDate DESC

GO