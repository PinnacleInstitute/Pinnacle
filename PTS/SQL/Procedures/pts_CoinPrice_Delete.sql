EXEC [dbo].pts_CheckProc 'pts_CoinPrice_Delete'
 GO

CREATE PROCEDURE [dbo].pts_CoinPrice_Delete ( 
   @CoinPriceID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE cpr
FROM CoinPrice AS cpr
WHERE cpr.CoinPriceID = @CoinPriceID

GO