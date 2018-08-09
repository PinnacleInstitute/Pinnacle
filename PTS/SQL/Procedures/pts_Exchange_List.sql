EXEC [dbo].pts_CheckProc 'pts_Exchange_List'
GO

CREATE PROCEDURE [dbo].pts_Exchange_List
   @UserID int
AS

SET NOCOUNT ON

SELECT      xc.ExchangeID, 
         xc.ExchangeName, 
         xc.NameFirst, 
         xc.NameLast, 
         xc.City, 
         xc.State, 
         cou.CountryName AS 'CountryName', 
         xc.Status, 
         xc.ActiveDate, 
         xc.Payment
FROM Exchange AS xc (NOLOCK)
LEFT OUTER JOIN Country AS cou (NOLOCK) ON (xc.CountryID = cou.CountryID)
ORDER BY   xc.ExchangeName

GO