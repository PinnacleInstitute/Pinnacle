EXEC [dbo].pts_CheckProc 'pts_CoinAddress_Update'
 GO

CREATE PROCEDURE [dbo].pts_CoinAddress_Update ( 
   @CoinAddressID int,
   @MerchantID int,
   @Coin int,
   @Status int,
   @Address varchar (60),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE ca
SET ca.MerchantID = @MerchantID ,
   ca.Coin = @Coin ,
   ca.Status = @Status ,
   ca.Address = @Address
FROM CoinAddress AS ca
WHERE ca.CoinAddressID = @CoinAddressID

GO