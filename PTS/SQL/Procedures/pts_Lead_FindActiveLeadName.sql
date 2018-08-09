EXEC [dbo].pts_CheckProc 'pts_Lead_FindActiveLeadName'
 GO

CREATE PROCEDURE [dbo].pts_Lead_FindActiveLeadName ( 
   @SearchText nvarchar (62),
   @Bookmark nvarchar (72),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(LTRIM(RTRIM(ld.NameLast)) +  ', '  + LTRIM(RTRIM(ld.NameFirst)) +  '' , '') + dbo.wtfn_FormatNumber(ld.LeadID, 10) 'BookMark' ,
            ld.LeadID 'LeadID' ,
            ld.MemberID 'MemberID' ,
            ld.SalesCampaignID 'SalesCampaignID' ,
            ld.ProspectTypeID 'ProspectTypeID' ,
            sc.SalesCampaignName 'SalesCampaignName' ,
            pt.ProspectTypeName 'ProspectTypeName' ,
            ld.NameLast 'NameLast' ,
            ld.NameFirst 'NameFirst' ,
            LTRIM(RTRIM(ld.NameLast)) +  ', '  + LTRIM(RTRIM(ld.NameFirst)) +  ''  'LeadName' ,
            ld.LeadDate 'LeadDate' ,
            ld.Email 'Email' ,
            ld.Phone1 'Phone1' ,
            ld.Phone2 'Phone2' ,
            ld.Street 'Street' ,
            ld.Unit 'Unit' ,
            ld.City 'City' ,
            ld.State 'State' ,
            ld.Zip 'Zip' ,
            ld.Country 'Country' ,
            ld.Comment 'Comment' ,
            ld.Source 'Source' ,
            ld.Status 'Status' ,
            ld.Priority 'Priority' ,
            ld.CallBackDate 'CallBackDate' ,
            ld.CallBackTime 'CallBackTime' ,
            ld.TimeZone 'TimeZone' ,
            ld.BestTime 'BestTime' ,
            ld.DistributorID 'DistributorID' ,
            ld.DistributeDate 'DistributeDate' ,
            ld.Code 'Code'
FROM Lead AS ld (NOLOCK)
LEFT OUTER JOIN ProspectType AS pt (NOLOCK) ON (ld.ProspectTypeID = pt.ProspectTypeID)
LEFT OUTER JOIN SalesCampaign AS sc (NOLOCK) ON (ld.SalesCampaignID = sc.SalesCampaignID)
WHERE ISNULL(LTRIM(RTRIM(ld.NameLast)) +  ', '  + LTRIM(RTRIM(ld.NameFirst)) +  '' , '') LIKE '%' + @SearchText + '%'
AND ISNULL(LTRIM(RTRIM(ld.NameLast)) +  ', '  + LTRIM(RTRIM(ld.NameFirst)) +  '' , '') + dbo.wtfn_FormatNumber(ld.LeadID, 10) >= @BookMark
AND         (ld.MemberID = @MemberID)
AND         (ld.Status >= 1)
AND         (ld.Status <= 3)
ORDER BY 'Bookmark'

GO