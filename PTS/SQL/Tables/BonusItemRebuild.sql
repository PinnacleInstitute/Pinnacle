EXEC [dbo].pts_CheckTableRebuild 'BonusItem'
 GO

ALTER TABLE [dbo].[BonusItem] WITH NOCHECK ADD
   CONSTRAINT [DF_BonusItem_BonusID] DEFAULT (0) FOR [BonusID] ,
   CONSTRAINT [DF_BonusItem_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_BonusItem_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_BonusItem_MemberBonusID] DEFAULT (0) FOR [MemberBonusID] ,
   CONSTRAINT [DF_BonusItem_CommType] DEFAULT (0) FOR [CommType] ,
   CONSTRAINT [DF_BonusItem_Amount] DEFAULT (0) FOR [Amount] ,
   CONSTRAINT [DF_BonusItem_Reference] DEFAULT ('') FOR [Reference]
GO

ALTER TABLE [dbo].[BonusItem] WITH NOCHECK ADD
   CONSTRAINT [PK_BonusItem] PRIMARY KEY NONCLUSTERED
   ([BonusItemID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_BonusItem_BonusID]
   ON [dbo].[BonusItem]
   ([BonusID], [CommType])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_BonusItem_MemberBonusID]
   ON [dbo].[BonusItem]
   ([MemberBonusID], [CommType])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_BonusItem_CompanyID]
   ON [dbo].[BonusItem]
   ([CompanyID], [MemberBonusID], [MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO