EXEC [dbo].pts_CheckTable 'BarterCredit'
 GO

CREATE TABLE [dbo].[BarterCredit] (
   [BarterCreditID] int IDENTITY (1,1) NOT NULL ,
   [OwnerType] int NOT NULL ,
   [OwnerID] int NOT NULL ,
   [BarterAdID] int NOT NULL ,
   [CreditDate] datetime NOT NULL ,
   [Amount] money NOT NULL ,
   [Status] int NOT NULL ,
   [CreditType] int NOT NULL ,
   [StartDate] datetime NOT NULL ,
   [EndDate] datetime NOT NULL ,
   [Reference] varchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Notes] varchar (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
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