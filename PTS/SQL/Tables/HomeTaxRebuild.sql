EXEC [dbo].pts_CheckTableRebuild 'HomeTax'
 GO

ALTER TABLE [dbo].[HomeTax] WITH NOCHECK ADD
   CONSTRAINT [DF_HomeTax_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_HomeTax_TaxRate] DEFAULT (0) FOR [TaxRate] ,
   CONSTRAINT [DF_HomeTax_Office] DEFAULT (0) FOR [Office] ,
   CONSTRAINT [DF_HomeTax_Miles] DEFAULT (0) FOR [Miles] ,
   CONSTRAINT [DF_HomeTax_Home] DEFAULT (0) FOR [Home] ,
   CONSTRAINT [DF_HomeTax_Meetings] DEFAULT (0) FOR [Meetings] ,
   CONSTRAINT [DF_HomeTax_Meals] DEFAULT (0) FOR [Meals] ,
   CONSTRAINT [DF_HomeTax_Supplies] DEFAULT (0) FOR [Supplies] ,
   CONSTRAINT [DF_HomeTax_Gifts] DEFAULT (0) FOR [Gifts] ,
   CONSTRAINT [DF_HomeTax_Materials] DEFAULT (0) FOR [Materials] ,
   CONSTRAINT [DF_HomeTax_Phones] DEFAULT (0) FOR [Phones] ,
   CONSTRAINT [DF_HomeTax_Internet] DEFAULT (0) FOR [Internet] ,
   CONSTRAINT [DF_HomeTax_Kids] DEFAULT (0) FOR [Kids] ,
   CONSTRAINT [DF_HomeTax_Subscriptions] DEFAULT (0) FOR [Subscriptions] ,
   CONSTRAINT [DF_HomeTax_Entertainment] DEFAULT (0) FOR [Entertainment] ,
   CONSTRAINT [DF_HomeTax_Activities] DEFAULT (0) FOR [Activities] ,
   CONSTRAINT [DF_HomeTax_Events] DEFAULT (0) FOR [Events] ,
   CONSTRAINT [DF_HomeTax_Medical] DEFAULT (0) FOR [Medical] ,
   CONSTRAINT [DF_HomeTax_Recreational] DEFAULT (0) FOR [Recreational]
GO

ALTER TABLE [dbo].[HomeTax] WITH NOCHECK ADD
   CONSTRAINT [PK_HomeTax] PRIMARY KEY NONCLUSTERED
   ([HomeTaxID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_HomeTax_MemberID]
   ON [dbo].[HomeTax]
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO