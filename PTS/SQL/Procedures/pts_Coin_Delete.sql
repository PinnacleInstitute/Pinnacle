EXEC [dbo].pts_CheckProc 'pts_Coin_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Coin_Delete ( 
   @CoinID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE coi
FROM Coin AS coi
WHERE coi.CoinID = @CoinID

GO