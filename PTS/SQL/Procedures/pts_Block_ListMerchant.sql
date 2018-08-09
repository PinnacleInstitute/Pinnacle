EXEC [dbo].pts_CheckProc 'pts_Block_ListMerchant'
GO

CREATE PROCEDURE [dbo].pts_Block_ListMerchant
   @MerchantID int
AS

SET NOCOUNT ON

SELECT      blo.BlockID, 
         LTRIM(RTRIM(csm.NameFirst)) +  ' '  + LTRIM(RTRIM(csm.NameLast)) AS 'ConsumerName', 
         blo.BlockDate
FROM Block AS blo (NOLOCK)
LEFT OUTER JOIN Consumer AS csm (NOLOCK) ON (blo.ConsumerID = csm.ConsumerID)
WHERE (blo.MerchantID = @MerchantID)

ORDER BY   blo.BlockDate DESC

GO