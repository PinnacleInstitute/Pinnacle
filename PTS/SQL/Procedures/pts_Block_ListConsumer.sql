EXEC [dbo].pts_CheckProc 'pts_Block_ListConsumer'
GO

CREATE PROCEDURE [dbo].pts_Block_ListConsumer
   @ConsumerID int
AS

SET NOCOUNT ON

SELECT      blo.BlockID, 
         mer.MerchantName AS 'MerchantName', 
         blo.BlockDate
FROM Block AS blo (NOLOCK)
LEFT OUTER JOIN Merchant AS mer (NOLOCK) ON (blo.MerchantID = mer.MerchantID)
WHERE (blo.ConsumerID = @ConsumerID)

ORDER BY   blo.BlockDate DESC

GO