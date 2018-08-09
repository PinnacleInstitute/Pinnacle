EXEC [dbo].pts_CheckTableRebuild 'SilverHeart'
 GO

ALTER TABLE [dbo].[SilverHeart] WITH NOCHECK ADD

GO

ALTER TABLE [dbo].[SilverHeart] WITH NOCHECK ADD
   CONSTRAINT [PK_SilverHeart] PRIMARY KEY NONCLUSTERED
   ([SilverHeartID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO