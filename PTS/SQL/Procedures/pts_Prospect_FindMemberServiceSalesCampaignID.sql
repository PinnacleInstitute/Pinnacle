EXEC [dbo].pts_CheckProc 'pts_Prospect_FindMemberServiceSalesCampaignID'
 GO

CREATE PROCEDURE [dbo].pts_Prospect_FindMemberServiceSalesCampaignID ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
   @Result nvarchar (20),
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), pr.SalesCampaignID), '') + dbo.wtfn_FormatNumber(pr.ProspectID, 10) 'BookMark' ,
            pr.ProspectID 'ProspectID' ,
            pr.CompanyID 'CompanyID' ,
            pr.MemberID 'MemberID' ,
            pr.SalesCampaignID 'SalesCampaignID' ,
            pr.LeadCampaignID 'LeadCampaignID' ,
            pr.PresentID 'PresentID' ,
            pr.ProspectTypeID 'ProspectTypeID' ,
            pr.EmailID 'EmailID' ,
            pr.AffiliateID 'AffiliateID' ,
            pr.NewsLetterID 'NewsLetterID' ,
            me.CompanyName 'MemberName' ,
            sls.SalesStepName 'StatusName' ,
            sls.IsBoard 'IsBoard' ,
            slc.SalesCampaignName 'SalesCampaignName' ,
            pt.ProspectTypeName 'ProspectTypeName' ,
            slc.IsCopyURL 'IsCopyURL' ,
            slc.Result 'Result' ,
            pr.ProspectName 'ProspectName' ,
            pr.Website 'Website' ,
            pr.Description 'Description' ,
            pr.Representing 'Representing' ,
            pr.Potential 'Potential' ,
            pr.NameLast 'NameLast' ,
            pr.NameFirst 'NameFirst' ,
            LTRIM(RTRIM(pr.NameLast)) +  ', '  + LTRIM(RTRIM(pr.NameFirst)) 'ContactName' ,
            pr.Title 'Title' ,
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
            pr.NextEvent 'NextEvent' ,
            pr.NextDate 'NextDate' ,
            pr.NextTime 'NextTime' ,
            pr.CreateDate 'CreateDate' ,
            pr.FBDate 'FBDate' ,
            pr.CloseDate 'CloseDate' ,
            pr.DeadDate 'DeadDate' ,
            pr.Date1 'Date1' ,
            pr.Date2 'Date2' ,
            pr.Date3 'Date3' ,
            pr.Date4 'Date4' ,
            pr.Date5 'Date5' ,
            pr.Date6 'Date6' ,
            pr.Date7 'Date7' ,
            pr.Date8 'Date8' ,
            pr.Date9 'Date9' ,
            pr.Date10 'Date10' ,
            pr.ChangeDate 'ChangeDate' ,
            pr.ChangeStatus 'ChangeStatus' ,
            pr.EmailDate 'EmailDate' ,
            pr.RSVP 'RSVP' ,
            pr.NewsLetterStatus 'NewsLetterStatus' ,
            pr.LeadViews 'LeadViews' ,
            pr.LeadPages 'LeadPages' ,
            pr.LeadReplies 'LeadReplies' ,
            pr.PresentViews 'PresentViews' ,
            pr.PresentPages 'PresentPages' ,
            pr.NoDistribute 'NoDistribute' ,
            pr.DistributorID 'DistributorID' ,
            pr.DistributeDate 'DistributeDate' ,
            pr.Priority 'Priority' ,
            pr.InputValues 'InputValues'
FROM Prospect AS pr (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (pr.MemberID = me.MemberID)
LEFT OUTER JOIN ProspectType AS pt (NOLOCK) ON (pr.ProspectTypeID = pt.ProspectTypeID)
LEFT OUTER JOIN SalesStep AS sls (NOLOCK) ON (pr.Status = sls.SalesStepID)
LEFT OUTER JOIN SalesCampaign AS slc (NOLOCK) ON (pr.SalesCampaignID = slc.SalesCampaignID)
WHERE ISNULL(CONVERT(nvarchar(10), pr.SalesCampaignID), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), pr.SalesCampaignID), '') + dbo.wtfn_FormatNumber(pr.ProspectID, 10) >= @BookMark
AND         (pr.MemberID = @MemberID)
AND         (slc.Result = @Result)
AND         (pr.Status = 4)
ORDER BY 'Bookmark'

GO