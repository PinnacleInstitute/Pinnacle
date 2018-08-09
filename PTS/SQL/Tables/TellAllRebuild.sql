EXEC [dbo].pts_CheckTableRebuild 'TellAll'
 GO

ALTER TABLE [dbo].[TellAll] WITH NOCHECK ADD

GO

ALTER TABLE [dbo].[TellAll] WITH NOCHECK ADD
   CONSTRAINT [PK_TellAll] PRIMARY KEY NONCLUSTERED
   ([TellAllID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO