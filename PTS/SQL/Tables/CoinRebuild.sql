EXEC [dbo].pts_CheckTableRebuild 'Coin'
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