EXEC [dbo].pts_CheckProc 'pts_Prospect_ExpMemberCreateDate'
 GO

CREATE PROCEDURE [dbo].pts_Prospect_ExpMemberCreateDate ( 
   @SearchText nvarchar (20),
   @MemberID int,
   @UserID int
      )
AS


SET NOCOUNT ON

IF (ISDATE(@SearchText) = 1)
            SET @SearchText = CONVERT(nvarchar(10), CONVERT(datetime, @SearchText), 112)
ELSE
            SET @SearchText = ''


SELECT            pr.ProspectID 'ProspectID' ,
            pr.NameFirst 'NameFirst' ,
            pr.NameLast 'NameLast' ,
            pr.ProspectName 'ProspectName' ,
            slc.SalesCampaignName 'SalesCampaignName' ,
            pt.ProspectTypeName 'ProspectTypeName' ,
            sls.SalesStepName 'StatusName' ,
            pr.NextEvent 'NextEvent' ,
            pr.NextDate 'NextDate' ,
            pr.NextTime 'NextTime' ,
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
LEFT OUTER JOIN SalesStep AS sls (NOLOCK) ON (pr.Status = sls.SalesStepID)
LEFT OUTER JOIN SalesCampaign AS slc (NOLOCK) ON (pr.SalesCampaignID = slc.SalesCampaignID)
LEFT OUTER JOIN ProspectType AS pt (NOLOCK) ON (pr.ProspectTypeID = pt.ProspectTypeID)
WHERE ISNULL(CONVERT(nvarchar(10), pr.CreateDate, 112), '') LIKE @SearchText + '%'
AND         (pr.MemberID = @MemberID)
AND         (pr.Status > 0)
ORDER BY pr.CreateDate


GO