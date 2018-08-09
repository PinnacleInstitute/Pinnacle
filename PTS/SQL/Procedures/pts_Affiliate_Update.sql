EXEC [dbo].pts_CheckProc 'pts_Affiliate_Update'
GO

CREATE PROCEDURE [dbo].pts_Affiliate_Update
   @AffiliateID int,
   @AuthUserID int,
   @CompanyID int,
   @MemberID int,
   @SponsorID int,
   @UserGroup int,
   @UserStatus int,
   @AffiliateName nvarchar (60),
   @NameLast nvarchar (30),
   @NameFirst nvarchar (30),
   @Street nvarchar (60),
   @Unit nvarchar (40),
   @City nvarchar (30),
   @State nvarchar (30),
   @Zip nvarchar (20),
   @Country nvarchar (30),
   @Email nvarchar (80),
   @Phone1 nvarchar (30),
   @Phone2 nvarchar (30),
   @Fax nvarchar (30),
   @SSN nvarchar (18),
   @Status int,
   @EnrollDate datetime,
   @Website varchar (80),
   @Terms nvarchar (1000),
   @LeadCampaigns varchar (50),
   @NewLogon nvarchar (80),
   @NewPassword nvarchar (30),
   @UserID int
AS

DECLARE @mNow datetime, 
         @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()
IF ((@AuthUserID > 0) AND (@UserGroup = 0))
   BEGIN
   EXEC pts_AuthUser_Delete
      @AuthUserID ,
      @UserID

   SET @AuthUserID = 0
   END

IF ((@AuthUserID > 0) AND (@UserGroup > 0))
   BEGIN
   EXEC pts_AuthUser_Update
      @AuthUserID ,
      @Email ,
      @NameLast ,
      @NameFirst ,
      @UserGroup ,
      @UserStatus ,
      @UserID

   END

IF ((@AuthUserID = 0) AND (@UserGroup > 0))
   BEGIN
   EXEC pts_AuthUser_Add
      @NewLogon ,
      @NewPassword ,
      @Email ,
      @NameLast ,
      @NameFirst ,
      @UserGroup ,
      @UserStatus ,
      @UserID ,
      @mNewID OUTPUT

   SET @AuthUserID = ISNULL(@mNewID, 0)
   END

UPDATE af
SET af.AuthUserID = @AuthUserID ,
   af.CompanyID = @CompanyID ,
   af.MemberID = @MemberID ,
   af.SponsorID = @SponsorID ,
   af.AffiliateName = @AffiliateName ,
   af.NameLast = @NameLast ,
   af.NameFirst = @NameFirst ,
   af.Street = @Street ,
   af.Unit = @Unit ,
   af.City = @City ,
   af.State = @State ,
   af.Zip = @Zip ,
   af.Country = @Country ,
   af.Email = @Email ,
   af.Phone1 = @Phone1 ,
   af.Phone2 = @Phone2 ,
   af.Fax = @Fax ,
   af.SSN = @SSN ,
   af.Status = @Status ,
   af.EnrollDate = @EnrollDate ,
   af.Website = @Website ,
   af.Terms = @Terms ,
   af.LeadCampaigns = @LeadCampaigns
FROM Affiliate AS af
WHERE (af.AffiliateID = @AffiliateID)


GO