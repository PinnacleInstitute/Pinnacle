EXEC [dbo].pts_CheckTable 'Promotion'
 GO

CREATE TABLE [dbo].[Promotion] (
   [PromotionID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [ProductID] int NOT NULL ,
   [PromotionName] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Description] nvarchar (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Code] nvarchar (6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Amount] money NOT NULL ,
   [Rate] money NOT NULL ,
   [StartDate] datetime NOT NULL ,
   [EndDate] datetime NOT NULL ,
   [Qty] int NOT NULL ,
   [Used] int NOT NULL ,
   [Products] nvarchar (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Promotion] WITH NOCHECK ADD
   CONSTRAINT [DF_Promotion_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Promotion_ProductID] DEFAULT (0) FOR [ProductID] ,
   CONSTRAINT [DF_Promotion_PromotionName] DEFAULT ('') FOR [PromotionName] ,
   CONSTRAINT [DF_Promotion_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_Promotion_Code] DEFAULT ('') FOR [Code] ,
   CONSTRAINT [DF_Promotion_Amount] DEFAULT (0) FOR [Amount] ,
   CONSTRAINT [DF_Promotion_Rate] DEFAULT (0) FOR [Rate] ,
   CONSTRAINT [DF_Promotion_StartDate] DEFAULT (0) FOR [StartDate] ,
   CONSTRAINT [DF_Promotion_EndDate] DEFAULT (0) FOR [EndDate] ,
   CONSTRAINT [DF_Promotion_Qty] DEFAULT (0) FOR [Qty] ,
   CONSTRAINT [DF_Promotion_Used] DEFAULT (0) FOR [Used] ,
   CONSTRAINT [DF_Promotion_Products] DEFAULT ('') FOR [Products]
GO

ALTER TABLE [dbo].[Promotion] WITH NOCHECK ADD
   CONSTRAINT [PK_Promotion] PRIMARY KEY NONCLUSTERED
   ([PromotionID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Promotion_Code]
   ON [dbo].[Promotion]
   ([CompanyID], [Code])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO