EXEC [dbo].pts_CheckProc 'pts_Exchange_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Exchange_Fetch ( 
   @ExchangeID int,
   @CountryID int OUTPUT,
   @CountryName nvarchar (50) OUTPUT,
   @ExchangeName nvarchar (80) OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @Email nvarchar (80) OUTPUT,
   @Phone nvarchar (30) OUTPUT,
   @Skype nvarchar (30) OUTPUT,
   @Status int OUTPUT,
   @Street1 nvarchar (60) OUTPUT,
   @Street2 nvarchar (60) OUTPUT,
   @City nvarchar (30) OUTPUT,
   @State nvarchar (30) OUTPUT,
   @Zip nvarchar (20) OUTPUT,
   @ActiveDate datetime OUTPUT,
   @Payment varchar (100) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CountryID = xc.CountryID ,
   @CountryName = cou.CountryName ,
   @ExchangeName = xc.ExchangeName ,
   @NameLast = xc.NameLast ,
   @NameFirst = xc.NameFirst ,
   @Email = xc.Email ,
   @Phone = xc.Phone ,
   @Skype = xc.Skype ,
   @Status = xc.Status ,
   @Street1 = xc.Street1 ,
   @Street2 = xc.Street2 ,
   @City = xc.City ,
   @State = xc.State ,
   @Zip = xc.Zip ,
   @ActiveDate = xc.ActiveDate ,
   @Payment = xc.Payment
FROM Exchange AS xc (NOLOCK)
LEFT OUTER JOIN Country AS cou (NOLOCK) ON (xc.CountryID = cou.CountryID)
WHERE xc.ExchangeID = @ExchangeID

GO