EXEC [dbo].pts_CheckTable 'Coin'
 GO

CREATE TABLE [dbo].[Coin] (
   [CoinID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [MemberID] int NOT NULL ,
   [CoinDate] datetime NOT NULL ,
   [Amount] money NOT NULL ,
   [Status] int NOT NULL ,
   [CoinType] int NOT NULL ,
   [Reference] varchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Notes] varchar (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Coin] WITH NOCHECK ADD
   CONSTRAINT [DF_Coin_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Coin_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Coin_CoinDate] DEFAULT (0) FOR [CoinDate] ,
   CONSTRAINT [DF_Coin_Amount] DEFAULT (0) FOR [Amount] ,
   CONSTRAINT [DF_Coin_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Coin_CoinType] DEFAULT (0) FOR [CoinType] ,
   CONSTRAINT [DF_Coin_Reference] DEFAULT ('') FOR [Reference] ,
   CONSTRAINT [DF_Coin_Notes] DEFAULT ('') FOR [Notes]
GO

ALTER TABLE [dbo].[Coin] WITH NOCHECK ADD
   CONSTRAINT [PK_Coin] PRIMARY KEY NONCLUSTERED
   ([CoinID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Coin_MemberID]
   ON [dbo].[Coin]
   ([MemberID], [CoinDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Coin_CompanyID]
   ON [dbo].[Coin]
   ([CompanyID], [CoinDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO