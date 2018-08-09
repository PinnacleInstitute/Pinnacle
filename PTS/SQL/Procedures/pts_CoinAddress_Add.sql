EXEC [dbo].pts_CheckProc 'pts_CoinAddress_Add'
 GO

CREATE PROCEDURE [dbo].pts_CoinAddress_Add ( 
   @CoinAddressID int OUTPUT,
   @MerchantID int,
   @Coin int,
   @Status int,
   @Address varchar (60),
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO CoinAddress (
            MerchantID , 
            Coin , 
            Status , 
            Address
            )
VALUES (
            @MerchantID ,
            @Coin ,
            @Status ,
            @Address            )

SET @mNewID = @@IDENTITY

SET @CoinAddressID = @mNewID

GO