EXEC [dbo].pts_CheckProc 'pts_DripPage_List'
GO

CREATE PROCEDURE [dbo].pts_DripPage_List
   @DripCampaignID int
AS

SET NOCOUNT ON

SELECT      dep.DripPageID, 
         dep.Subject, 
         dep.Status, 
         dep.Days
FROM DripPage AS dep (NOLOCK)
WHERE (dep.DripCampaignID = @DripCampaignID)

ORDER BY   dep.Days

GO