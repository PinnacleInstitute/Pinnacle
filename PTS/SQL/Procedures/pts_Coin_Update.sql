EXEC [dbo].pts_CheckProc 'pts_Coin_Update'
 GO

CREATE PROCEDURE [dbo].pts_Coin_Update ( 
   @CoinID int,
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

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE coi
SET coi.CompanyID = @CompanyID ,
   coi.MemberID = @MemberID ,
   coi.CoinDate = @CoinDate ,
   coi.Amount = @Amount ,
   coi.Status = @Status ,
   coi.CoinType = @CoinType ,
   coi.Reference = @Reference ,
   coi.Notes = @Notes
FROM Coin AS coi
WHERE coi.CoinID = @CoinID

GO