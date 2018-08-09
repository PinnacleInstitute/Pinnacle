EXEC [dbo].pts_CheckTable 'Sims'
 GO

CREATE TABLE [dbo].[Sims] (
   [SimsID] int IDENTITY (1,1) NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Sims] WITH NOCHECK ADD

GO

ALTER TABLE [dbo].[Sims] WITH NOCHECK ADD
   CONSTRAINT [PK_Sims] PRIMARY KEY NONCLUSTERED
   ([SimsID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO