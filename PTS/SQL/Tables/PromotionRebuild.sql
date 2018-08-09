EXEC [dbo].pts_CheckTableRebuild 'Promotion'
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