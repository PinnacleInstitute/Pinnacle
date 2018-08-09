EXEC [dbo].pts_CheckTableRebuild 'ExpenseType'
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