EXEC [dbo].pts_CheckProc 'pts_Coin_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Coin_Fetch ( 
   @CoinID int,
   @CompanyID int OUTPUT,
   @MemberID int OUTPUT,
   @CoinDate datetime OUTPUT,
   @Amount money OUTPUT,
   @Status int OUTPUT,
   @CoinType int OUTPUT,
   @Reference varchar (30) OUTPUT,
   @Notes varchar (500) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = coi.CompanyID ,
   @MemberID = coi.MemberID ,
   @CoinDate = coi.CoinDate ,
   @Amount = coi.Amount ,
   @Status = coi.Status ,
   @CoinType = coi.CoinType ,
   @Reference = coi.Reference ,
   @Notes = coi.Notes
FROM Coin AS coi (NOLOCK)
WHERE coi.CoinID = @CoinID

GO