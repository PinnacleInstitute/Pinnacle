EXEC [dbo].pts_CheckProc 'pts_Exchange_Update'
 GO

CREATE PROCEDURE [dbo].pts_Exchange_Update ( 
   @ExchangeID int,
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

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE xc
SET xc.CountryID = @CountryID ,
   xc.ExchangeName = @ExchangeName ,
   xc.NameLast = @NameLast ,
   xc.NameFirst = @NameFirst ,
   xc.Email = @Email ,
   xc.Phone = @Phone ,
   xc.Skype = @Skype ,
   xc.Status = @Status ,
   xc.Street1 = @Street1 ,
   xc.Street2 = @Street2 ,
   xc.City = @City ,
   xc.State = @State ,
   xc.Zip = @Zip ,
   xc.ActiveDate = @ActiveDate ,
   xc.Payment = @Payment
FROM Exchange AS xc
WHERE xc.ExchangeID = @ExchangeID

GO