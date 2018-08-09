EXEC [dbo].pts_CheckTableRebuild 'Finance'
 GO

ALTER TABLE [dbo].[Finance] WITH NOCHECK ADD
   CONSTRAINT [DF_Finance_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Finance_Payoff] DEFAULT (0) FOR [Payoff] ,
   CONSTRAINT [DF_Finance_Payment] DEFAULT (0) FOR [Payment] ,
   CONSTRAINT [DF_Finance_Savings] DEFAULT (0) FOR [Savings] ,
   CONSTRAINT [DF_Finance_StartDate] DEFAULT (0) FOR [StartDate] ,
   CONSTRAINT [DF_Finance_ROI] DEFAULT (0) FOR [ROI] ,
   CONSTRAINT [DF_Finance_SavingsRate] DEFAULT (0) FOR [SavingsRate] ,
   CONSTRAINT [DF_Finance_IsMinPayment] DEFAULT (0) FOR [IsMinPayment]
GO

ALTER TABLE [dbo].[Finance] WITH NOCHECK ADD
   CONSTRAINT [PK_Finance] PRIMARY KEY NONCLUSTERED
   ([FinanceID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Finance_MemberID]
   ON [dbo].[Finance]
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO