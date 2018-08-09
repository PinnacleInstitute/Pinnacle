EXEC [dbo].pts_CheckTableRebuild 'ProductType'
 GO

ALTER TABLE [dbo].[ProductType] WITH NOCHECK ADD
   CONSTRAINT [DF_ProductType_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_ProductType_ProductTypeName] DEFAULT ('') FOR [ProductTypeName] ,
   CONSTRAINT [DF_ProductType_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_ProductType_IsPrivate] DEFAULT (0) FOR [IsPrivate] ,
   CONSTRAINT [DF_ProductType_IsPublic] DEFAULT (0) FOR [IsPublic] ,
   CONSTRAINT [DF_ProductType_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_ProductType_Levels] DEFAULT ('') FOR [Levels]
GO

ALTER TABLE [dbo].[ProductType] WITH NOCHECK ADD
   CONSTRAINT [PK_ProductType] PRIMARY KEY NONCLUSTERED
   ([ProductTypeID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_ProductType_CompanyID]
   ON [dbo].[ProductType]
   ([CompanyID], [Seq])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO