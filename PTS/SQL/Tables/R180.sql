EXEC [dbo].pts_CheckTable 'R180'
 GO

CREATE TABLE [dbo].[R180] (
   [R180ID] int IDENTITY (1,1) NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[R180] WITH NOCHECK ADD

GO

ALTER TABLE [dbo].[R180] WITH NOCHECK ADD
   CONSTRAINT [PK_R180] PRIMARY KEY NONCLUSTERED
   ([R180ID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO