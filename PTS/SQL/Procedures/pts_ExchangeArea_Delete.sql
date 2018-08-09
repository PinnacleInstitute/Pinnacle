EXEC [dbo].pts_CheckProc 'pts_ExchangeArea_Delete'
 GO

CREATE PROCEDURE [dbo].pts_ExchangeArea_Delete ( 
   @ExchangeAreaID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE xa
FROM ExchangeArea AS xa
WHERE xa.ExchangeAreaID = @ExchangeAreaID

GO