EXEC [dbo].pts_CheckTableRebuild 'Prepaid'
 GO

ALTER TABLE [dbo].[Prepaid] WITH NOCHECK ADD
   CONSTRAINT [DF_Prepaid_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Prepaid_RefID] DEFAULT (0) FOR [RefID] ,
   CONSTRAINT [DF_Prepaid_PayDate] DEFAULT (0) FOR [PayDate] ,
   CONSTRAINT [DF_Prepaid_PayType] DEFAULT (0) FOR [PayType] ,
   CONSTRAINT [DF_Prepaid_Amount] DEFAULT (0) FOR [Amount] ,
   CONSTRAINT [DF_Prepaid_Note] DEFAULT ('') FOR [Note] ,
   CONSTRAINT [DF_Prepaid_BV] DEFAULT (0) FOR [BV] ,
   CONSTRAINT [DF_Prepaid_Bonus] DEFAULT (0) FOR [Bonus]
GO

ALTER TABLE [dbo].[Prepaid] WITH NOCHECK ADD
   CONSTRAINT [PK_Prepaid] PRIMARY KEY NONCLUSTERED
   ([PrepaidID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Prepaid_MemberID]
   ON [dbo].[Prepaid]
   ([MemberID], [PayDate], [PayType])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO