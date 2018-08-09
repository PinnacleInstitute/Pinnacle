EXEC [dbo].pts_CheckProc 'pts_Billing_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Billing_Fetch ( 
   @BillingID int,
   @CountryID int OUTPUT,
   @CountryName nvarchar (50) OUTPUT,
   @CountryCode nvarchar (2) OUTPUT,
   @TokenType int OUTPUT,
   @TokenOwner int OUTPUT,
   @Token int OUTPUT,
   @Verified int OUTPUT,
   @BillingName nvarchar (60) OUTPUT,
   @Street1 nvarchar (60) OUTPUT,
   @Street2 nvarchar (60) OUTPUT,
   @City nvarchar (30) OUTPUT,
   @State nvarchar (30) OUTPUT,
   @Zip nvarchar (20) OUTPUT,
   @PayType int OUTPUT,
   @CommType int OUTPUT,
   @CardType int OUTPUT,
   @CardNumber nvarchar (30) OUTPUT,
   @CardMo int OUTPUT,
   @CardYr int OUTPUT,
   @CardName nvarchar (50) OUTPUT,
   @CardCode nvarchar (10) OUTPUT,
   @CheckBank nvarchar (50) OUTPUT,
   @CheckRoute nvarchar (9) OUTPUT,
   @CheckAccount nvarchar (20) OUTPUT,
   @CheckAcctType int OUTPUT,
   @CheckNumber nvarchar (6) OUTPUT,
   @CheckName nvarchar (50) OUTPUT,
   @UpdatedDate datetime OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CountryID = bil.CountryID ,
   @CountryName = cou.CountryName ,
   @CountryCode = cou.Code ,
   @TokenType = bil.TokenType ,
   @TokenOwner = bil.TokenOwner ,
   @Token = bil.Token ,
   @Verified = bil.Verified ,
   @BillingName = bil.BillingName ,
   @Street1 = bil.Street1 ,
   @Street2 = bil.Street2 ,
   @City = bil.City ,
   @State = bil.State ,
   @Zip = bil.Zip ,
   @PayType = bil.PayType ,
   @CommType = bil.CommType ,
   @CardType = bil.CardType ,
   @CardNumber = bil.CardNumber ,
   @CardMo = bil.CardMo ,
   @CardYr = bil.CardYr ,
   @CardName = bil.CardName ,
   @CardCode = bil.CardCode ,
   @CheckBank = bil.CheckBank ,
   @CheckRoute = bil.CheckRoute ,
   @CheckAccount = bil.CheckAccount ,
   @CheckAcctType = bil.CheckAcctType ,
   @CheckNumber = bil.CheckNumber ,
   @CheckName = bil.CheckName ,
   @UpdatedDate = bil.UpdatedDate
FROM Billing AS bil (NOLOCK)
LEFT OUTER JOIN Country AS cou (NOLOCK) ON (bil.CountryID = cou.CountryID)
WHERE bil.BillingID = @BillingID

GO