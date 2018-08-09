EXEC [dbo].pts_CheckTableRebuild 'Billing'
 GO

ALTER TABLE [dbo].[Billing] WITH NOCHECK ADD
   CONSTRAINT [DF_Billing_CountryID] DEFAULT (0) FOR [CountryID] ,
   CONSTRAINT [DF_Billing_TokenType] DEFAULT (0) FOR [TokenType] ,
   CONSTRAINT [DF_Billing_TokenOwner] DEFAULT (0) FOR [TokenOwner] ,
   CONSTRAINT [DF_Billing_Token] DEFAULT (0) FOR [Token] ,
   CONSTRAINT [DF_Billing_Verified] DEFAULT (0) FOR [Verified] ,
   CONSTRAINT [DF_Billing_BillingName] DEFAULT ('') FOR [BillingName] ,
   CONSTRAINT [DF_Billing_Street1] DEFAULT ('') FOR [Street1] ,
   CONSTRAINT [DF_Billing_Street2] DEFAULT ('') FOR [Street2] ,
   CONSTRAINT [DF_Billing_City] DEFAULT ('') FOR [City] ,
   CONSTRAINT [DF_Billing_State] DEFAULT ('') FOR [State] ,
   CONSTRAINT [DF_Billing_Zip] DEFAULT ('') FOR [Zip] ,
   CONSTRAINT [DF_Billing_PayType] DEFAULT (0) FOR [PayType] ,
   CONSTRAINT [DF_Billing_CommType] DEFAULT (0) FOR [CommType] ,
   CONSTRAINT [DF_Billing_CardType] DEFAULT (0) FOR [CardType] ,
   CONSTRAINT [DF_Billing_CardNumber] DEFAULT ('') FOR [CardNumber] ,
   CONSTRAINT [DF_Billing_CardMo] DEFAULT (0) FOR [CardMo] ,
   CONSTRAINT [DF_Billing_CardYr] DEFAULT (0) FOR [CardYr] ,
   CONSTRAINT [DF_Billing_CardName] DEFAULT ('') FOR [CardName] ,
   CONSTRAINT [DF_Billing_CardCode] DEFAULT ('') FOR [CardCode] ,
   CONSTRAINT [DF_Billing_CheckBank] DEFAULT ('') FOR [CheckBank] ,
   CONSTRAINT [DF_Billing_CheckRoute] DEFAULT ('') FOR [CheckRoute] ,
   CONSTRAINT [DF_Billing_CheckAccount] DEFAULT ('') FOR [CheckAccount] ,
   CONSTRAINT [DF_Billing_CheckAcctType] DEFAULT (0) FOR [CheckAcctType] ,
   CONSTRAINT [DF_Billing_CheckNumber] DEFAULT ('') FOR [CheckNumber] ,
   CONSTRAINT [DF_Billing_CheckName] DEFAULT ('') FOR [CheckName] ,
   CONSTRAINT [DF_Billing_UpdatedDate] DEFAULT (0) FOR [UpdatedDate]
GO

ALTER TABLE [dbo].[Billing] WITH NOCHECK ADD
   CONSTRAINT [PK_Billing] PRIMARY KEY NONCLUSTERED
   ([BillingID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO