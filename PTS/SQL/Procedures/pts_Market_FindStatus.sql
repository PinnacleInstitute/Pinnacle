EXEC [dbo].pts_CheckProc 'pts_Market_FindStatus'
 GO

CREATE PROCEDURE [dbo].pts_Market_FindStatus ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), mar.Status), '') + dbo.wtfn_FormatNumber(mar.MarketID, 10) 'BookMark' ,
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
WHERE ISNULL(CONVERT(nvarchar(10), mar.Status), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), mar.Status), '') + dbo.wtfn_FormatNumber(mar.MarketID, 10) >= @BookMark
AND         (mar.CompanyID = @CompanyID)
ORDER BY 'Bookmark'

GO