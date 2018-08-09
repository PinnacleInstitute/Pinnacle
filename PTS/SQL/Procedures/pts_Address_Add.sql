EXEC [dbo].pts_CheckProc 'pts_Address_Add'
 GO

CREATE PROCEDURE [dbo].pts_Address_Add ( 
   @AddressID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Address (
            OwnerType , 
            OwnerID , 
            CountryID , 
            AddressType , 
            IsActive , 
            Street1 , 
            Street2 , 
            City , 
            State , 
            Zip
            )
VALUES (
            @OwnerType ,
            @OwnerID ,
            @CountryID ,
            @AddressType ,
            @IsActive ,
            @Street1 ,
            @Street2 ,
            @City ,
            @State ,
            @Zip            )

SET @mNewID = @@IDENTITY

SET @AddressID = @mNewID

GO