EXEC [dbo].pts_CheckProc 'pts_Folder_ListVirtualFolder'
GO

--EXEC pts_Folder_ListVirtualFolder 1

CREATE PROCEDURE [dbo].pts_Folder_ListVirtualFolder
   @UserID int
AS

SET NOCOUNT ON

SELECT   fo.FolderID, 
         fo.CompanyID, 
         fo.MemberID, 
         fo.DripCampaignID, 
         fo.Virtual, 
         fo.Data
FROM Folder AS fo (NOLOCK)
JOIN DripCampaign AS dc ON fo.DripCampaignID = dc.DripCampaignID
WHERE (fo.DripCampaignID <> 0)
AND (fo.Virtual <> 0)
AND dc.Status = 2

GO