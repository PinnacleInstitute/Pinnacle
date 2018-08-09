EXEC [dbo].pts_CheckProc 'pts_LeadCampaign_FindGroupID'
 GO

CREATE PROCEDURE [dbo].pts_LeadCampaign_FindGroupID ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), lc.GroupID), '') + dbo.wtfn_FormatNumber(lc.LeadCampaignID, 10) 'BookMark' ,
            lc.LeadCampaignID 'LeadCampaignID' ,
            lc.CompanyID 'CompanyID' ,
            lc.SalesCampaignID 'SalesCampaignID' ,
            lc.ProspectTypeID 'ProspectTypeID' ,
            lc.CycleID 'CycleID' ,
            lc.NewsLetterID 'NewsLetterID' ,
            lc.GroupID 'GroupID' ,
            lc.FolderID 'FolderID' ,
            lc.LeadCampaignName 'LeadCampaignName' ,
            lc.Status 'Status' ,
            lc.PageType 'PageType' ,
            lc.Objective 'Objective' ,
            lc.Title 'Title' ,
            lc.Description 'Description' ,
            lc.Keywords 'Keywords' ,
            lc.IsMember 'IsMember' ,
            lc.IsAffiliate 'IsAffiliate' ,
            lc.Cycle 'Cycle' ,
            lc.CSS 'CSS' ,
            lc.NoEdit 'NoEdit' ,
            lc.Page 'Page' ,
            lc.Image 'Image' ,
            lc.Entity 'Entity' ,
            lc.Seq 'Seq'
FROM LeadCampaign AS lc (NOLOCK)
WHERE ISNULL(CONVERT(nvarchar(10), lc.GroupID), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), lc.GroupID), '') + dbo.wtfn_FormatNumber(lc.LeadCampaignID, 10) >= @BookMark
AND         (lc.CompanyID = @CompanyID)
ORDER BY 'Bookmark'

GO