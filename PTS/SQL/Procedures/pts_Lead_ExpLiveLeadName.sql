EXEC [dbo].pts_CheckProc 'pts_Lead_ExpLiveLeadName'
 GO

CREATE PROCEDURE [dbo].pts_Lead_ExpLiveLeadName ( 
   @SearchText nvarchar (62),
   @MemberID int,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT            ld.LeadID 'LeadID' ,
            ld.NameFirst 'NameFirst' ,
            ld.NameLast 'NameLast' ,
            sc.SalesCampaignName 'SalesCampaignName' ,
            pt.ProspectTypeName 'ProspectTypeName' ,
            ld.Status 'Status' ,
            ld.Priority 'Priority' ,
            ld.LeadDate 'LeadDate' ,
            ld.Source 'Source' ,
            ld.CallBackDate 'CallBackDate' ,
            ld.CallBackTime 'CallBackTime' ,
            ld.TimeZone 'TimeZone' ,
            ld.BestTime 'BestTime' ,
            ld.Email 'Email' ,
            ld.Phone1 'Phone1' ,
            ld.Phone2 'Phone2' ,
            ld.Street 'Street' ,
            ld.Unit 'Unit' ,
            ld.City 'City' ,
            ld.State 'State' ,
            ld.Zip 'Zip' ,
            ld.Country 'Country'
FROM Lead AS ld (NOLOCK)
LEFT OUTER JOIN ProspectType AS pt (NOLOCK) ON (ld.ProspectTypeID = pt.ProspectTypeID)
LEFT OUTER JOIN SalesCampaign AS sc (NOLOCK) ON (ld.SalesCampaignID = sc.SalesCampaignID)
WHERE ISNULL(LTRIM(RTRIM(ld.NameLast)) +  ', '  + LTRIM(RTRIM(ld.NameFirst)) +  '' , '') LIKE '%' + @SearchText + '%'
AND         (ld.MemberID = @MemberID)
AND         (ld.Status <= 5)
ORDER BY LTRIM(RTRIM(ld.NameLast)) +  ', '  + LTRIM(RTRIM(ld.NameFirst)) +  '' 


GO