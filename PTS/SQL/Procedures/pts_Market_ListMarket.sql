EXEC [dbo].pts_CheckProc 'pts_Market_ListMarket'
GO

CREATE PROCEDURE [dbo].pts_Market_ListMarket
   @CompanyID int ,
   @SendDate datetime
AS

SET NOCOUNT ON

SELECT      mar.MarketID, 
         mar.CountryID, 
         mar.MarketName, 
         mar.FromEmail, 
         mar.Subject, 
         mar.Target, 
         mar.SendDate, 
         mar.SendDays
FROM Market AS mar (NOLOCK)
WHERE (mar.CompanyID = @CompanyID)
 AND (mar.Status = 2)
 AND (mar.SendDate <= @SendDate)


GO