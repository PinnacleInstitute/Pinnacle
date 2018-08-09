EXEC [dbo].pts_CheckTableRebuild 'Statement'
 GO

ALTER TABLE [dbo].[Statement] WITH NOCHECK ADD
   CONSTRAINT [DF_Statement_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Statement_MerchantID] DEFAULT (0) FOR [MerchantID] ,
   CONSTRAINT [DF_Statement_StatementDate] DEFAULT (0) FOR [StatementDate] ,
   CONSTRAINT [DF_Statement_PaidDate] DEFAULT (0) FOR [PaidDate] ,
   CONSTRAINT [DF_Statement_Amount] DEFAULT (0) FOR [Amount] ,
   CONSTRAINT [DF_Statement_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Statement_PayType] DEFAULT (0) FOR [PayType] ,
   CONSTRAINT [DF_Statement_Reference] DEFAULT ('') FOR [Reference] ,
   CONSTRAINT [DF_Statement_Notes] DEFAULT ('') FOR [Notes]
GO

ALTER TABLE [dbo].[Statement] WITH NOCHECK ADD
   CONSTRAINT [PK_Statement] PRIMARY KEY NONCLUSTERED
   ([StatementID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Statement_MerchantID]
   ON [dbo].[Statement]
   ([MerchantID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO