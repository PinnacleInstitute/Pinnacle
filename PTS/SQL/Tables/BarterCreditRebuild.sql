EXEC [dbo].pts_CheckTableRebuild 'BarterCredit'
 GO

ALTER TABLE [dbo].[BarterCredit] WITH NOCHECK ADD
   CONSTRAINT [DF_BarterCredit_OwnerType] DEFAULT (0) FOR [OwnerType] ,
   CONSTRAINT [DF_BarterCredit_OwnerID] DEFAULT (0) FOR [OwnerID] ,
   CONSTRAINT [DF_BarterCredit_BarterAdID] DEFAULT (0) FOR [BarterAdID] ,
   CONSTRAINT [DF_BarterCredit_CreditDate] DEFAULT (0) FOR [CreditDate] ,
   CONSTRAINT [DF_BarterCredit_Amount] DEFAULT (0) FOR [Amount] ,
   CONSTRAINT [DF_BarterCredit_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_BarterCredit_CreditType] DEFAULT (0) FOR [CreditType] ,
   CONSTRAINT [DF_BarterCredit_StartDate] DEFAULT (0) FOR [StartDate] ,
   CONSTRAINT [DF_BarterCredit_EndDate] DEFAULT (0) FOR [EndDate] ,
   CONSTRAINT [DF_BarterCredit_Reference] DEFAULT ('') FOR [Reference] ,
   CONSTRAINT [DF_BarterCredit_Notes] DEFAULT ('') FOR [Notes]
GO

ALTER TABLE [dbo].[BarterCredit] WITH NOCHECK ADD
   CONSTRAINT [PK_BarterCredit] PRIMARY KEY NONCLUSTERED
   ([BarterCreditID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_BarterCredit_Owner]
   ON [dbo].[BarterCredit]
   ([OwnerType], [OwnerID], [CreditDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_BarterCredit_BarterAdID]
   ON [dbo].[BarterCredit]
   ([BarterAdID], [CreditDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_BarterCredit_Reference]
   ON [dbo].[BarterCredit]
   ([Reference])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO