EXEC [dbo].pts_CheckProc 'pts_Address_FetchOwner'
GO

CREATE PROCEDURE [dbo].pts_Address_FetchOwner
   @OwnerType int ,
   @OwnerID int ,
   @AddressType int ,
   @AddressID int OUTPUT ,
   @CountryID int OUTPUT ,
   @CountryName nvarchar (50) OUTPUT ,
   @IsActive bit OUTPUT ,
   @Street1 nvarchar (60) OUTPUT ,
   @Street2 nvarchar (60) OUTPUT ,
   @City nvarchar (30) OUTPUT ,
   @State nvarchar (30) OUTPUT ,
   @Zip nvarchar (20) OUTPUT
AS

SET NOCOUNT ON

SELECT      @AddressID = ad.AddressID, 
         @CountryID = ad.CountryID, 
         @CountryName = cou.CountryName, 
         @IsActive = ad.IsActive, 
         @Street1 = ad.Street1, 
         @Street2 = ad.Street2, 
         @City = ad.City, 
         @State = ad.State, 
         @Zip = ad.Zip
FROM Address AS ad (NOLOCK)
LEFT OUTER JOIN Country AS cou (NOLOCK) ON (ad.CountryID = cou.CountryID)
WHERE (ad.OwnerType = @OwnerType)
 AND (ad.OwnerID = @OwnerID)
 AND (ad.AddressType = @AddressType)
 AND (ad.IsActive <> 0)


GO