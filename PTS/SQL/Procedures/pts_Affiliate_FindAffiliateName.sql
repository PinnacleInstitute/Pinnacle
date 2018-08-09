EXEC [dbo].pts_CheckProc 'pts_Affiliate_FindAffiliateName'
 GO

CREATE PROCEDURE [dbo].pts_Affiliate_FindAffiliateName ( 
   @SearchText nvarchar (60),
   @Bookmark nvarchar (70),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(af.AffiliateName, '') + dbo.wtfn_FormatNumber(af.AffiliateID, 10) 'BookMark' ,
            af.AffiliateID 'AffiliateID' ,
            af.AuthUserID 'AuthUserID' ,
            af.CompanyID 'CompanyID' ,
            af.MemberID 'MemberID' ,
            af.SponsorID 'SponsorID' ,
            au.UserGroup 'UserGroup' ,
            au.UserStatus 'UserStatus' ,
            au.Logon 'Logon' ,
            af.AffiliateName 'AffiliateName' ,
            af.NameLast 'NameLast' ,
            af.NameFirst 'NameFirst' ,
            LTRIM(RTRIM(af.NameLast)) +  ', '  + LTRIM(RTRIM(af.NameFirst)) 'ContactName' ,
            af.Street 'Street' ,
            af.Unit 'Unit' ,
            af.City 'City' ,
            af.State 'State' ,
            af.Zip 'Zip' ,
            af.Country 'Country' ,
            af.Email 'Email' ,
            af.Phone1 'Phone1' ,
            af.Phone2 'Phone2' ,
            af.Fax 'Fax' ,
            af.SSN 'SSN' ,
            af.Status 'Status' ,
            af.EnrollDate 'EnrollDate' ,
            af.Website 'Website' ,
            af.Terms 'Terms' ,
            af.LeadCampaigns 'LeadCampaigns'
FROM Affiliate AS af (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (af.AuthUserID = au.AuthUserID)
WHERE ISNULL(af.AffiliateName, '') LIKE @SearchText + '%'
AND ISNULL(af.AffiliateName, '') + dbo.wtfn_FormatNumber(af.AffiliateID, 10) >= @BookMark
AND         (af.CompanyID = @CompanyID)
ORDER BY 'Bookmark'

GO