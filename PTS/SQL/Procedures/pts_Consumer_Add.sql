EXEC [dbo].pts_CheckProc 'pts_Consumer_Add'
GO

CREATE PROCEDURE [dbo].pts_Consumer_Add
   @ConsumerID int OUTPUT,
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
AS

DECLARE @mNow datetime, 
         @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()
INSERT INTO Consumer (
            MemberID , 
            MerchantID , 
            ReferID , 
            CountryID , 
            CountryID2 , 
            AffiliateID , 
            NameLast , 
            NameFirst , 
            Email , 
            Email2 , 
            Phone , 
            Provider , 
            Password , 
            Status , 
            Messages , 
            Street1 , 
            Street2 , 
            City , 
            State , 
            Zip , 
            City2 , 
            State2 , 
            Zip2 , 
            Referrals , 
            Cash , 
            Points , 
            VisitDate , 
            EnrollDate , 
            UserKey , 
            Barter

            )
VALUES (
            @MemberID ,
            @MerchantID ,
            @ReferID ,
            @CountryID ,
            @CountryID2 ,
            @AffiliateID ,
            @NameLast ,
            @NameFirst ,
            @Email ,
            @Email2 ,
            @Phone ,
            @Provider ,
            @Password ,
            @Status ,
            @Messages ,
            @Street1 ,
            @Street2 ,
            @City ,
            @State ,
            @Zip ,
            @City2 ,
            @State2 ,
            @Zip2 ,
            @Referrals ,
            @Cash ,
            @Points ,
            @VisitDate ,
            @EnrollDate ,
            @UserKey ,
            @Barter
            )

SET @mNewID = @@IDENTITY
SET @ConsumerID = @mNewID
EXEC pts_Consumer_SetReferral
   @ConsumerID

GO