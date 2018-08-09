EXEC [dbo].pts_CheckProc 'pts_CoinAddress_List'
GO

CREATE PROCEDURE [dbo].pts_CoinAddress_List
   @MerchantID int
AS

SET NOCOUNT ON

SELECT      ca.CoinAddressID, 
         ca.Coin, 
         ca.Status, 
         ca.Address
FROM CoinAddress AS ca (NOLOCK)
WHERE (ca.MerchantID = @MerchantID)

ORDER BY   ca.Coin

GO