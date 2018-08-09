EXEC [dbo].pts_CheckProc 'pts_Prospect_FindComCustPriority'
 GO

CREATE PROCEDURE [dbo].pts_Prospect_FindComCustPriority ( 
   @SearchText nvarchar (4),
   @Bookmark nvarchar (14),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(pr.Priority, '') + dbo.wtfn_FormatNumber(pr.ProspectID, 10) 'BookMark' ,
            pr.ProspectID 'ProspectID' ,
            pr.MemberID 'MemberID' ,
            pr.NameFirst 'NameFirst' ,
            pr.NameLast 'NameLast' ,
            pr.ProspectName 'ProspectName' ,
            slc.SalesCampaignName 'SalesCampaignName' ,
            pt.ProspectTypeName 'ProspectTypeName' ,
            pr.CloseDate 'CloseDate' ,
            pr.Representing 'Representing' ,
            pr.Priority 'Priority' ,
            pr.Source 'Source' ,
            pr.Email 'Email' ,
            pr.Phone1 'Phone1' ,
            pr.Phone2 'Phone2' ,
            pr.Street 'Street' ,
            pr.Unit 'Unit' ,
            pr.City 'City' ,
            pr.State 'State' ,
            pr.Zip 'Zip' ,
            pr.Country 'Country'
FROM Prospect AS pr (NOLOCK)
LEFT OUTER JOIN SalesCampaign AS slc (NOLOCK) ON (pr.SalesCampaignID = slc.SalesCampaignID)
LEFT OUTER JOIN ProspectType AS pt (NOLOCK) ON (pr.ProspectTypeID = pt.ProspectTypeID)
WHERE ISNULL(pr.Priority, '') LIKE @SearchText + '%'
AND ISNULL(pr.Priority, '') + dbo.wtfn_FormatNumber(pr.ProspectID, 10) >= @BookMark
AND         (pr.CompanyID = @CompanyID)
AND         (pr.Status = 4)
ORDER BY 'Bookmark'

GO