EXEC [dbo].pts_CheckProc 'pts_ExchangeArea_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_ExchangeArea_Fetch ( 
   @ExchangeAreaID int,
   @ExchangeID int OUTPUT,
   @CountryID int OUTPUT,
   @CountryName nvarchar (50) OUTPUT,
   @State nvarchar (20) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @ExchangeID = xa.ExchangeID ,
   @CountryID = xa.CountryID ,
   @CountryName = cou.CountryName ,
   @State = xa.State
FROM ExchangeArea AS xa (NOLOCK)
LEFT OUTER JOIN Country AS cou (NOLOCK) ON (xa.CountryID = cou.CountryID)
WHERE xa.ExchangeAreaID = @ExchangeAreaID

GO