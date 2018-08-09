EXEC [dbo].pts_CheckTableRebuild 'BarterArea'
 GO

ALTER TABLE [dbo].[BarterArea] WITH NOCHECK ADD
   CONSTRAINT [DF_BarterArea_ParentID] DEFAULT (0) FOR [ParentID] ,
   CONSTRAINT [DF_BarterArea_CountryID] DEFAULT (0) FOR [CountryID] ,
   CONSTRAINT [DF_BarterArea_ConsumerID] DEFAULT (0) FOR [ConsumerID] ,
   CONSTRAINT [DF_BarterArea_BarterAreaName] DEFAULT ('') FOR [BarterAreaName] ,
   CONSTRAINT [DF_BarterArea_BarterAreaType] DEFAULT (0) FOR [BarterAreaType] ,
   CONSTRAINT [DF_BarterArea_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_BarterArea_Children] DEFAULT (0) FOR [Children]
GO

ALTER TABLE [dbo].[BarterArea] WITH NOCHECK ADD
   CONSTRAINT [PK_BarterArea] PRIMARY KEY NONCLUSTERED
   ([BarterAreaID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_BarterArea_ParentID]
   ON [dbo].[BarterArea]
   ([ParentID], [CountryID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO