EXEC [dbo].pts_CheckTableRebuild 'EmailSource'
 GO

ALTER TABLE [dbo].[EmailSource] WITH NOCHECK ADD
   CONSTRAINT [DF_EmailSource_EmailSourceName] DEFAULT ('') FOR [EmailSourceName] ,
   CONSTRAINT [DF_EmailSource_EmailSourceFrom] DEFAULT ('') FOR [EmailSourceFrom] ,
   CONSTRAINT [DF_EmailSource_EmailSourceFields] DEFAULT ('') FOR [EmailSourceFields]
GO

ALTER TABLE [dbo].[EmailSource] WITH NOCHECK ADD
   CONSTRAINT [PK_EmailSource] PRIMARY KEY NONCLUSTERED
   ([EmailSourceID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE UNIQUE INDEX [UI_EmailSource_EmailSourceName]
   ON [dbo].[EmailSource]
   ([EmailSourceName])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO