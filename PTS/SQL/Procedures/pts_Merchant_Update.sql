EXEC [dbo].pts_CheckProc 'pts_Merchant_Update'
 GO

CREATE PROCEDURE [dbo].pts_Merchant_Update ( 
   @MerchantID int,
   @MemberID int,
   @BillingID int,
   @PayoutID int,
   @CountryID int,
   @SweepID int,
   @MerchantName nvarchar (80),
   @NameLast nvarchar (30),
   @NameFirst nvarchar (30),
   @Email nvarchar (80),
   @Email2 nvarchar (80),
   @Email3 nvarchar (80),
   @Phone nvarchar (30),
   @Phone2 nvarchar (30),
   @Password nvarchar (20),
   @Password2 nvarchar (20),
   @Password3 nvarchar (20),
   @Password4 nvarchar (20),
   @Status int,
   @Street1 nvarchar (60),
   @Street2 nvarchar (60),
   @City nvarchar (30),
   @State nvarchar (30),
   @Zip nvarchar (20),
   @Referrals int,
   @Referrals2 int,
   @VisitDate datetime,
   @IsOrg bit,
   @IsAwards bit,
   @EnrollDate datetime,
   @BillDate datetime,
   @BillDays int,
   @Image nvarchar (40),
   @Description nvarchar (2000),
   @Terms nvarchar (100),
   @Options varchar (20),
   @StoreOptions varchar (20),
   @Colors varchar (100),
   @Rating int,
   @CurrencyCode varchar (3),
   @Processor int,
   @Payment varchar (1000),
   @UserKey varchar (40),
   @UserKey3 varchar (40),
   @UserKey4 varchar (40),
   @UserCode varchar (10),
   @Access varchar (80),
   @PromoLimit int,
   @SweepRate int,
   @TimeZone int,
   @GeoCode varchar (30),
   @ReferRate int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE mer
SET mer.MemberID = @MemberID ,
   mer.BillingID = @BillingID ,
   mer.PayoutID = @PayoutID ,
   mer.CountryID = @CountryID ,
   mer.SweepID = @SweepID ,
   mer.MerchantName = @MerchantName ,
   mer.NameLast = @NameLast ,
   mer.NameFirst = @NameFirst ,
   mer.Email = @Email ,
   mer.Email2 = @Email2 ,
   mer.Email3 = @Email3 ,
   mer.Phone = @Phone ,
   mer.Phone2 = @Phone2 ,
   mer.Password = @Password ,
   mer.Password2 = @Password2 ,
   mer.Password3 = @Password3 ,
   mer.Password4 = @Password4 ,
   mer.Status = @Status ,
   mer.Street1 = @Street1 ,
   mer.Street2 = @Street2 ,
   mer.City = @City ,
   mer.State = @State ,
   mer.Zip = @Zip ,
   mer.Referrals = @Referrals ,
   mer.Referrals2 = @Referrals2 ,
   mer.VisitDate = @VisitDate ,
   mer.IsOrg = @IsOrg ,
   mer.IsAwards = @IsAwards ,
   mer.EnrollDate = @EnrollDate ,
   mer.BillDate = @BillDate ,
   mer.BillDays = @BillDays ,
   mer.Image = @Image ,
   mer.Description = @Description ,
   mer.Terms = @Terms ,
   mer.Options = @Options ,
   mer.StoreOptions = @StoreOptions ,
   mer.Colors = @Colors ,
   mer.Rating = @Rating ,
   mer.CurrencyCode = @CurrencyCode ,
   mer.Processor = @Processor ,
   mer.Payment = @Payment ,
   mer.UserKey = @UserKey ,
   mer.UserKey3 = @UserKey3 ,
   mer.UserKey4 = @UserKey4 ,
   mer.UserCode = @UserCode ,
   mer.Access = @Access ,
   mer.PromoLimit = @PromoLimit ,
   mer.SweepRate = @SweepRate ,
   mer.TimeZone = @TimeZone ,
   mer.GeoCode = @GeoCode ,
   mer.ReferRate = @ReferRate
FROM Merchant AS mer
WHERE mer.MerchantID = @MerchantID

GO