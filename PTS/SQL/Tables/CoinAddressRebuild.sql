EXEC [dbo].pts_CheckTableRebuild 'CoinAddress'
 GO

ALTER TABLE [dbo].[CoinAddress] WITH NOCHECK ADD
   CONSTRAINT [DF_CoinAddress_MerchantID] DEFAULT (0) FOR [MerchantID] ,
   CONSTRAINT [DF_CoinAddress_Coin] DEFAULT (0) FOR [Coin] ,
   CONSTRAINT [DF_CoinAddress_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_CoinAddress_Address] DEFAULT ('') FOR [Address]
GO

ALTER TABLE [dbo].[CoinAddress] WITH NOCHECK ADD
   CONSTRAINT [PK_CoinAddress] PRIMARY KEY NONCLUSTERED
   ([CoinAddressID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_CoinAddress_Code]
   ON [dbo].[CoinAddress]
   ([MerchantID], [Coin])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO