EXEC [dbo].pts_CheckProc 'pts_Lead_FindStatusLeadDate'
 GO

CREATE PROCEDURE [dbo].pts_Lead_FindStatusLeadDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
   @Status int,
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
            ISNULL(CONVERT(nvarchar(10), ld.LeadDate, 112), '') + dbo.wtfn_FormatNumber(ld.LeadID, 10) 'BookMark' ,
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
WHERE ISNULL(CONVERT(nvarchar(10), ld.LeadDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), ld.LeadDate, 112), '') + dbo.wtfn_FormatNumber(ld.LeadID, 10) <= @BookMark
AND         (ld.MemberID = @MemberID)
AND         (ld.Status = @Status)
ORDER BY 'Bookmark' DESC

GO