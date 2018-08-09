EXEC [dbo].pts_CheckProc 'pts_SalesZip_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_SalesZip_Fetch ( 
   @SalesZipID int,
   @SalesAreaID int OUTPUT,
   @CountryID int OUTPUT,
   @SalesAreaName nvarchar (40) OUTPUT,
   @CountryName nvarchar (50) OUTPUT,
   @ZipCode varchar (10) OUTPUT,
   @ZipName varchar (30) OUTPUT,
   @Status int OUTPUT,
   @StatusDate datetime OUTPUT,
   @Population int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @SalesAreaID = slz.SalesAreaID ,
   @CountryID = slz.CountryID ,
   @SalesAreaName = sla.SalesAreaName ,
   @CountryName = cou.CountryName ,
   @ZipCode = slz.ZipCode ,
   @ZipName = slz.ZipName ,
   @Status = slz.Status ,
   @StatusDate = slz.StatusDate ,
   @Population = slz.Population
FROM SalesZip AS slz (NOLOCK)
LEFT OUTER JOIN SalesArea AS sla (NOLOCK) ON (slz.SalesAreaID = sla.SalesAreaID)
LEFT OUTER JOIN Country AS cou (NOLOCK) ON (slz.CountryID = cou.CountryID)
WHERE slz.SalesZipID = @SalesZipID

GO