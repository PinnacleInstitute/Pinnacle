EXEC [dbo].pts_CheckProc 'pts_Affiliate_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Affiliate_Fetch ( 
   @AffiliateID int,
   @AuthUserID int OUTPUT,
   @CompanyID int OUTPUT,
   @MemberID int OUTPUT,
   @SponsorID int OUTPUT,
   @UserGroup int OUTPUT,
   @UserStatus int OUTPUT,
   @Logon nvarchar (80) OUTPUT,
   @AffiliateName nvarchar (60) OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @ContactName nvarchar (62) OUTPUT,
   @Street nvarchar (60) OUTPUT,
   @Unit nvarchar (40) OUTPUT,
   @City nvarchar (30) OUTPUT,
   @State nvarchar (30) OUTPUT,
   @Zip nvarchar (20) OUTPUT,
   @Country nvarchar (30) OUTPUT,
   @Email nvarchar (80) OUTPUT,
   @Phone1 nvarchar (30) OUTPUT,
   @Phone2 nvarchar (30) OUTPUT,
   @Fax nvarchar (30) OUTPUT,
   @SSN nvarchar (18) OUTPUT,
   @Status int OUTPUT,
   @EnrollDate datetime OUTPUT,
   @Website varchar (80) OUTPUT,
   @Terms nvarchar (1000) OUTPUT,
   @LeadCampaigns varchar (50) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @AuthUserID = af.AuthUserID ,
   @CompanyID = af.CompanyID ,
   @MemberID = af.MemberID ,
   @SponsorID = af.SponsorID ,
   @UserGroup = au.UserGroup ,
   @UserStatus = au.UserStatus ,
   @Logon = au.Logon ,
   @AffiliateName = af.AffiliateName ,
   @NameLast = af.NameLast ,
   @NameFirst = af.NameFirst ,
   @ContactName = LTRIM(RTRIM(af.NameLast)) +  ', '  + LTRIM(RTRIM(af.NameFirst)) ,
   @Street = af.Street ,
   @Unit = af.Unit ,
   @City = af.City ,
   @State = af.State ,
   @Zip = af.Zip ,
   @Country = af.Country ,
   @Email = af.Email ,
   @Phone1 = af.Phone1 ,
   @Phone2 = af.Phone2 ,
   @Fax = af.Fax ,
   @SSN = af.SSN ,
   @Status = af.Status ,
   @EnrollDate = af.EnrollDate ,
   @Website = af.Website ,
   @Terms = af.Terms ,
   @LeadCampaigns = af.LeadCampaigns
FROM Affiliate AS af (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (af.AuthUserID = au.AuthUserID)
WHERE af.AffiliateID = @AffiliateID

GO