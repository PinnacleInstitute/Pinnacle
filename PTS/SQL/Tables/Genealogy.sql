EXEC [dbo].pts_CheckTable 'Genealogy'
 GO

CREATE TABLE [dbo].[Genealogy] (
   [GenealogyID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [GenealogyName] nvarchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [GenealogyNo] int NOT NULL 
   ) ON [PRIMARY]
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