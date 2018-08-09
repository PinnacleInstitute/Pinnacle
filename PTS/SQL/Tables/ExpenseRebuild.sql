EXEC [dbo].pts_CheckTableRebuild 'Expense'
 GO

ALTER TABLE [dbo].[Expense] WITH NOCHECK ADD
   CONSTRAINT [DF_Expense_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Expense_ExpenseTypeID] DEFAULT (0) FOR [ExpenseTypeID] ,
   CONSTRAINT [DF_Expense_ExpType] DEFAULT (0) FOR [ExpType] ,
   CONSTRAINT [DF_Expense_ExpDate] DEFAULT (0) FOR [ExpDate] ,
   CONSTRAINT [DF_Expense_Total] DEFAULT (0) FOR [Total] ,
   CONSTRAINT [DF_Expense_Amount] DEFAULT (0) FOR [Amount] ,
   CONSTRAINT [DF_Expense_MilesStart] DEFAULT (0) FOR [MilesStart] ,
   CONSTRAINT [DF_Expense_MilesEnd] DEFAULT (0) FOR [MilesEnd] ,
   CONSTRAINT [DF_Expense_TotalMiles] DEFAULT (0) FOR [TotalMiles] ,
   CONSTRAINT [DF_Expense_Note1] DEFAULT ('') FOR [Note1] ,
   CONSTRAINT [DF_Expense_Note2] DEFAULT ('') FOR [Note2] ,
   CONSTRAINT [DF_Expense_Purpose] DEFAULT ('') FOR [Purpose]
GO

ALTER TABLE [dbo].[Expense] WITH NOCHECK ADD
   CONSTRAINT [PK_Expense] PRIMARY KEY NONCLUSTERED
   ([ExpenseID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Expense_Member]
   ON [dbo].[Expense]
   ([MemberID], [ExpType], [ExpDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO