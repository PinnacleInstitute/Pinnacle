EXEC [dbo].pts_CheckProc 'pts_Address_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Address_Fetch ( 
   @AddressID int,
   @OwnerType int OUTPUT,
   @OwnerID int OUTPUT,
   @CountryID int OUTPUT,
   @CountryName nvarchar (50) OUTPUT,
   @AddressType int OUTPUT,
   @IsActive bit OUTPUT,
   @Street1 nvarchar (60) OUTPUT,
   @Street2 nvarchar (60) OUTPUT,
   @City nvarchar (30) OUTPUT,
   @State nvarchar (30) OUTPUT,
   @Zip nvarchar (20) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @OwnerType = ad.OwnerType ,
   @OwnerID = ad.OwnerID ,
   @CountryID = ad.CountryID ,
   @CountryName = cou.CountryName ,
   @AddressType = ad.AddressType ,
   @IsActive = ad.IsActive ,
   @Street1 = ad.Street1 ,
   @Street2 = ad.Street2 ,
   @City = ad.City ,
   @State = ad.State ,
   @Zip = ad.Zip
FROM Address AS ad (NOLOCK)
LEFT OUTER JOIN Country AS cou (NOLOCK) ON (ad.CountryID = cou.CountryID)
WHERE ad.AddressID = @AddressID

GO