EXEC [dbo].pts_CheckTableRebuild 'Genealogy'
 GO

ALTER TABLE [dbo].[Genealogy] WITH NOCHECK ADD
   CONSTRAINT [DF_Genealogy_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Genealogy_GenealogyName] DEFAULT ('') FOR [GenealogyName] ,
   CONSTRAINT [DF_Genealogy_GenealogyNo] DEFAULT (0) FOR [GenealogyNo]
GO

ALTER TABLE [dbo].[Genealogy] WITH NOCHECK ADD
   CONSTRAINT [PK_Genealogy] PRIMARY KEY NONCLUSTERED
   ([GenealogyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Genealogy_CompanyID]
   ON [dbo].[Genealogy]
   ([CompanyID], [GenealogyNo])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO