EXEC [dbo].pts_CheckProc 'pts_BarterArea_List'
GO

CREATE PROCEDURE [dbo].pts_BarterArea_List
   @ParentID int ,
   @CountryID int
AS

SET NOCOUNT ON

SELECT      bar.BarterAreaID, 
         bar.ParentID, 
         bar.CountryID, 
         bar.ConsumerID, 
         cou.CountryName AS 'CountryName', 
         bar.BarterAreaName, 
         bar.BarterAreaType, 
         bar.Status, 
         bar.Children
FROM BarterArea AS bar (NOLOCK)
LEFT OUTER JOIN Country AS cou (NOLOCK) ON (bar.CountryID = cou.CountryID)
WHERE (bar.ParentID = @ParentID)
 AND ((bar.ParentID <> 0)
 OR (bar.CountryID = @CountryID))

ORDER BY   bar.BarterAreaName

GO