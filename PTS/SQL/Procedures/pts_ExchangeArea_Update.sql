EXEC [dbo].pts_CheckProc 'pts_ExchangeArea_Update'
 GO

CREATE PROCEDURE [dbo].pts_ExchangeArea_Update ( 
   @ExchangeAreaID int,
   @ExchangeID int,
   @CountryID int,
   @State nvarchar (20),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE xa
SET xa.ExchangeID = @ExchangeID ,
   xa.CountryID = @CountryID ,
   xa.State = @State
FROM ExchangeArea AS xa
WHERE xa.ExchangeAreaID = @ExchangeAreaID

GO