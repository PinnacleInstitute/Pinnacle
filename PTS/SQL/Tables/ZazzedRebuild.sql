EXEC [dbo].pts_CheckTableRebuild 'Zazzed'
 GO

ALTER TABLE [dbo].[Zazzed] WITH NOCHECK ADD

GO

ALTER TABLE [dbo].[Zazzed] WITH NOCHECK ADD
   CONSTRAINT [PK_Zazzed] PRIMARY KEY NONCLUSTERED
   ([ZazzedID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO