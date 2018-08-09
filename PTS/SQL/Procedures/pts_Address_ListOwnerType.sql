EXEC [dbo].pts_CheckProc 'pts_Address_ListOwnerType'
GO

CREATE PROCEDURE [dbo].pts_Address_ListOwnerType
   @OwnerType int ,
   @OwnerID int ,
   @AddressType int
AS

SET NOCOUNT ON

SELECT      ad.AddressID, 
         ad.AddressType, 
         ad.IsActive, 
         ad.Street1, 
         ad.Street2, 
         ad.City, 
         ad.State, 
         ad.Zip, 
         cou.CountryName AS 'CountryName'
FROM Address AS ad (NOLOCK)
LEFT OUTER JOIN Country AS cou (NOLOCK) ON (ad.CountryID = cou.CountryID)
WHERE (ad.OwnerType = @OwnerType)
 AND (ad.OwnerID = @OwnerID)
 AND (ad.AddressType = @AddressType)
 AND (ad.IsActive <> 0)


GO