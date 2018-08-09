EXEC [dbo].pts_CheckTable 'SilverHeart'
 GO

CREATE TABLE [dbo].[SilverHeart] (
   [SilverHeartID] int IDENTITY (1,1) NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SilverHeart] WITH NOCHECK ADD

GO

ALTER TABLE [dbo].[SilverHeart] WITH NOCHECK ADD
   CONSTRAINT [PK_SilverHeart] PRIMARY KEY NONCLUSTERED
   ([SilverHeartID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO