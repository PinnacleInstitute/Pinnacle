EXEC [dbo].pts_CheckProc 'pts_CoinAddress_Delete'
 GO

CREATE PROCEDURE [dbo].pts_CoinAddress_Delete ( 
   @CoinAddressID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE ca
FROM CoinAddress AS ca
WHERE ca.CoinAddressID = @CoinAddressID

GO