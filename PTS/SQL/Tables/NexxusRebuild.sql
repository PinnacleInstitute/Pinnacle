EXEC [dbo].pts_CheckTableRebuild 'Nexxus'
 GO

ALTER TABLE [dbo].[Nexxus] WITH NOCHECK ADD

GO

ALTER TABLE [dbo].[Nexxus] WITH NOCHECK ADD
   CONSTRAINT [PK_Nexxus] PRIMARY KEY NONCLUSTERED
   ([NexxusID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO