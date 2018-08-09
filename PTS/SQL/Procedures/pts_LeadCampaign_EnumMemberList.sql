EXEC [dbo].pts_CheckProc 'pts_LeadCampaign_EnumMemberList'
GO

CREATE PROCEDURE [dbo].pts_LeadCampaign_EnumMemberList
   @CompanyID int ,
   @GroupID int ,
   @GroupID1 int ,
   @GroupID2 int ,
   @GroupID3 int ,
   @CycleID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      lc.LeadCampaignID AS 'ID', 
         lc.LeadCampaignName AS 'Name'
FROM LeadCampaign AS lc (NOLOCK)
WHERE (lc.CompanyID = @CompanyID)
 AND (lc.Status = 2)
 AND (lc.PageType = 1)
 AND (((lc.GroupID = 0)
 AND (lc.IsMember <> 0))
 OR (lc.GroupID = @GroupID)
 OR ((lc.GroupID = @GroupID1)
 AND (lc.IsMember <> 0))
 OR ((lc.GroupID = @GroupID2)
 AND (lc.IsMember <> 0))
 OR ((lc.GroupID = @GroupID3)
 AND (lc.IsMember <> 0))
 OR (lc.Cycle LIKE '%'  + ',' + CAST(@CycleID AS varchar(10)) + ',' + '%'))

ORDER BY   lc.Seq , lc.LeadCampaignName

GO