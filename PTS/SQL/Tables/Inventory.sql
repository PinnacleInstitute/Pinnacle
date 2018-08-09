EXEC [dbo].pts_CheckTable 'Inventory'
 GO

CREATE TABLE [dbo].[Inventory] (
   [InventoryID] int IDENTITY (1,1) NOT NULL ,
   [MemberID] int NOT NULL ,
   [ProductID] int NOT NULL ,
   [Attribute1] nvarchar (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Attribute2] nvarchar (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Attribute3] nvarchar (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [InStock] int NOT NULL ,
   [ReOrder] int NOT NULL 
   ) ON [PRIMARY]
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