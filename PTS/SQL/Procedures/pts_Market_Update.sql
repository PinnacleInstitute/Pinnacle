EXEC [dbo].pts_CheckProc 'pts_Market_Update'
 GO

CREATE PROCEDURE [dbo].pts_Market_Update ( 
   @MarketID int,
   @CompanyID int,
   @CountryID int,
   @MarketName nvarchar (80),
   @FromEmail nvarchar (60),
   @Subject nvarchar (80),
   @Status int,
   @Target nvarchar (200),
   @CreateDate datetime,
   @SendDate datetime,
   @SendDays int,
   @Consumers int,
   @Merchants int,
   @Orgs int,
   @TestEmail nvarchar (80),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE mar
SET mar.CompanyID = @CompanyID ,
   mar.CountryID = @CountryID ,
   mar.MarketName = @MarketName ,
   mar.FromEmail = @FromEmail ,
   mar.Subject = @Subject ,
   mar.Status = @Status ,
   mar.Target = @Target ,
   mar.CreateDate = @CreateDate ,
   mar.SendDate = @SendDate ,
   mar.SendDays = @SendDays ,
   mar.Consumers = @Consumers ,
   mar.Merchants = @Merchants ,
   mar.Orgs = @Orgs ,
   mar.TestEmail = @TestEmail
FROM Market AS mar
WHERE mar.MarketID = @MarketID

GO