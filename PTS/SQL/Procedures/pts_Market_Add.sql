EXEC [dbo].pts_CheckProc 'pts_Market_Add'
 GO

CREATE PROCEDURE [dbo].pts_Market_Add ( 
   @MarketID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Market (
            CompanyID , 
            CountryID , 
            MarketName , 
            FromEmail , 
            Subject , 
            Status , 
            Target , 
            CreateDate , 
            SendDate , 
            SendDays , 
            Consumers , 
            Merchants , 
            Orgs , 
            TestEmail
            )
VALUES (
            @CompanyID ,
            @CountryID ,
            @MarketName ,
            @FromEmail ,
            @Subject ,
            @Status ,
            @Target ,
            @CreateDate ,
            @SendDate ,
            @SendDays ,
            @Consumers ,
            @Merchants ,
            @Orgs ,
            @TestEmail            )

SET @mNewID = @@IDENTITY

SET @MarketID = @mNewID

GO