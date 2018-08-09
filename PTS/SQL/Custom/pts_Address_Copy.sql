EXEC [dbo].pts_CheckProc 'pts_Address_Copy'
GO

CREATE PROCEDURE [dbo].pts_Address_Copy
   @AddressID int ,
   @AddressType int ,
   @CopyID int OUTPUT 
AS

SET NOCOUNT ON

INSERT INTO Address (
            OwnerType , 
            OwnerID , 
            CountryID , 
            AddressType , 
            Street1 , 
            Street2 , 
            City , 
            State , 
            Zip ,
            IsActive
            )
SELECT 
            OwnerType ,
            OwnerID ,
            CountryID ,
            @AddressType ,
            Street1 ,
            Street2 ,
            City ,
            State ,
            Zip ,
            0
FROM Address 
WHERE AddressID = @AddressID

SET @CopyID = @@IDENTITY

GO