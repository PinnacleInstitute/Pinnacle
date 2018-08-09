EXEC [dbo].pts_CheckProc 'pts_Member_Update'
GO

CREATE PROCEDURE [dbo].pts_Member_Update
   @MemberID int,
   @AuthUserID int,
   @WebsiteID int,
   @CompanyID int,
   @PromoID int,
   @BillingID int,
   @PayID int,
   @ReferralID int,
   @SponsorID int,
   @Sponsor2ID int,
   @Sponsor3ID int,
   @MentorID int,
   @UserGroup int,
   @UserStatus int,
   @CompanyName nvarchar (60),
   @NameLast nvarchar (30),
   @NameFirst nvarchar (30),
   @BV money,
   @QV money,
   @BV2 money,
   @QV2 money,
   @BV3 money,
   @QV3 money,
   @BV4 money,
   @QV4 money,
   @Qualify int,
   @QualifyDate datetime,
   @Email nvarchar (80),
   @Email2 nvarchar (80),
   @Phone1 nvarchar (30),
   @Phone2 nvarchar (30),
   @Fax nvarchar (30),
   @Status int,
   @Level int,
   @Newsletter int,
   @EnrollDate datetime,
   @EndDate datetime,
   @InitPrice money,
   @Price money,
   @Retail money,
   @BusAccts int,
   @BusAcctPrice money,
   @BusAcctRetail money,
   @IsDiscount bit,
   @Discount money,
   @IsCompany bit,
   @Billing int,
   @AccessLimit varchar (50),
   @QuizLimit int,
   @Reference varchar (15),
   @Referral varchar (15),
   @TrialDays int,
   @MasterID int,
   @IsIncluded bit,
   @IsMaster bit,
   @MasterPrice money,
   @MasterMembers int,
   @MaxMembers int,
   @VisitDate datetime,
   @TaxIDType int,
   @TaxID nvarchar (15),
   @AutoShipDate datetime,
   @PaidDate datetime,
   @StatusDate datetime,
   @StatusChange int,
   @LevelChange int,
   @IsRemoved bit,
   @GroupID int,
   @Role nvarchar (15),
   @Secure int,
   @Options varchar (20),
   @Options2 varchar (40),
   @Pos int,
   @Signature nvarchar (1000),
   @SocNet varchar (200),
   @ConfLine varchar (40),
   @NotifyMentor varchar (10),
   @Image varchar (15),
   @Identification nvarchar (150),
   @Title int,
   @Title2 int,
   @MinTitle int,
   @TitleDate datetime,
   @InputValues nvarchar (1000),
   @Icons varchar (20),
   @IsMsg int,
   @Timezone int,
   @Process int,
   @NewLogon nvarchar (80),
   @NewPassword nvarchar (30),
   @Unit nvarchar (40),
   @UserID int
AS

DECLARE @mNow datetime, 
         @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()
IF ((@Email2 = ''))
   BEGIN
   SET @Email2 = @Email
   END

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

UPDATE me
SET me.AuthUserID = @AuthUserID ,
   me.WebsiteID = @WebsiteID ,
   me.CompanyID = @CompanyID ,
   me.PromoID = @PromoID ,
   me.BillingID = @BillingID ,
   me.PayID = @PayID ,
   me.ReferralID = @ReferralID ,
   me.SponsorID = @SponsorID ,
   me.Sponsor2ID = @Sponsor2ID ,
   me.Sponsor3ID = @Sponsor3ID ,
   me.MentorID = @MentorID ,
   me.CompanyName = @CompanyName ,
   me.NameLast = @NameLast ,
   me.NameFirst = @NameFirst ,
   me.BV = @BV ,
   me.QV = @QV ,
   me.BV2 = @BV2 ,
   me.QV2 = @QV2 ,
   me.BV3 = @BV3 ,
   me.QV3 = @QV3 ,
   me.BV4 = @BV4 ,
   me.QV4 = @QV4 ,
   me.Qualify = @Qualify ,
   me.QualifyDate = @QualifyDate ,
   me.Email = @Email ,
   me.Email2 = @Email2 ,
   me.Phone1 = @Phone1 ,
   me.Phone2 = @Phone2 ,
   me.Fax = @Fax ,
   me.Status = @Status ,
   me.Level = @Level ,
   me.Newsletter = @Newsletter ,
   me.EnrollDate = @EnrollDate ,
   me.EndDate = @EndDate ,
   me.InitPrice = @InitPrice ,
   me.Price = @Price ,
   me.Retail = @Retail ,
   me.BusAccts = @BusAccts ,
   me.BusAcctPrice = @BusAcctPrice ,
   me.BusAcctRetail = @BusAcctRetail ,
   me.IsDiscount = @IsDiscount ,
   me.Discount = @Discount ,
   me.IsCompany = @IsCompany ,
   me.Billing = @Billing ,
   me.AccessLimit = @AccessLimit ,
   me.QuizLimit = @QuizLimit ,
   me.Reference = @Reference ,
   me.Referral = @Referral ,
   me.TrialDays = @TrialDays ,
   me.MasterID = @MasterID ,
   me.IsIncluded = @IsIncluded ,
   me.IsMaster = @IsMaster ,
   me.MasterPrice = @MasterPrice ,
   me.MasterMembers = @MasterMembers ,
   me.MaxMembers = @MaxMembers ,
   me.VisitDate = @VisitDate ,
   me.TaxIDType = @TaxIDType ,
   me.TaxID = @TaxID ,
   me.AutoShipDate = @AutoShipDate ,
   me.PaidDate = @PaidDate ,
   me.StatusDate = @StatusDate ,
   me.StatusChange = @StatusChange ,
   me.LevelChange = @LevelChange ,
   me.IsRemoved = @IsRemoved ,
   me.GroupID = @GroupID ,
   me.Role = @Role ,
   me.Secure = @Secure ,
   me.Options = @Options ,
   me.Options2 = @Options2 ,
   me.Pos = @Pos ,
   me.Signature = @Signature ,
   me.SocNet = @SocNet ,
   me.ConfLine = @ConfLine ,
   me.NotifyMentor = @NotifyMentor ,
   me.Image = @Image ,
   me.Identification = @Identification ,
   me.Title = @Title ,
   me.Title2 = @Title2 ,
   me.MinTitle = @MinTitle ,
   me.TitleDate = @TitleDate ,
   me.InputValues = @InputValues ,
   me.Icons = @Icons ,
   me.IsMsg = @IsMsg ,
   me.Timezone = @Timezone ,
   me.Process = @Process
FROM Member AS me
WHERE (me.MemberID = @MemberID)


GO