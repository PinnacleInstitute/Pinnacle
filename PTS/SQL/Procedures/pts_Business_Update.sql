EXEC [dbo].pts_CheckProc 'pts_Business_Update'
 GO

CREATE PROCEDURE [dbo].pts_Business_Update ( 
   @BusinessID int,
   @Install int,
   @BusinessName nvarchar (30),
   @SystemEmail nvarchar (80),
   @CustomerEmail nvarchar (80),
   @TrainerEmail nvarchar (80),
   @FinanceEmail nvarchar (80),
   @Street nvarchar (60),
   @Unit nvarchar (40),
   @City nvarchar (30),
   @State nvarchar (30),
   @Zip nvarchar (20),
   @Country nvarchar (30),
   @Phone nvarchar (30),
   @Fax nvarchar (30),
   @WebSite nvarchar (255),
   @TaxRate money,
   @CardProcessor int,
   @CheckProcessor int,
   @CardAcct nvarchar (255),
   @CheckAcct nvarchar (255),
   @PayPalAcct nvarchar (255),
   @IsNotifyUser bit,
   @PaymentOptions varchar (15),
   @MiscPay1 nvarchar (30),
   @MiscPay2 nvarchar (30),
   @MiscPay3 nvarchar (30),
   @Languages nvarchar (1000),
   @Options1 varchar (60),
   @Options2 varchar (60),
   @Options3 varchar (60),
   @Options4 varchar (60),
   @Tutorial int,
   @Timezone int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE bu
SET bu.Install = @Install ,
   bu.BusinessName = @BusinessName ,
   bu.SystemEmail = @SystemEmail ,
   bu.CustomerEmail = @CustomerEmail ,
   bu.TrainerEmail = @TrainerEmail ,
   bu.FinanceEmail = @FinanceEmail ,
   bu.Street = @Street ,
   bu.Unit = @Unit ,
   bu.City = @City ,
   bu.State = @State ,
   bu.Zip = @Zip ,
   bu.Country = @Country ,
   bu.Phone = @Phone ,
   bu.Fax = @Fax ,
   bu.WebSite = @WebSite ,
   bu.TaxRate = @TaxRate ,
   bu.CardProcessor = @CardProcessor ,
   bu.CheckProcessor = @CheckProcessor ,
   bu.CardAcct = @CardAcct ,
   bu.CheckAcct = @CheckAcct ,
   bu.PayPalAcct = @PayPalAcct ,
   bu.IsNotifyUser = @IsNotifyUser ,
   bu.PaymentOptions = @PaymentOptions ,
   bu.MiscPay1 = @MiscPay1 ,
   bu.MiscPay2 = @MiscPay2 ,
   bu.MiscPay3 = @MiscPay3 ,
   bu.Languages = @Languages ,
   bu.Options1 = @Options1 ,
   bu.Options2 = @Options2 ,
   bu.Options3 = @Options3 ,
   bu.Options4 = @Options4 ,
   bu.Tutorial = @Tutorial ,
   bu.Timezone = @Timezone
FROM Business AS bu
WHERE bu.BusinessID = @BusinessID

GO