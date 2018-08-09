EXEC [dbo].pts_CheckProc 'pts_CoinAddress_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_CoinAddress_Fetch ( 
   @CoinAddressID int,
   @MerchantID int OUTPUT,
   @Coin int OUTPUT,
   @Status int OUTPUT,
   @Address varchar (60) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MerchantID = ca.MerchantID ,
   @Coin = ca.Coin ,
   @Status = ca.Status ,
   @Address = ca.Address
FROM CoinAddress AS ca (NOLOCK)
WHERE ca.CoinAddressID = @CoinAddressID

GO