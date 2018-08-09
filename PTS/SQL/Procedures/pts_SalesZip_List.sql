EXEC [dbo].pts_CheckProc 'pts_SalesZip_List'
GO

CREATE PROCEDURE [dbo].pts_SalesZip_List
   @SalesAreaID int
AS

SET NOCOUNT ON

SELECT      slz.SalesZipID, 
         slz.SalesAreaID, 
         slz.CountryID, 
         sla.SalesAreaName AS 'SalesAreaName', 
         cou.CountryName AS 'CountryName', 
         slz.ZipCode, 
         slz.ZipName, 
         slz.Status, 
         slz.StatusDate, 
         slz.Population
FROM SalesZip AS slz (NOLOCK)
LEFT OUTER JOIN SalesArea AS sla (NOLOCK) ON (slz.SalesAreaID = sla.SalesAreaID)
LEFT OUTER JOIN Country AS cou (NOLOCK) ON (slz.CountryID = cou.CountryID)
WHERE (slz.SalesAreaID = @SalesAreaID)

ORDER BY   slz.ZipCode

GO