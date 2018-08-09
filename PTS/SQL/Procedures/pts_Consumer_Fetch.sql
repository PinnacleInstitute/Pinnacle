EXEC [dbo].pts_CheckProc 'pts_Consumer_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Consumer_Fetch ( 
   @ConsumerID int,
   @MemberID int OUTPUT,
   @MerchantID int OUTPUT,
   @ReferID int OUTPUT,
   @CountryID int OUTPUT,
   @CountryID2 int OUTPUT,
   @AffiliateID int OUTPUT,
   @CountryName nvarchar (50) OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @ConsumerName nvarchar (62) OUTPUT,
   @Email nvarchar (80) OUTPUT,
   @Email2 nvarchar (80) OUTPUT,
   @Phone nvarchar (20) OUTPUT,
   @Provider int OUTPUT,
   @Password nvarchar (20) OUTPUT,
   @Status int OUTPUT,
   @Messages int OUTPUT,
   @Street1 nvarchar (60) OUTPUT,
   @Street2 nvarchar (60) OUTPUT,
   @City nvarchar (30) OUTPUT,
   @State nvarchar (30) OUTPUT,
   @Zip nvarchar (20) OUTPUT,
   @City2 nvarchar (30) OUTPUT,
   @State2 nvarchar (30) OUTPUT,
   @Zip2 nvarchar (20) OUTPUT,
   @Referrals int OUTPUT,
   @Cash money OUTPUT,
   @Points money OUTPUT,
   @VisitDate datetime OUTPUT,
   @EnrollDate datetime OUTPUT,
   @UserKey varchar (40) OUTPUT,
   @Barter varchar (100) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = csm.MemberID ,
   @MerchantID = csm.MerchantID ,
   @ReferID = csm.ReferID ,
   @CountryID = csm.CountryID ,
   @CountryID2 = csm.CountryID2 ,
   @AffiliateID = csm.AffiliateID ,
   @CountryName = cou.CountryName ,
   @NameLast = csm.NameLast ,
   @NameFirst = csm.NameFirst ,
   @ConsumerName = LTRIM(RTRIM(csm.NameLast)) +  ', '  + LTRIM(RTRIM(csm.NameFirst)) ,
   @Email = csm.Email ,
   @Email2 = csm.Email2 ,
   @Phone = csm.Phone ,
   @Provider = csm.Provider ,
   @Password = csm.Password ,
   @Status = csm.Status ,
   @Messages = csm.Messages ,
   @Street1 = csm.Street1 ,
   @Street2 = csm.Street2 ,
   @City = csm.City ,
   @State = csm.State ,
   @Zip = csm.Zip ,
   @City2 = csm.City2 ,
   @State2 = csm.State2 ,
   @Zip2 = csm.Zip2 ,
   @Referrals = csm.Referrals ,
   @Cash = csm.Cash ,
   @Points = csm.Points ,
   @VisitDate = csm.VisitDate ,
   @EnrollDate = csm.EnrollDate ,
   @UserKey = csm.UserKey ,
   @Barter = csm.Barter
FROM Consumer AS csm (NOLOCK)
LEFT OUTER JOIN Country AS cou (NOLOCK) ON (csm.CountryID = cou.CountryID)
WHERE csm.ConsumerID = @ConsumerID

GO