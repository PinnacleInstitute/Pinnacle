EXEC [dbo].pts_CheckTableRebuild 'Bonus'
 GO

ALTER TABLE [dbo].[Bonus] WITH NOCHECK ADD
   CONSTRAINT [DF_Bonus_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Bonus_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Bonus_BonusDate] DEFAULT (0) FOR [BonusDate] ,
   CONSTRAINT [DF_Bonus_Title] DEFAULT (0) FOR [Title] ,
   CONSTRAINT [DF_Bonus_BV] DEFAULT (0) FOR [BV] ,
   CONSTRAINT [DF_Bonus_QV] DEFAULT (0) FOR [QV] ,
   CONSTRAINT [DF_Bonus_Total] DEFAULT (0) FOR [Total] ,
   CONSTRAINT [DF_Bonus_PaidDate] DEFAULT (0) FOR [PaidDate] ,
   CONSTRAINT [DF_Bonus_Reference] DEFAULT ('') FOR [Reference] ,
   CONSTRAINT [DF_Bonus_IsPrivate] DEFAULT (0) FOR [IsPrivate]
GO

ALTER TABLE [dbo].[Bonus] WITH NOCHECK ADD
   CONSTRAINT [PK_Bonus] PRIMARY KEY NONCLUSTERED
   ([BonusID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Bonus_MemberID]
   ON [dbo].[Bonus]
   ([MemberID], [BonusDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Bonus_CompanyID]
   ON [dbo].[Bonus]
   ([CompanyID], [BonusDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO