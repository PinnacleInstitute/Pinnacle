EXEC [dbo].pts_CheckTable 'SalesItem'
 GO

CREATE TABLE [dbo].[SalesItem] (
   [SalesItemID] int IDENTITY (1,1) NOT NULL ,
   [SalesOrderID] int NOT NULL ,
   [ProductID] int NOT NULL ,
   [Quantity] int NOT NULL ,
   [Price] money NOT NULL ,
   [OptionPrice] money NOT NULL ,
   [Tax] money NOT NULL ,
   [InputValues] nvarchar (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Reference] nvarchar (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [BillDate] datetime NOT NULL ,
   [EndDate] datetime NOT NULL ,
   [Locks] int NOT NULL ,
   [BV] money NOT NULL ,
   [Valid] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SalesItem] WITH NOCHECK ADD
   CONSTRAINT [DF_SalesItem_SalesOrderID] DEFAULT (0) FOR [SalesOrderID] ,
   CONSTRAINT [DF_SalesItem_ProductID] DEFAULT (0) FOR [ProductID] ,
   CONSTRAINT [DF_SalesItem_Quantity] DEFAULT (0) FOR [Quantity] ,
   CONSTRAINT [DF_SalesItem_Price] DEFAULT (0) FOR [Price] ,
   CONSTRAINT [DF_SalesItem_OptionPrice] DEFAULT (0) FOR [OptionPrice] ,
   CONSTRAINT [DF_SalesItem_Tax] DEFAULT (0) FOR [Tax] ,
   CONSTRAINT [DF_SalesItem_InputValues] DEFAULT ('') FOR [InputValues] ,
   CONSTRAINT [DF_SalesItem_Reference] DEFAULT ('') FOR [Reference] ,
   CONSTRAINT [DF_SalesItem_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_SalesItem_BillDate] DEFAULT (0) FOR [BillDate] ,
   CONSTRAINT [DF_SalesItem_EndDate] DEFAULT (0) FOR [EndDate] ,
   CONSTRAINT [DF_SalesItem_Locks] DEFAULT (0) FOR [Locks] ,
   CONSTRAINT [DF_SalesItem_BV] DEFAULT (0) FOR [BV] ,
   CONSTRAINT [DF_SalesItem_Valid] DEFAULT (0) FOR [Valid]
GO

ALTER TABLE [dbo].[SalesItem] WITH NOCHECK ADD
   CONSTRAINT [PK_SalesItem] PRIMARY KEY NONCLUSTERED
   ([SalesItemID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO