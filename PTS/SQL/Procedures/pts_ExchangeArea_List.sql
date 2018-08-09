EXEC [dbo].pts_CheckProc 'pts_ExchangeArea_List'
GO

CREATE PROCEDURE [dbo].pts_ExchangeArea_List
   @ExchangeID int
AS

SET NOCOUNT ON

SELECT      xa.ExchangeAreaID, 
         xa.State, 
         cou.CountryName AS 'CountryName'
FROM ExchangeArea AS xa (NOLOCK)
LEFT OUTER JOIN Country AS cou (NOLOCK) ON (xa.CountryID = cou.CountryID)
WHERE (xa.ExchangeID = @ExchangeID)

ORDER BY   xa.CountryID , xa.State

GO