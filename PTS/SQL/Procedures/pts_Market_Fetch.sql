EXEC [dbo].pts_CheckProc 'pts_Market_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Market_Fetch ( 
   @MarketID int,
   @CompanyID int OUTPUT,
   @CountryID int OUTPUT,
   @MarketName nvarchar (80) OUTPUT,
   @FromEmail nvarchar (60) OUTPUT,
   @Subject nvarchar (80) OUTPUT,
   @Status int OUTPUT,
   @Target nvarchar (200) OUTPUT,
   @CreateDate datetime OUTPUT,
   @SendDate datetime OUTPUT,
   @SendDays int OUTPUT,
   @Consumers int OUTPUT,
   @Merchants int OUTPUT,
   @Orgs int OUTPUT,
   @TestEmail nvarchar (80) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = mar.CompanyID ,
   @CountryID = mar.CountryID ,
   @MarketName = mar.MarketName ,
   @FromEmail = mar.FromEmail ,
   @Subject = mar.Subject ,
   @Status = mar.Status ,
   @Target = mar.Target ,
   @CreateDate = mar.CreateDate ,
   @SendDate = mar.SendDate ,
   @SendDays = mar.SendDays ,
   @Consumers = mar.Consumers ,
   @Merchants = mar.Merchants ,
   @Orgs = mar.Orgs ,
   @TestEmail = mar.TestEmail
FROM Market AS mar (NOLOCK)
WHERE mar.MarketID = @MarketID

GO