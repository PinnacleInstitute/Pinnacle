EXEC [dbo].pts_CheckProc 'pts_Address_Update'
 GO

CREATE PROCEDURE [dbo].pts_Address_Update ( 
   @AddressID int,
   @OwnerType int,
   @OwnerID int,
   @CountryID int,
   @AddressType int,
   @IsActive bit,
   @Street1 nvarchar (60),
   @Street2 nvarchar (60),
   @City nvarchar (30),
   @State nvarchar (30),
   @Zip nvarchar (20),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE ad
SET ad.OwnerType = @OwnerType ,
   ad.OwnerID = @OwnerID ,
   ad.CountryID = @CountryID ,
   ad.AddressType = @AddressType ,
   ad.IsActive = @IsActive ,
   ad.Street1 = @Street1 ,
   ad.Street2 = @Street2 ,
   ad.City = @City ,
   ad.State = @State ,
   ad.Zip = @Zip
FROM Address AS ad
WHERE ad.AddressID = @AddressID

GO