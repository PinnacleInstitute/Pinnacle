EXEC [dbo].pts_CheckProc 'pts_Billing_Update'
GO

CREATE PROCEDURE [dbo].pts_Billing_Update
   @BillingID int,
   @CountryID int,
   @TokenType int,
   @TokenOwner int,
   @Token int,
   @Verified int,
   @BillingName nvarchar (60),
   @Street1 nvarchar (60),
   @Street2 nvarchar (60),
   @City nvarchar (30),
   @State nvarchar (30),
   @Zip nvarchar (20),
   @PayType int,
   @CommType int,
   @CardType int,
   @CardNumber nvarchar (30),
   @CardMo int,
   @CardYr int,
   @CardName nvarchar (50),
   @CardCode nvarchar (10),
   @CheckBank nvarchar (50),
   @CheckRoute nvarchar (9),
   @CheckAccount nvarchar (20),
   @CheckAcctType int,
   @CheckNumber nvarchar (6),
   @CheckName nvarchar (50),
   @UpdatedDate datetime,
   @UserID int
AS

SET NOCOUNT ON

SET @UpdatedDate = GETDATE()
UPDATE bil
SET bil.CountryID = @CountryID ,
   bil.TokenType = @TokenType ,
   bil.TokenOwner = @TokenOwner ,
   bil.Token = @Token ,
   bil.Verified = @Verified ,
   bil.BillingName = @BillingName ,
   bil.Street1 = @Street1 ,
   bil.Street2 = @Street2 ,
   bil.City = @City ,
   bil.State = @State ,
   bil.Zip = @Zip ,
   bil.PayType = @PayType ,
   bil.CommType = @CommType ,
   bil.CardType = @CardType ,
   bil.CardNumber = @CardNumber ,
   bil.CardMo = @CardMo ,
   bil.CardYr = @CardYr ,
   bil.CardName = @CardName ,
   bil.CardCode = @CardCode ,
   bil.CheckBank = @CheckBank ,
   bil.CheckRoute = @CheckRoute ,
   bil.CheckAccount = @CheckAccount ,
   bil.CheckAcctType = @CheckAcctType ,
   bil.CheckNumber = @CheckNumber ,
   bil.CheckName = @CheckName ,
   bil.UpdatedDate = @UpdatedDate
FROM Billing AS bil
WHERE (bil.BillingID = @BillingID)


GO