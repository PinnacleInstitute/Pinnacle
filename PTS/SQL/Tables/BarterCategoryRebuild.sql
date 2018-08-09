EXEC [dbo].pts_CheckTableRebuild 'BarterCategory'
 GO

ALTER TABLE [dbo].[BarterCategory] WITH NOCHECK ADD
   CONSTRAINT [DF_BarterCategory_ParentID] DEFAULT (0) FOR [ParentID] ,
   CONSTRAINT [DF_BarterCategory_BarterCategoryName] DEFAULT ('') FOR [BarterCategoryName] ,
   CONSTRAINT [DF_BarterCategory_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_BarterCategory_CustomFields] DEFAULT ('') FOR [CustomFields] ,
   CONSTRAINT [DF_BarterCategory_Children] DEFAULT (0) FOR [Children] ,
   CONSTRAINT [DF_BarterCategory_Options] DEFAULT ('') FOR [Options] ,
   CONSTRAINT [DF_BarterCategory_Seq] DEFAULT (0) FOR [Seq]
GO

ALTER TABLE [dbo].[BarterCategory] WITH NOCHECK ADD
   CONSTRAINT [PK_BarterCategory] PRIMARY KEY NONCLUSTERED
   ([BarterCategoryID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_BarterCategory_ParentID]
   ON [dbo].[BarterCategory]
   ([ParentID], [Seq], [BarterCategoryName])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO