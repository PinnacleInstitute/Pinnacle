EXEC [dbo].pts_CheckProc 'pts_Business_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Business_Fetch ( 
   @BusinessID int,
   @Install int OUTPUT,
   @BusinessName nvarchar (30) OUTPUT,
   @SystemEmail nvarchar (80) OUTPUT,
   @CustomerEmail nvarchar (80) OUTPUT,
   @TrainerEmail nvarchar (80) OUTPUT,
   @FinanceEmail nvarchar (80) OUTPUT,
   @Street nvarchar (60) OUTPUT,
   @Unit nvarchar (40) OUTPUT,
   @City nvarchar (30) OUTPUT,
   @State nvarchar (30) OUTPUT,
   @Zip nvarchar (20) OUTPUT,
   @Country nvarchar (30) OUTPUT,
   @Phone nvarchar (30) OUTPUT,
   @Fax nvarchar (30) OUTPUT,
   @WebSite nvarchar (255) OUTPUT,
   @TaxRate money OUTPUT,
   @CardProcessor int OUTPUT,
   @CheckProcessor int OUTPUT,
   @CardAcct nvarchar (255) OUTPUT,
   @CheckAcct nvarchar (255) OUTPUT,
   @PayPalAcct nvarchar (255) OUTPUT,
   @IsNotifyUser bit OUTPUT,
   @PaymentOptions varchar (15) OUTPUT,
   @MiscPay1 nvarchar (30) OUTPUT,
   @MiscPay2 nvarchar (30) OUTPUT,
   @MiscPay3 nvarchar (30) OUTPUT,
   @Languages nvarchar (1000) OUTPUT,
   @Options1 varchar (60) OUTPUT,
   @Options2 varchar (60) OUTPUT,
   @Options3 varchar (60) OUTPUT,
   @Options4 varchar (60) OUTPUT,
   @Tutorial int OUTPUT,
   @Timezone int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @Install = bu.Install ,
   @BusinessName = bu.BusinessName ,
   @SystemEmail = bu.SystemEmail ,
   @CustomerEmail = bu.CustomerEmail ,
   @TrainerEmail = bu.TrainerEmail ,
   @FinanceEmail = bu.FinanceEmail ,
   @Street = bu.Street ,
   @Unit = bu.Unit ,
   @City = bu.City ,
   @State = bu.State ,
   @Zip = bu.Zip ,
   @Country = bu.Country ,
   @Phone = bu.Phone ,
   @Fax = bu.Fax ,
   @WebSite = bu.WebSite ,
   @TaxRate = bu.TaxRate ,
   @CardProcessor = bu.CardProcessor ,
   @CheckProcessor = bu.CheckProcessor ,
   @CardAcct = bu.CardAcct ,
   @CheckAcct = bu.CheckAcct ,
   @PayPalAcct = bu.PayPalAcct ,
   @IsNotifyUser = bu.IsNotifyUser ,
   @PaymentOptions = bu.PaymentOptions ,
   @MiscPay1 = bu.MiscPay1 ,
   @MiscPay2 = bu.MiscPay2 ,
   @MiscPay3 = bu.MiscPay3 ,
   @Languages = bu.Languages ,
   @Options1 = bu.Options1 ,
   @Options2 = bu.Options2 ,
   @Options3 = bu.Options3 ,
   @Options4 = bu.Options4 ,
   @Tutorial = bu.Tutorial ,
   @Timezone = bu.Timezone
FROM Business AS bu (NOLOCK)
WHERE bu.BusinessID = @BusinessID

GO