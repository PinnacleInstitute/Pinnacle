EXEC [dbo].pts_CheckProc 'pts_Prospect_FindComCustCampTypeCreateDate'
 GO

CREATE PROCEDURE [dbo].pts_Prospect_FindComCustCampTypeCreateDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @SalesCampaignID int,
   @ProspectTypeID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20
IF (@Bookmark = '') SET @Bookmark = '99991231'
IF (ISDATE(@SearchText) = 1)
            SET @SearchText = CONVERT(nvarchar(10), CONVERT(datetime, @SearchText), 112)
ELSE
            SET @SearchText = ''


SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), pr.CreateDate, 112), '') + dbo.wtfn_FormatNumber(pr.ProspectID, 10) 'BookMark' ,
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
WHERE ISNULL(CONVERT(nvarchar(10), pr.CreateDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), pr.CreateDate, 112), '') + dbo.wtfn_FormatNumber(pr.ProspectID, 10) <= @BookMark
AND         (pr.CompanyID = @CompanyID)
AND         (pr.SalesCampaignID = @SalesCampaignID)
AND         (pr.ProspectTypeID = @ProspectTypeID)
AND         (pr.Status = 4)
ORDER BY 'Bookmark' DESC

GO