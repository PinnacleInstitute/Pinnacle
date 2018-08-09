EXEC [dbo].pts_CheckProc 'pts_Exchange_Add'
 GO

CREATE PROCEDURE [dbo].pts_Exchange_Add ( 
   @ExchangeID int OUTPUT,
   @CountryID int,
   @ExchangeName nvarchar (80),
   @NameLast nvarchar (30),
   @NameFirst nvarchar (30),
   @Email nvarchar (80),
   @Phone nvarchar (30),
   @Skype nvarchar (30),
   @Status int,
   @Street1 nvarchar (60),
   @Street2 nvarchar (60),
   @City nvarchar (30),
   @State nvarchar (30),
   @Zip nvarchar (20),
   @ActiveDate datetime,
   @Payment varchar (100),
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Exchange (
            CountryID , 
            ExchangeName , 
            NameLast , 
            NameFirst , 
            Email , 
            Phone , 
            Skype , 
            Status , 
            Street1 , 
            Street2 , 
            City , 
            State , 
            Zip , 
            ActiveDate , 
            Payment
            )
VALUES (
            @CountryID ,
            @ExchangeName ,
            @NameLast ,
            @NameFirst ,
            @Email ,
            @Phone ,
            @Skype ,
            @Status ,
            @Street1 ,
            @Street2 ,
            @City ,
            @State ,
            @Zip ,
            @ActiveDate ,
            @Payment            )

SET @mNewID = @@IDENTITY

SET @ExchangeID = @mNewID

GO