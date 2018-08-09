EXEC [dbo].pts_CheckProc 'pts_Prospect_FindFolderEmail'
 GO

CREATE PROCEDURE [dbo].pts_Prospect_FindFolderEmail ( 
   @SearchText nvarchar (80),
   @Bookmark nvarchar (90),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
   @FolderID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(pr.Email, '') + dbo.wtfn_FormatNumber(pr.ProspectID, 10) 'BookMark' ,
            pr.ProspectID 'ProspectID' ,
            pr.MemberID 'MemberID' ,
            slc.SalesCampaignName 'SalesCampaignName' ,
            pt.ProspectTypeName 'ProspectTypeName' ,
            LTRIM(RTRIM(pr.NameLast)) +  ', '  + LTRIM(RTRIM(pr.NameFirst)) 'ContactName' ,
            pr.Representing 'Representing' ,
            pr.NameFirst 'NameFirst' ,
            pr.NameLast 'NameLast' ,
            pr.Email 'Email' ,
            pr.Phone1 'Phone1' ,
            pr.Phone2 'Phone2' ,
            pr.Street 'Street' ,
            pr.Unit 'Unit' ,
            pr.City 'City' ,
            pr.State 'State' ,
            pr.Zip 'Zip' ,
            pr.Country 'Country' ,
            pr.Status 'Status' ,
            pr.Priority 'Priority' ,
            pr.CreateDate 'CreateDate' ,
            pr.Source 'Source' ,
            pr.NextEvent 'NextEvent' ,
            pr.NextDate 'NextDate' ,
            pr.NextTime 'NextTime' ,
            pr.TimeZone 'TimeZone' ,
            pr.BestTime 'BestTime' ,
            pr.Description 'Description'
FROM Prospect AS pr (NOLOCK)
LEFT OUTER JOIN ProspectType AS pt (NOLOCK) ON (pr.ProspectTypeID = pt.ProspectTypeID)
LEFT OUTER JOIN SalesCampaign AS slc (NOLOCK) ON (pr.SalesCampaignID = slc.SalesCampaignID)
LEFT OUTER JOIN FolderItem AS foi (NOLOCK) ON (foi.Entity = 22 and foi.ItemID = pr.ProspectID)
WHERE ISNULL(pr.Email, '') LIKE @SearchText + '%'
AND ISNULL(pr.Email, '') + dbo.wtfn_FormatNumber(pr.ProspectID, 10) >= @BookMark
AND         (pr.MemberID = @MemberID)
AND         (foi.FolderID = @FolderID)
ORDER BY 'Bookmark'

GO