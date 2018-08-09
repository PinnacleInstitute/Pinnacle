EXEC [dbo].pts_CheckProc 'pts_LeadCampaign_FindGrp'
 GO

CREATE PROCEDURE [dbo].pts_LeadCampaign_FindGrp ( 
   @SearchText varchar (25),
   @Bookmark varchar (35),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(lc.Grp, '') + dbo.wtfn_FormatNumber(lc.LeadCampaignID, 10) 'BookMark' ,
            lc.LeadCampaignID 'LeadCampaignID' ,
            lc.CompanyID 'CompanyID' ,
            lc.SalesCampaignID 'SalesCampaignID' ,
            lc.ProspectTypeID 'ProspectTypeID' ,
            lc.CycleID 'CycleID' ,
            lc.NewsLetterID 'NewsLetterID' ,
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
            lc.Grp 'Grp' ,
            lc.Page 'Page'
FROM LeadCampaign AS lc (NOLOCK)
WHERE ISNULL(lc.Grp, '') LIKE @SearchText + '%'
AND ISNULL(lc.Grp, '') + dbo.wtfn_FormatNumber(lc.LeadCampaignID, 10) >= @BookMark
AND         (lc.CompanyID = @CompanyID)
ORDER BY 'Bookmark'

GO