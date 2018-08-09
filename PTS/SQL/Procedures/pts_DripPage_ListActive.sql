EXEC [dbo].pts_CheckProc 'pts_DripPage_ListActive'
GO

CREATE PROCEDURE [dbo].pts_DripPage_ListActive
   @DripCampaignID int
AS

SET NOCOUNT ON

SELECT      dep.DripPageID, 
         dep.Subject, 
         dep.Status, 
         dep.Days, 
         dep.IsCC
FROM DripPage AS dep (NOLOCK)
WHERE (dep.DripCampaignID = @DripCampaignID)
 AND (dep.Status = 2)

ORDER BY   dep.Days

GO