EXEC [dbo].pts_CheckProc 'pts_CoinPrice_Add'
 GO

CREATE PROCEDURE [dbo].pts_CoinPrice_Add ( 
   @CoinPriceID int OUTPUT,
   @Coin int,
   @Source int,
   @Price money,
   @PriceDate datetime,
   @CurrencyCode varchar (3),
   @Status int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO CoinPrice (
            Coin , 
            Source , 
            Price , 
            PriceDate , 
            CurrencyCode , 
            Status
            )
VALUES (
            @Coin ,
            @Source ,
            @Price ,
            @PriceDate ,
            @CurrencyCode ,
            @Status            )

SET @mNewID = @@IDENTITY

SET @CoinPriceID = @mNewID

GO