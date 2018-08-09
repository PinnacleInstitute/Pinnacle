EXEC [dbo].pts_CheckProc 'pts_SalesZip_Add'
 GO

CREATE PROCEDURE [dbo].pts_SalesZip_Add ( 
   @SalesZipID int OUTPUT,
   @SalesAreaID int,
   @CountryID int,
   @ZipCode varchar (10),
   @ZipName varchar (30),
   @Status int,
   @StatusDate datetime,
   @Population int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO SalesZip (
            SalesAreaID , 
            CountryID , 
            ZipCode , 
            ZipName , 
            Status , 
            StatusDate , 
            Population
            )
VALUES (
            @SalesAreaID ,
            @CountryID ,
            @ZipCode ,
            @ZipName ,
            @Status ,
            @StatusDate ,
            @Population            )

SET @mNewID = @@IDENTITY

SET @SalesZipID = @mNewID

GO