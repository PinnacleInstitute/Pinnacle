EXEC [dbo].pts_CheckProc 'pts_Reward_FindConsumerConsumerID'
 GO

CREATE PROCEDURE [dbo].pts_Reward_FindConsumerConsumerID ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @ConsumerID int,
   @RewardType int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), rew.ConsumerID), '') + dbo.wtfn_FormatNumber(rew.RewardID, 10) 'BookMark' ,
            rew.RewardID 'RewardID' ,
            rew.MerchantID 'MerchantID' ,
            rew.ConsumerID 'ConsumerID' ,
            rew.Payment2ID 'Payment2ID' ,
            rew.AwardID 'AwardID' ,
            csm.NameFirst 'NameFirst' ,
            csm.NameLast 'NameLast' ,
            LTRIM(RTRIM(csm.NameFirst)) +  ' '  + LTRIM(RTRIM(csm.NameLast)) 'ConsumerName' ,
            mer.MerchantName 'MerchantName' ,
            awd.Description 'AwardName' ,
            rew.RewardDate 'RewardDate' ,
            rew.RewardType 'RewardType' ,
            rew.Amount 'Amount' ,
            LTRIM(RTRIM(rew.Amount)) 'Points' ,
            rew.Status 'Status' ,
            rew.HoldDate 'HoldDate' ,
            rew.Reference 'Reference' ,
            rew.Note 'Note'
FROM Reward AS rew (NOLOCK)
LEFT OUTER JOIN Consumer AS csm (NOLOCK) ON (rew.ConsumerID = csm.ConsumerID)
LEFT OUTER JOIN Merchant AS mer (NOLOCK) ON (rew.MerchantID = mer.MerchantID)
LEFT OUTER JOIN Award AS awd (NOLOCK) ON (rew.AwardID = awd.AwardID)
WHERE ISNULL(CONVERT(nvarchar(10), rew.ConsumerID), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), rew.ConsumerID), '') + dbo.wtfn_FormatNumber(rew.RewardID, 10) >= @BookMark
AND         (rew.ConsumerID = @ConsumerID)
AND         (rew.RewardType = @RewardType)
AND         (rew.Amount > 0)
ORDER BY 'Bookmark'

GO