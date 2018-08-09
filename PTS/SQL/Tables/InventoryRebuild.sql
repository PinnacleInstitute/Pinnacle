EXEC [dbo].pts_CheckTableRebuild 'Inventory'
 GO

ALTER TABLE [dbo].[Inventory] WITH NOCHECK ADD
   CONSTRAINT [DF_Inventory_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Inventory_ProductID] DEFAULT (0) FOR [ProductID] ,
   CONSTRAINT [DF_Inventory_Attribute1] DEFAULT ('') FOR [Attribute1] ,
   CONSTRAINT [DF_Inventory_Attribute2] DEFAULT ('') FOR [Attribute2] ,
   CONSTRAINT [DF_Inventory_Attribute3] DEFAULT ('') FOR [Attribute3] ,
   CONSTRAINT [DF_Inventory_InStock] DEFAULT (0) FOR [InStock] ,
   CONSTRAINT [DF_Inventory_ReOrder] DEFAULT (0) FOR [ReOrder]
GO

ALTER TABLE [dbo].[Inventory] WITH NOCHECK ADD
   CONSTRAINT [PK_Inventory] PRIMARY KEY NONCLUSTERED
   ([InventoryID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Inventory_Inventory]
   ON [dbo].[Inventory]
   ([MemberID], [ProductID], [Attribute1], [Attribute2], [Attribute3])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO