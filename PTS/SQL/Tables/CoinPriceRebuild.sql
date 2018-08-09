EXEC [dbo].pts_CheckTableRebuild 'CoinPrice'
 GO

ALTER TABLE [dbo].[CoinPrice] WITH NOCHECK ADD
   CONSTRAINT [DF_CoinPrice_Coin] DEFAULT (0) FOR [Coin] ,
   CONSTRAINT [DF_CoinPrice_Source] DEFAULT (0) FOR [Source] ,
   CONSTRAINT [DF_CoinPrice_Price] DEFAULT (0) FOR [Price] ,
   CONSTRAINT [DF_CoinPrice_PriceDate] DEFAULT (0) FOR [PriceDate] ,
   CONSTRAINT [DF_CoinPrice_CurrencyCode] DEFAULT ('') FOR [CurrencyCode] ,
   CONSTRAINT [DF_CoinPrice_Status] DEFAULT (0) FOR [Status]
GO

ALTER TABLE [dbo].[CoinPrice] WITH NOCHECK ADD
   CONSTRAINT [PK_CoinPrice] PRIMARY KEY NONCLUSTERED
   ([CoinPriceID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_CoinPrice_Coin]
   ON [dbo].[CoinPrice]
   ([Coin], [CurrencyCode], [Status])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_CoinPrice_Source]
   ON [dbo].[CoinPrice]
   ([Source], [Coin], [CurrencyCode])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO