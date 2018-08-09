EXEC [dbo].pts_CheckTableRebuild 'Payment2'
 GO

ALTER TABLE [dbo].[Payment2] WITH NOCHECK ADD
   CONSTRAINT [DF_Payment2_MerchantID] DEFAULT (0) FOR [MerchantID] ,
   CONSTRAINT [DF_Payment2_ConsumerID] DEFAULT (0) FOR [ConsumerID] ,
   CONSTRAINT [DF_Payment2_StaffID] DEFAULT (0) FOR [StaffID] ,
   CONSTRAINT [DF_Payment2_AwardID] DEFAULT (0) FOR [AwardID] ,
   CONSTRAINT [DF_Payment2_SalesOrderID] DEFAULT (0) FOR [SalesOrderID] ,
   CONSTRAINT [DF_Payment2_StatementID] DEFAULT (0) FOR [StatementID] ,
   CONSTRAINT [DF_Payment2_PayDate] DEFAULT (0) FOR [PayDate] ,
   CONSTRAINT [DF_Payment2_PayType] DEFAULT (0) FOR [PayType] ,
   CONSTRAINT [DF_Payment2_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Payment2_Total] DEFAULT (0) FOR [Total] ,
   CONSTRAINT [DF_Payment2_Amount] DEFAULT (0) FOR [Amount] ,
   CONSTRAINT [DF_Payment2_Merchant] DEFAULT (0) FOR [Merchant] ,
   CONSTRAINT [DF_Payment2_Cashback] DEFAULT (0) FOR [Cashback] ,
   CONSTRAINT [DF_Payment2_Fee] DEFAULT (0) FOR [Fee] ,
   CONSTRAINT [DF_Payment2_PayCoins] DEFAULT (0) FOR [PayCoins] ,
   CONSTRAINT [DF_Payment2_PayRate] DEFAULT (0) FOR [PayRate] ,
   CONSTRAINT [DF_Payment2_PaidCoins] DEFAULT (0) FOR [PaidCoins] ,
   CONSTRAINT [DF_Payment2_Reference] DEFAULT ('') FOR [Reference] ,
   CONSTRAINT [DF_Payment2_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_Payment2_Notes] DEFAULT ('') FOR [Notes] ,
   CONSTRAINT [DF_Payment2_Ticket] DEFAULT (0) FOR [Ticket] ,
   CONSTRAINT [DF_Payment2_CommStatus] DEFAULT (0) FOR [CommStatus] ,
   CONSTRAINT [DF_Payment2_CommDate] DEFAULT (0) FOR [CommDate] ,
   CONSTRAINT [DF_Payment2_CoinStatus] DEFAULT (0) FOR [CoinStatus]
GO

ALTER TABLE [dbo].[Payment2] WITH NOCHECK ADD
   CONSTRAINT [PK_Payment2] PRIMARY KEY NONCLUSTERED
   ([Payment2ID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Payment2_MerchantID]
   ON [dbo].[Payment2]
   ([MerchantID], [ConsumerID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Payment2_ConsumerID]
   ON [dbo].[Payment2]
   ([ConsumerID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Payment2_StaffID]
   ON [dbo].[Payment2]
   ([StaffID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Payment2_StatementID]
   ON [dbo].[Payment2]
   ([StatementID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Payment2_Reference]
   ON [dbo].[Payment2]
   ([Reference])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Payment2_Status]
   ON [dbo].[Payment2]
   ([Status], [PayDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO