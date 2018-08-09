EXEC [dbo].pts_CheckProc 'pts_Affiliate_Add'
GO

CREATE PROCEDURE [dbo].pts_Affiliate_Add
   @AffiliateID int OUTPUT,
   @AuthUserID int OUTPUT,
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
         @mNewID int, 
         @mAuthUserID int, 
         @mMemberID int

SET NOCOUNT ON

SET @mNow = GETDATE()
SET @mAuthUserID = 0
SET @mMemberID = 0
IF ((@UserGroup > 0))
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
      @mAuthUserID OUTPUT

   END

INSERT INTO Affiliate (
            AuthUserID , 
            CompanyID , 
            MemberID , 
            SponsorID , 
            AffiliateName , 
            NameLast , 
            NameFirst , 
            Street , 
            Unit , 
            City , 
            State , 
            Zip , 
            Country , 
            Email , 
            Phone1 , 
            Phone2 , 
            Fax , 
            SSN , 
            Status , 
            EnrollDate , 
            Website , 
            Terms , 
            LeadCampaigns

            )
VALUES (
            @mAuthUserID ,
            @CompanyID ,
            @MemberID ,
            @SponsorID ,
            @AffiliateName ,
            @NameLast ,
            @NameFirst ,
            @Street ,
            @Unit ,
            @City ,
            @State ,
            @Zip ,
            @Country ,
            @Email ,
            @Phone1 ,
            @Phone2 ,
            @Fax ,
            @SSN ,
            @Status ,
            @EnrollDate ,
            @Website ,
            @Terms ,
            @LeadCampaigns
            )

SET @mNewID = @@IDENTITY
SET @AffiliateID = @mNewID
SET @AuthUserID = @mAuthUserID
GO