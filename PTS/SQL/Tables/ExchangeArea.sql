EXEC [dbo].pts_CheckTable 'ExchangeArea'
 GO

CREATE TABLE [dbo].[ExchangeArea] (
   [ExchangeAreaID] int IDENTITY (1,1) NOT NULL ,
   [ExchangeID] int NOT NULL ,
   [CountryID] int NOT NULL ,
   [State] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
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