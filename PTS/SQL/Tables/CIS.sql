EXEC [dbo].pts_CheckTable 'CIS'
 GO

CREATE TABLE [dbo].[CIS] (
   [CisID] int IDENTITY (1,1) NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CIS] WITH NOCHECK ADD

GO

ALTER TABLE [dbo].[CIS] WITH NOCHECK ADD
   CONSTRAINT [PK_CIS] PRIMARY KEY NONCLUSTERED
   ([CisID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO