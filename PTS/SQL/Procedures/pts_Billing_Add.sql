EXEC [dbo].pts_CheckProc 'pts_Billing_Add'
GO

CREATE PROCEDURE [dbo].pts_Billing_Add
   @BillingID int OUTPUT,
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

DECLARE @mNewID int

SET NOCOUNT ON

SET @UpdatedDate = GETDATE()
INSERT INTO Billing (
            CountryID , 
            TokenType , 
            TokenOwner , 
            Token , 
            Verified , 
            BillingName , 
            Street1 , 
            Street2 , 
            City , 
            State , 
            Zip , 
            PayType , 
            CommType , 
            CardType , 
            CardNumber , 
            CardMo , 
            CardYr , 
            CardName , 
            CardCode , 
            CheckBank , 
            CheckRoute , 
            CheckAccount , 
            CheckAcctType , 
            CheckNumber , 
            CheckName , 
            UpdatedDate

            )
VALUES (
            @CountryID ,
            @TokenType ,
            @TokenOwner ,
            @Token ,
            @Verified ,
            @BillingName ,
            @Street1 ,
            @Street2 ,
            @City ,
            @State ,
            @Zip ,
            @PayType ,
            @CommType ,
            @CardType ,
            @CardNumber ,
            @CardMo ,
            @CardYr ,
            @CardName ,
            @CardCode ,
            @CheckBank ,
            @CheckRoute ,
            @CheckAccount ,
            @CheckAcctType ,
            @CheckNumber ,
            @CheckName ,
            @UpdatedDate
            )

SET @mNewID = @@IDENTITY
SET @BillingID = @mNewID
GO