EXEC [dbo].pts_CheckTable 'Payout'
 GO

CREATE TABLE [dbo].[Payout] (
   [PayoutID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [OwnerType] int NOT NULL ,
   [OwnerID] int NOT NULL ,
   [PayDate] datetime NOT NULL ,
   [PaidDate] datetime NOT NULL ,
   [Amount] money NOT NULL ,
   [Status] int NOT NULL ,
   [Notes] varchar (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [PayType] int NOT NULL ,
   [Reference] varchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Show] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Payout] WITH NOCHECK ADD
   CONSTRAINT [DF_Payout_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Payout_OwnerType] DEFAULT (0) FOR [OwnerType] ,
   CONSTRAINT [DF_Payout_OwnerID] DEFAULT (0) FOR [OwnerID] ,
   CONSTRAINT [DF_Payout_PayDate] DEFAULT (0) FOR [PayDate] ,
   CONSTRAINT [DF_Payout_PaidDate] DEFAULT (0) FOR [PaidDate] ,
   CONSTRAINT [DF_Payout_Amount] DEFAULT (0) FOR [Amount] ,
   CONSTRAINT [DF_Payout_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Payout_Notes] DEFAULT ('') FOR [Notes] ,
   CONSTRAINT [DF_Payout_PayType] DEFAULT (0) FOR [PayType] ,
   CONSTRAINT [DF_Payout_Reference] DEFAULT ('') FOR [Reference] ,
   CONSTRAINT [DF_Payout_Show] DEFAULT (0) FOR [Show]
GO

ALTER TABLE [dbo].[Payout] WITH NOCHECK ADD
   CONSTRAINT [PK_Payout] PRIMARY KEY NONCLUSTERED
   ([PayoutID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Payout_Owner]
   ON [dbo].[Payout]
   ([OwnerType], [OwnerID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Payout_CompanyID]
   ON [dbo].[Payout]
   ([CompanyID], [PayType])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO