EXEC [dbo].pts_CheckProc 'pts_Exchange_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Exchange_Delete ( 
   @ExchangeID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE xc
FROM Exchange AS xc
WHERE xc.ExchangeID = @ExchangeID

GO