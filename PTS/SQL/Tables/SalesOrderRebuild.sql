EXEC [dbo].pts_CheckTableRebuild 'SalesOrder'
 GO

ALTER TABLE [dbo].[SalesOrder] WITH NOCHECK ADD
   CONSTRAINT [DF_SalesOrder_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_SalesOrder_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_SalesOrder_ProspectID] DEFAULT (0) FOR [ProspectID] ,
   CONSTRAINT [DF_SalesOrder_AffiliateID] DEFAULT (0) FOR [AffiliateID] ,
   CONSTRAINT [DF_SalesOrder_PromotionID] DEFAULT (0) FOR [PromotionID] ,
   CONSTRAINT [DF_SalesOrder_PartyID] DEFAULT (0) FOR [PartyID] ,
   CONSTRAINT [DF_SalesOrder_AddressID] DEFAULT (0) FOR [AddressID] ,
   CONSTRAINT [DF_SalesOrder_OrderDate] DEFAULT (0) FOR [OrderDate] ,
   CONSTRAINT [DF_SalesOrder_Amount] DEFAULT (0) FOR [Amount] ,
   CONSTRAINT [DF_SalesOrder_Tax] DEFAULT (0) FOR [Tax] ,
   CONSTRAINT [DF_SalesOrder_Total] DEFAULT (0) FOR [Total] ,
   CONSTRAINT [DF_SalesOrder_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_SalesOrder_Notes] DEFAULT ('') FOR [Notes] ,
   CONSTRAINT [DF_SalesOrder_Discount] DEFAULT (0) FOR [Discount] ,
   CONSTRAINT [DF_SalesOrder_Shipping] DEFAULT (0) FOR [Shipping] ,
   CONSTRAINT [DF_SalesOrder_Ship] DEFAULT (0) FOR [Ship] ,
   CONSTRAINT [DF_SalesOrder_IsTaxable] DEFAULT (0) FOR [IsTaxable] ,
   CONSTRAINT [DF_SalesOrder_IsRecur] DEFAULT (0) FOR [IsRecur] ,
   CONSTRAINT [DF_SalesOrder_PinnDate] DEFAULT (0) FOR [PinnDate] ,
   CONSTRAINT [DF_SalesOrder_PinnAmount] DEFAULT (0) FOR [PinnAmount] ,
   CONSTRAINT [DF_SalesOrder_CommDate] DEFAULT (0) FOR [CommDate] ,
   CONSTRAINT [DF_SalesOrder_CommAmount] DEFAULT (0) FOR [CommAmount] ,
   CONSTRAINT [DF_SalesOrder_AutoShip] DEFAULT (0) FOR [AutoShip] ,
   CONSTRAINT [DF_SalesOrder_IsActive] DEFAULT (0) FOR [IsActive] ,
   CONSTRAINT [DF_SalesOrder_BV] DEFAULT (0) FOR [BV] ,
   CONSTRAINT [DF_SalesOrder_Track] DEFAULT ('') FOR [Track] ,
   CONSTRAINT [DF_SalesOrder_Valid] DEFAULT (0) FOR [Valid]
GO

ALTER TABLE [dbo].[SalesOrder] WITH NOCHECK ADD
   CONSTRAINT [PK_SalesOrder] PRIMARY KEY NONCLUSTERED
   ([SalesOrderID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_SalesOrder_CompanyID]
   ON [dbo].[SalesOrder]
   ([CompanyID], [OrderDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_SalesOrder_MemberID]
   ON [dbo].[SalesOrder]
   ([MemberID], [OrderDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_SalesOrder_ProspectID]
   ON [dbo].[SalesOrder]
   ([ProspectID], [OrderDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_SalesOrder_PromotionID]
   ON [dbo].[SalesOrder]
   ([PromotionID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_SalesOrder_PartyID]
   ON [dbo].[SalesOrder]
   ([PartyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_SalesOrder_AffiliateID]
   ON [dbo].[SalesOrder]
   ([AffiliateID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO