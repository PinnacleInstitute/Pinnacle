EXEC [dbo].pts_CheckProc 'pts_Consumer_Update'
 GO

CREATE PROCEDURE [dbo].pts_Consumer_Update ( 
   @ConsumerID int,
   @MemberID int,
   @MerchantID int,
   @ReferID int,
   @CountryID int,
   @CountryID2 int,
   @AffiliateID int,
   @NameLast nvarchar (30),
   @NameFirst nvarchar (30),
   @Email nvarchar (80),
   @Email2 nvarchar (80),
   @Phone nvarchar (20),
   @Provider int,
   @Password nvarchar (20),
   @Status int,
   @Messages int,
   @Street1 nvarchar (60),
   @Street2 nvarchar (60),
   @City nvarchar (30),
   @State nvarchar (30),
   @Zip nvarchar (20),
   @City2 nvarchar (30),
   @State2 nvarchar (30),
   @Zip2 nvarchar (20),
   @Referrals int,
   @Cash money,
   @Points money,
   @VisitDate datetime,
   @EnrollDate datetime,
   @UserKey varchar (40),
   @Barter varchar (100),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE csm
SET csm.MemberID = @MemberID ,
   csm.MerchantID = @MerchantID ,
   csm.ReferID = @ReferID ,
   csm.CountryID = @CountryID ,
   csm.CountryID2 = @CountryID2 ,
   csm.AffiliateID = @AffiliateID ,
   csm.NameLast = @NameLast ,
   csm.NameFirst = @NameFirst ,
   csm.Email = @Email ,
   csm.Email2 = @Email2 ,
   csm.Phone = @Phone ,
   csm.Provider = @Provider ,
   csm.Password = @Password ,
   csm.Status = @Status ,
   csm.Messages = @Messages ,
   csm.Street1 = @Street1 ,
   csm.Street2 = @Street2 ,
   csm.City = @City ,
   csm.State = @State ,
   csm.Zip = @Zip ,
   csm.City2 = @City2 ,
   csm.State2 = @State2 ,
   csm.Zip2 = @Zip2 ,
   csm.Referrals = @Referrals ,
   csm.Cash = @Cash ,
   csm.Points = @Points ,
   csm.VisitDate = @VisitDate ,
   csm.EnrollDate = @EnrollDate ,
   csm.UserKey = @UserKey ,
   csm.Barter = @Barter
FROM Consumer AS csm
WHERE csm.ConsumerID = @ConsumerID

GO