EXEC [dbo].pts_CheckTableRebuild 'Silver'
 GO

ALTER TABLE [dbo].[Silver] WITH NOCHECK ADD

GO

ALTER TABLE [dbo].[Silver] WITH NOCHECK ADD
   CONSTRAINT [PK_Silver] PRIMARY KEY NONCLUSTERED
   ([SilverID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO