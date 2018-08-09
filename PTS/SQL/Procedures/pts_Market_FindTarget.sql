EXEC [dbo].pts_CheckProc 'pts_Market_FindTarget'
 GO

CREATE PROCEDURE [dbo].pts_Market_FindTarget ( 
   @SearchText nvarchar (200),
   @Bookmark nvarchar (210),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(mar.Target, '') + dbo.wtfn_FormatNumber(mar.MarketID, 10) 'BookMark' ,
            mar.MarketID 'MarketID' ,
            mar.CompanyID 'CompanyID' ,
            mar.CountryID 'CountryID' ,
            mar.MarketName 'MarketName' ,
            mar.FromEmail 'FromEmail' ,
            mar.Subject 'Subject' ,
            mar.Status 'Status' ,
            mar.Target 'Target' ,
            mar.CreateDate 'CreateDate' ,
            mar.SendDate 'SendDate' ,
            mar.SendDays 'SendDays' ,
            mar.Consumers 'Consumers' ,
            mar.Merchants 'Merchants' ,
            mar.Orgs 'Orgs' ,
            mar.TestEmail 'TestEmail'
FROM Market AS mar (NOLOCK)
WHERE ISNULL(mar.Target, '') LIKE '%' + @SearchText + '%'
AND ISNULL(mar.Target, '') + dbo.wtfn_FormatNumber(mar.MarketID, 10) >= @BookMark
AND         (mar.CompanyID = @CompanyID)
ORDER BY 'Bookmark'

GO