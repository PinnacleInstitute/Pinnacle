EXEC [dbo].pts_CheckTableRebuild 'Sims'
 GO

ALTER TABLE [dbo].[Sims] WITH NOCHECK ADD

GO

ALTER TABLE [dbo].[Sims] WITH NOCHECK ADD
   CONSTRAINT [PK_Sims] PRIMARY KEY NONCLUSTERED
   ([SimsID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO