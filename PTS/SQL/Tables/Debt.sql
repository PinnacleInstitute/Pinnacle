EXEC [dbo].pts_CheckTable 'Debt'
 GO

CREATE TABLE [dbo].[Debt] (
   [DebtID] int IDENTITY (1,1) NOT NULL ,
   [MemberID] int NOT NULL ,
   [DebtType] int NOT NULL ,
   [DebtName] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Balance] money NOT NULL ,
   [Payment] money NOT NULL ,
   [MinPayment] money NOT NULL ,
   [IntRate] money NOT NULL ,
   [IntPaid] money NOT NULL ,
   [MonthsPaid] int NOT NULL ,
   [IsActive] bit NOT NULL ,
   [IsConsolidate] bit NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Debt] WITH NOCHECK ADD
   CONSTRAINT [DF_Debt_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Debt_DebtType] DEFAULT (0) FOR [DebtType] ,
   CONSTRAINT [DF_Debt_DebtName] DEFAULT ('') FOR [DebtName] ,
   CONSTRAINT [DF_Debt_Balance] DEFAULT (0) FOR [Balance] ,
   CONSTRAINT [DF_Debt_Payment] DEFAULT (0) FOR [Payment] ,
   CONSTRAINT [DF_Debt_MinPayment] DEFAULT (0) FOR [MinPayment] ,
   CONSTRAINT [DF_Debt_IntRate] DEFAULT (0) FOR [IntRate] ,
   CONSTRAINT [DF_Debt_IntPaid] DEFAULT (0) FOR [IntPaid] ,
   CONSTRAINT [DF_Debt_MonthsPaid] DEFAULT (0) FOR [MonthsPaid] ,
   CONSTRAINT [DF_Debt_IsActive] DEFAULT (0) FOR [IsActive] ,
   CONSTRAINT [DF_Debt_IsConsolidate] DEFAULT (0) FOR [IsConsolidate]
GO

ALTER TABLE [dbo].[Debt] WITH NOCHECK ADD
   CONSTRAINT [PK_Debt] PRIMARY KEY NONCLUSTERED
   ([DebtID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Debt_MemberID]
   ON [dbo].[Debt]
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO