EXEC [dbo].pts_CheckProc 'pts_Coin_Add'
 GO

CREATE PROCEDURE [dbo].pts_Coin_Add ( 
   @CoinID int OUTPUT,
   @CompanyID int,
   @MemberID int,
   @CoinDate datetime,
   @Amount money,
   @Status int,
   @CoinType int,
   @Reference varchar (30),
   @Notes varchar (500),
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Coin (
            CompanyID , 
            MemberID , 
            CoinDate , 
            Amount , 
            Status , 
            CoinType , 
            Reference , 
            Notes
            )
VALUES (
            @CompanyID ,
            @MemberID ,
            @CoinDate ,
            @Amount ,
            @Status ,
            @CoinType ,
            @Reference ,
            @Notes            )

SET @mNewID = @@IDENTITY

SET @CoinID = @mNewID

GO