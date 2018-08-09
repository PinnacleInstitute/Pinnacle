EXEC [dbo].pts_CheckProc 'pts_Folder_ListFolder'
GO

CREATE PROCEDURE [dbo].pts_Folder_ListFolder
   @CompanyID int ,
   @GroupID int ,
   @MemberID int ,
   @Entity int
AS

SET NOCOUNT ON

SELECT      fo.FolderID, 
         fo.ParentID, 
         fo.CompanyID, 
         fo.MemberID, 
         fo.DripCampaignID, 
         fo.FolderName, 
         fo.Seq, 
         fo.IsShare, 
         fo.Virtual, 
         fo.Data
FROM Folder AS fo (NOLOCK)
WHERE (fo.CompanyID = @CompanyID)
 AND (fo.Entity = @Entity)
 AND ((fo.MemberID = 0)
 OR (fo.MemberID = @MemberID)
 OR ((fo.MemberID = @GroupID)
 AND (fo.IsShare <> 0)))

ORDER BY   fo.Seq

GO