EXEC [dbo].pts_CheckProc 'pts_SalesZip_Update'
 GO

CREATE PROCEDURE [dbo].pts_SalesZip_Update ( 
   @SalesZipID int,
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

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE slz
SET slz.SalesAreaID = @SalesAreaID ,
   slz.CountryID = @CountryID ,
   slz.ZipCode = @ZipCode ,
   slz.ZipName = @ZipName ,
   slz.Status = @Status ,
   slz.StatusDate = @StatusDate ,
   slz.Population = @Population
FROM SalesZip AS slz
WHERE slz.SalesZipID = @SalesZipID

GO