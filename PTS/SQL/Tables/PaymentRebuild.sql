EXEC [dbo].pts_CheckTableRebuild 'Payment'
 GO

ALTER TABLE [dbo].[Payment] WITH NOCHECK ADD
   CONSTRAINT [DF_Payment_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Payment_OwnerType] DEFAULT (0) FOR [OwnerType] ,
   CONSTRAINT [DF_Payment_OwnerID] DEFAULT (0) FOR [OwnerID] ,
   CONSTRAINT [DF_Payment_BillingID] DEFAULT (0) FOR [BillingID] ,
   CONSTRAINT [DF_Payment_ProductID] DEFAULT (0) FOR [ProductID] ,
   CONSTRAINT [DF_Payment_PaidID] DEFAULT (0) FOR [PaidID] ,
   CONSTRAINT [DF_Payment_PayDate] DEFAULT (0) FOR [PayDate] ,
   CONSTRAINT [DF_Payment_PaidDate] DEFAULT (0) FOR [PaidDate] ,
   CONSTRAINT [DF_Payment_PayType] DEFAULT (0) FOR [PayType] ,
   CONSTRAINT [DF_Payment_Amount] DEFAULT (0) FOR [Amount] ,
   CONSTRAINT [DF_Payment_Total] DEFAULT (0) FOR [Total] ,
   CONSTRAINT [DF_Payment_Credit] DEFAULT (0) FOR [Credit] ,
   CONSTRAINT [DF_Payment_Retail] DEFAULT (0) FOR [Retail] ,
   CONSTRAINT [DF_Payment_Commission] DEFAULT (0) FOR [Commission] ,
   CONSTRAINT [DF_Payment_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_Payment_Purpose] DEFAULT ('') FOR [Purpose] ,
   CONSTRAINT [DF_Payment_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Payment_Reference] DEFAULT ('') FOR [Reference] ,
   CONSTRAINT [DF_Payment_Notes] DEFAULT ('') FOR [Notes] ,
   CONSTRAINT [DF_Payment_CommStatus] DEFAULT (0) FOR [CommStatus] ,
   CONSTRAINT [DF_Payment_CommDate] DEFAULT (0) FOR [CommDate] ,
   CONSTRAINT [DF_Payment_TokenType] DEFAULT (0) FOR [TokenType] ,
   CONSTRAINT [DF_Payment_TokenOwner] DEFAULT (0) FOR [TokenOwner] ,
   CONSTRAINT [DF_Payment_Token] DEFAULT (0) FOR [Token]
GO

ALTER TABLE [dbo].[Payment] WITH NOCHECK ADD
   CONSTRAINT [PK_Payment] PRIMARY KEY NONCLUSTERED
   ([PaymentID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Payment_Owner]
   ON [dbo].[Payment]
   ([OwnerType], [OwnerID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Payment_Reference]
   ON [dbo].[Payment]
   ([Reference])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Payment_CompanyID]
   ON [dbo].[Payment]
   ([CompanyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Payment_BillingID]
   ON [dbo].[Payment]
   ([BillingID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO