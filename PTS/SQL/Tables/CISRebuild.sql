EXEC [dbo].pts_CheckTableRebuild 'CIS'
 GO

ALTER TABLE [dbo].[CIS] WITH NOCHECK ADD

GO

ALTER TABLE [dbo].[CIS] WITH NOCHECK ADD
   CONSTRAINT [PK_CIS] PRIMARY KEY NONCLUSTERED
   ([CisID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO