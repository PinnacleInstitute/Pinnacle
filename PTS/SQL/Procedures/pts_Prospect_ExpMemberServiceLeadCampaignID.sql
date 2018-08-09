EXEC [dbo].pts_CheckProc 'pts_Prospect_ExpMemberServiceLeadCampaignID'
 GO

CREATE PROCEDURE [dbo].pts_Prospect_ExpMemberServiceLeadCampaignID ( 
   @SearchText nvarchar (10),
   @MemberID int,
   @SalesCampaignID int,
   @ProspectTypeID int,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT            pr.ProspectID 'ProspectID' ,
            pr.NameFirst 'NameFirst' ,
            pr.NameLast 'NameLast' ,
            pr.ProspectName 'ProspectName' ,
            slc.SalesCampaignName 'SalesCampaignName' ,
            pt.ProspectTypeName 'ProspectTypeName' ,
            pr.Representing 'Representing' ,
            pr.Priority 'Priority' ,
            pr.Source 'Source' ,
            pr.Title 'Title' ,
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
WHERE ISNULL(CONVERT(nvarchar(10), pr.LeadCampaignID), '') LIKE @SearchText + '%'
AND         (pr.MemberID = @MemberID)
AND         (pr.Status = 4)
AND         ((0 = @SalesCampaignID)
OR         (pr.SalesCampaignID = @SalesCampaignID))
AND         ((0 = @ProspectTypeID)
OR         (pr.ProspectTypeID = @ProspectTypeID))
ORDER BY pr.LeadCampaignID


GO