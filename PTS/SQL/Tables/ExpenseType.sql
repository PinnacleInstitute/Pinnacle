EXEC [dbo].pts_CheckTable 'ExpenseType'
 GO

CREATE TABLE [dbo].[ExpenseType] (
   [ExpenseTypeID] int IDENTITY (1,1) NOT NULL ,
   [ExpType] int NOT NULL ,
   [ExpenseTypeName] nvarchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Seq] int NOT NULL ,
   [TaxType] int NOT NULL ,
   [IsRequired] bit NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ExpenseType] WITH NOCHECK ADD
   CONSTRAINT [DF_ExpenseType_ExpType] DEFAULT (0) FOR [ExpType] ,
   CONSTRAINT [DF_ExpenseType_ExpenseTypeName] DEFAULT ('') FOR [ExpenseTypeName] ,
   CONSTRAINT [DF_ExpenseType_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_ExpenseType_TaxType] DEFAULT (0) FOR [TaxType] ,
   CONSTRAINT [DF_ExpenseType_IsRequired] DEFAULT (0) FOR [IsRequired]
GO

ALTER TABLE [dbo].[ExpenseType] WITH NOCHECK ADD
   CONSTRAINT [PK_ExpenseType] PRIMARY KEY NONCLUSTERED
   ([ExpenseTypeID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO