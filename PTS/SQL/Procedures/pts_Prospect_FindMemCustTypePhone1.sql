EXEC [dbo].pts_CheckProc 'pts_Prospect_FindMemCustTypePhone1'
 GO

CREATE PROCEDURE [dbo].pts_Prospect_FindMemCustTypePhone1 ( 
   @SearchText nvarchar (30),
   @Bookmark nvarchar (40),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
   @ProspectTypeID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(pr.Phone1, '') + dbo.wtfn_FormatNumber(pr.ProspectID, 10) 'BookMark' ,
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
WHERE ISNULL(pr.Phone1, '') LIKE @SearchText + '%'
AND ISNULL(pr.Phone1, '') + dbo.wtfn_FormatNumber(pr.ProspectID, 10) >= @BookMark
AND         (pr.MemberID = @MemberID)
AND         (pr.ProspectTypeID = @ProspectTypeID)
AND         (pr.Status = 4)
ORDER BY 'Bookmark'

GO