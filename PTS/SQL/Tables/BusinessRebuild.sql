EXEC [dbo].pts_CheckTableRebuild 'Business'
 GO

ALTER TABLE [dbo].[Business] WITH NOCHECK ADD
   CONSTRAINT [DF_Business_Install] DEFAULT (0) FOR [Install] ,
   CONSTRAINT [DF_Business_BusinessName] DEFAULT ('') FOR [BusinessName] ,
   CONSTRAINT [DF_Business_SystemEmail] DEFAULT ('') FOR [SystemEmail] ,
   CONSTRAINT [DF_Business_CustomerEmail] DEFAULT ('') FOR [CustomerEmail] ,
   CONSTRAINT [DF_Business_TrainerEmail] DEFAULT ('') FOR [TrainerEmail] ,
   CONSTRAINT [DF_Business_FinanceEmail] DEFAULT ('') FOR [FinanceEmail] ,
   CONSTRAINT [DF_Business_Street] DEFAULT ('') FOR [Street] ,
   CONSTRAINT [DF_Business_Unit] DEFAULT ('') FOR [Unit] ,
   CONSTRAINT [DF_Business_City] DEFAULT ('') FOR [City] ,
   CONSTRAINT [DF_Business_State] DEFAULT ('') FOR [State] ,
   CONSTRAINT [DF_Business_Zip] DEFAULT ('') FOR [Zip] ,
   CONSTRAINT [DF_Business_Country] DEFAULT ('') FOR [Country] ,
   CONSTRAINT [DF_Business_Phone] DEFAULT ('') FOR [Phone] ,
   CONSTRAINT [DF_Business_Fax] DEFAULT ('') FOR [Fax] ,
   CONSTRAINT [DF_Business_WebSite] DEFAULT ('') FOR [WebSite] ,
   CONSTRAINT [DF_Business_TaxRate] DEFAULT (0) FOR [TaxRate] ,
   CONSTRAINT [DF_Business_CardProcessor] DEFAULT (0) FOR [CardProcessor] ,
   CONSTRAINT [DF_Business_CheckProcessor] DEFAULT (0) FOR [CheckProcessor] ,
   CONSTRAINT [DF_Business_CardAcct] DEFAULT ('') FOR [CardAcct] ,
   CONSTRAINT [DF_Business_CheckAcct] DEFAULT ('') FOR [CheckAcct] ,
   CONSTRAINT [DF_Business_PayPalAcct] DEFAULT ('') FOR [PayPalAcct] ,
   CONSTRAINT [DF_Business_IsNotifyUser] DEFAULT (0) FOR [IsNotifyUser] ,
   CONSTRAINT [DF_Business_PaymentOptions] DEFAULT ('') FOR [PaymentOptions] ,
   CONSTRAINT [DF_Business_MiscPay1] DEFAULT ('') FOR [MiscPay1] ,
   CONSTRAINT [DF_Business_MiscPay2] DEFAULT ('') FOR [MiscPay2] ,
   CONSTRAINT [DF_Business_MiscPay3] DEFAULT ('') FOR [MiscPay3] ,
   CONSTRAINT [DF_Business_Languages] DEFAULT ('') FOR [Languages] ,
   CONSTRAINT [DF_Business_Options1] DEFAULT ('') FOR [Options1] ,
   CONSTRAINT [DF_Business_Options2] DEFAULT ('') FOR [Options2] ,
   CONSTRAINT [DF_Business_Options3] DEFAULT ('') FOR [Options3] ,
   CONSTRAINT [DF_Business_Options4] DEFAULT ('') FOR [Options4] ,
   CONSTRAINT [DF_Business_Tutorial] DEFAULT (0) FOR [Tutorial] ,
   CONSTRAINT [DF_Business_Timezone] DEFAULT (0) FOR [Timezone]
GO

ALTER TABLE [dbo].[Business] WITH NOCHECK ADD
   CONSTRAINT [PK_Business] PRIMARY KEY NONCLUSTERED
   ([BusinessID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO