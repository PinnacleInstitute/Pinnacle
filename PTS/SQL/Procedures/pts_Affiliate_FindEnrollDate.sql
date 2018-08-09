EXEC [dbo].pts_CheckProc 'pts_Affiliate_FindEnrollDate'
 GO

CREATE PROCEDURE [dbo].pts_Affiliate_FindEnrollDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
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
            ISNULL(CONVERT(nvarchar(10), af.EnrollDate, 112), '') + dbo.wtfn_FormatNumber(af.AffiliateID, 10) 'BookMark' ,
            af.AffiliateID 'AffiliateID' ,
            af.AuthUserID 'AuthUserID' ,
            af.SponsorID 'SponsorID' ,
            af.MemberID 'MemberID' ,
            af.BillingID 'BillingID' ,
            au.UserGroup 'UserGroup' ,
            au.UserStatus 'UserStatus' ,
            sp.CompanyName 'SponsorName' ,
            au.Logon 'Logon' ,
            af.CompanyName 'CompanyName' ,
            af.NameLast 'NameLast' ,
            af.NameFirst 'NameFirst' ,
            LTRIM(RTRIM(af.NameLast)) +  ', '  + LTRIM(RTRIM(af.NameFirst)) 'AffiliateName' ,
            af.Street 'Street' ,
            af.Unit 'Unit' ,
            af.City 'City' ,
            af.State 'State' ,
            af.Zip 'Zip' ,
            af.Country 'Country' ,
            af.ShipStreet 'ShipStreet' ,
            af.ShipUnit 'ShipUnit' ,
            af.ShipCity 'ShipCity' ,
            af.ShipState 'ShipState' ,
            af.ShipZip 'ShipZip' ,
            af.ShipCountry 'ShipCountry' ,
            af.Email 'Email' ,
            af.Phone1 'Phone1' ,
            af.Phone2 'Phone2' ,
            af.Fax 'Fax' ,
            af.SSN 'SSN' ,
            af.Rank 'Rank' ,
            af.MinRank 'MinRank' ,
            af.EarnedRank 'EarnedRank' ,
            af.Status 'Status' ,
            af.Newsletter 'Newsletter' ,
            af.EnrollDate 'EnrollDate' ,
            af.IsAuthorized 'IsAuthorized' ,
            af.IsCompany 'IsCompany'
FROM Affiliate AS af (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (af.AuthUserID = au.AuthUserID)
LEFT OUTER JOIN Affiliate AS sp (NOLOCK) ON (af.SponsorID = sp.AffiliateID)
WHERE ISNULL(CONVERT(nvarchar(10), af.EnrollDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), af.EnrollDate, 112), '') + dbo.wtfn_FormatNumber(af.AffiliateID, 10) <= @BookMark
ORDER BY 'Bookmark' DESC

GO