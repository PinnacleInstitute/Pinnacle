EXEC [dbo].pts_CheckProc 'pts_Prospect_FindLeadStatusPriority'
 GO

CREATE PROCEDURE [dbo].pts_Prospect_FindLeadStatusPriority ( 
   @SearchText nvarchar (4),
   @Bookmark nvarchar (14),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
   @Status int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(pr.Priority, '') + dbo.wtfn_FormatNumber(pr.ProspectID, 10) 'BookMark' ,
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
WHERE ISNULL(pr.Priority, '') LIKE @SearchText + '%'
AND ISNULL(pr.Priority, '') + dbo.wtfn_FormatNumber(pr.ProspectID, 10) >= @BookMark
AND         (pr.MemberID = @MemberID)
AND         (pr.Status = @Status)
ORDER BY 'Bookmark'

GO