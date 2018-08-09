EXEC [dbo].pts_CheckTable 'Product'
 GO

CREATE TABLE [dbo].[Product] (
   [ProductID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [ProductTypeID] int NOT NULL ,
   [ProductName] nvarchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Image] nvarchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Price] money NOT NULL ,
   [OriginalPrice] money NOT NULL ,
   [IsTaxable] bit NOT NULL ,
   [TaxRate] money NOT NULL ,
   [Tax] money NOT NULL ,
   [Description] nvarchar (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Seq] int NOT NULL ,
   [IsActive] bit NOT NULL ,
   [IsPrivate] bit NOT NULL ,
   [IsPublic] bit NOT NULL ,
   [NoQty] bit NOT NULL ,
   [Data] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Email] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [InputOptions] nvarchar (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Ship1] money NOT NULL ,
   [Ship2] money NOT NULL ,
   [Ship3] money NOT NULL ,
   [Ship4] money NOT NULL ,
   [Ship1a] money NOT NULL ,
   [Ship2a] money NOT NULL ,
   [Ship3a] money NOT NULL ,
   [Ship4a] money NOT NULL ,
   [Fulfill] int NOT NULL ,
   [Recur] int NOT NULL ,
   [RecurTerm] varchar (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [CommPlan] int NOT NULL ,
   [BV] money NOT NULL ,
   [QV] money NOT NULL ,
   [Code] varchar (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Inventory] int NOT NULL ,
   [InStock] int NOT NULL ,
   [ReOrder] int NOT NULL ,
   [IsShip] bit NOT NULL ,
   [OrderMin] int NOT NULL ,
   [OrderMax] int NOT NULL ,
   [OrderMul] int NOT NULL ,
   [OrderGrp] varchar (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Attribute1] varchar (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Attribute2] varchar (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Attribute3] varchar (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Levels] varchar (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [FulFillInfo] varchar (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Product] WITH NOCHECK ADD
   CONSTRAINT [DF_Product_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Product_ProductTypeID] DEFAULT (0) FOR [ProductTypeID] ,
   CONSTRAINT [DF_Product_ProductName] DEFAULT ('') FOR [ProductName] ,
   CONSTRAINT [DF_Product_Image] DEFAULT ('') FOR [Image] ,
   CONSTRAINT [DF_Product_Price] DEFAULT (0) FOR [Price] ,
   CONSTRAINT [DF_Product_OriginalPrice] DEFAULT (0) FOR [OriginalPrice] ,
   CONSTRAINT [DF_Product_IsTaxable] DEFAULT (0) FOR [IsTaxable] ,
   CONSTRAINT [DF_Product_TaxRate] DEFAULT (0) FOR [TaxRate] ,
   CONSTRAINT [DF_Product_Tax] DEFAULT (0) FOR [Tax] ,
   CONSTRAINT [DF_Product_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_Product_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_Product_IsActive] DEFAULT (0) FOR [IsActive] ,
   CONSTRAINT [DF_Product_IsPrivate] DEFAULT (0) FOR [IsPrivate] ,
   CONSTRAINT [DF_Product_IsPublic] DEFAULT (0) FOR [IsPublic] ,
   CONSTRAINT [DF_Product_NoQty] DEFAULT (0) FOR [NoQty] ,
   CONSTRAINT [DF_Product_Data] DEFAULT ('') FOR [Data] ,
   CONSTRAINT [DF_Product_Email] DEFAULT ('') FOR [Email] ,
   CONSTRAINT [DF_Product_InputOptions] DEFAULT ('') FOR [InputOptions] ,
   CONSTRAINT [DF_Product_Ship1] DEFAULT (0) FOR [Ship1] ,
   CONSTRAINT [DF_Product_Ship2] DEFAULT (0) FOR [Ship2] ,
   CONSTRAINT [DF_Product_Ship3] DEFAULT (0) FOR [Ship3] ,
   CONSTRAINT [DF_Product_Ship4] DEFAULT (0) FOR [Ship4] ,
   CONSTRAINT [DF_Product_Ship1a] DEFAULT (0) FOR [Ship1a] ,
   CONSTRAINT [DF_Product_Ship2a] DEFAULT (0) FOR [Ship2a] ,
   CONSTRAINT [DF_Product_Ship3a] DEFAULT (0) FOR [Ship3a] ,
   CONSTRAINT [DF_Product_Ship4a] DEFAULT (0) FOR [Ship4a] ,
   CONSTRAINT [DF_Product_Fulfill] DEFAULT (0) FOR [Fulfill] ,
   CONSTRAINT [DF_Product_Recur] DEFAULT (0) FOR [Recur] ,
   CONSTRAINT [DF_Product_RecurTerm] DEFAULT ('') FOR [RecurTerm] ,
   CONSTRAINT [DF_Product_CommPlan] DEFAULT (0) FOR [CommPlan] ,
   CONSTRAINT [DF_Product_BV] DEFAULT (0) FOR [BV] ,
   CONSTRAINT [DF_Product_QV] DEFAULT (0) FOR [QV] ,
   CONSTRAINT [DF_Product_Code] DEFAULT ('') FOR [Code] ,
   CONSTRAINT [DF_Product_Inventory] DEFAULT (0) FOR [Inventory] ,
   CONSTRAINT [DF_Product_InStock] DEFAULT (0) FOR [InStock] ,
   CONSTRAINT [DF_Product_ReOrder] DEFAULT (0) FOR [ReOrder] ,
   CONSTRAINT [DF_Product_IsShip] DEFAULT (0) FOR [IsShip] ,
   CONSTRAINT [DF_Product_OrderMin] DEFAULT (0) FOR [OrderMin] ,
   CONSTRAINT [DF_Product_OrderMax] DEFAULT (0) FOR [OrderMax] ,
   CONSTRAINT [DF_Product_OrderMul] DEFAULT (0) FOR [OrderMul] ,
   CONSTRAINT [DF_Product_OrderGrp] DEFAULT ('') FOR [OrderGrp] ,
   CONSTRAINT [DF_Product_Attribute1] DEFAULT ('') FOR [Attribute1] ,
   CONSTRAINT [DF_Product_Attribute2] DEFAULT ('') FOR [Attribute2] ,
   CONSTRAINT [DF_Product_Attribute3] DEFAULT ('') FOR [Attribute3] ,
   CONSTRAINT [DF_Product_Levels] DEFAULT ('') FOR [Levels] ,
   CONSTRAINT [DF_Product_FulFillInfo] DEFAULT ('') FOR [FulFillInfo]
GO

ALTER TABLE [dbo].[Product] WITH NOCHECK ADD
   CONSTRAINT [PK_Product] PRIMARY KEY NONCLUSTERED
   ([ProductID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Product_CompanyID]
   ON [dbo].[Product]
   ([CompanyID], [ProductTypeID], [Seq])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Product_Code]
   ON [dbo].[Product]
   ([CompanyID], [Code])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO