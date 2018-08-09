EXEC [dbo].pts_CheckProc 'pts_Reward_ListPointsSummary'
GO

--EXEC pts_Reward_ListPointsSummary 1

CREATE PROCEDURE [dbo].pts_Reward_ListPointsSummary
   @ConsumerID int
AS

SET NOCOUNT ON

SELECT  rew.MerchantID, 
        mer.MerchantName AS 'MerchantName', 
		MIN(rew.RewardID) As 'RewardID', 
        SUM(rew.Amount) AS 'Points'
FROM Reward AS rew (NOLOCK)
LEFT OUTER JOIN Merchant AS mer (NOLOCK) ON (rew.MerchantID = mer.MerchantID)
WHERE rew.ConsumerID = @ConsumerID AND rew.RewardType = 2
GROUP BY rew.MerchantID, mer.MerchantName
ORDER BY Points DESC

GO
