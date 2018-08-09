EXEC [dbo].pts_CheckTableRebuild 'ExchangeArea'
 GO

ALTER TABLE [dbo].[ExchangeArea] WITH NOCHECK ADD
   CONSTRAINT [DF_ExchangeArea_ExchangeID] DEFAULT (0) FOR [ExchangeID] ,
   CONSTRAINT [DF_ExchangeArea_CountryID] DEFAULT (0) FOR [CountryID] ,
   CONSTRAINT [DF_ExchangeArea_State] DEFAULT ('') FOR [State]
GO

ALTER TABLE [dbo].[ExchangeArea] WITH NOCHECK ADD
   CONSTRAINT [PK_ExchangeArea] PRIMARY KEY NONCLUSTERED
   ([ExchangeAreaID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_ExchangeArea_ExchangeID]
   ON [dbo].[ExchangeArea]
   ([ExchangeID], [CountryID], [State])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO