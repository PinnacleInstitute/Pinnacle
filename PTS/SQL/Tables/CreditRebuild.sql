EXEC [dbo].pts_CheckTableRebuild 'Credit'
 GO

ALTER TABLE [dbo].[Credit] WITH NOCHECK ADD
   CONSTRAINT [DF_Credit_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Credit_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Credit_CreditDate] DEFAULT (0) FOR [CreditDate] ,
   CONSTRAINT [DF_Credit_CreditType] DEFAULT (0) FOR [CreditType] ,
   CONSTRAINT [DF_Credit_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Credit_Total] DEFAULT (0) FOR [Total] ,
   CONSTRAINT [DF_Credit_Used] DEFAULT (0) FOR [Used] ,
   CONSTRAINT [DF_Credit_Balance] DEFAULT (0) FOR [Balance]
GO

ALTER TABLE [dbo].[Credit] WITH NOCHECK ADD
   CONSTRAINT [PK_Credit] PRIMARY KEY NONCLUSTERED
   ([CreditID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Credit_CompanyID]
   ON [dbo].[Credit]
   ([CompanyID], [MemberID], [CreditDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO