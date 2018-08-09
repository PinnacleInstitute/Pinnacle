EXEC [dbo].pts_CheckTable 'TellAll'
 GO

CREATE TABLE [dbo].[TellAll] (
   [TellAllID] int IDENTITY (1,1) NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TellAll] WITH NOCHECK ADD

GO

ALTER TABLE [dbo].[TellAll] WITH NOCHECK ADD
   CONSTRAINT [PK_TellAll] PRIMARY KEY NONCLUSTERED
   ([TellAllID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO