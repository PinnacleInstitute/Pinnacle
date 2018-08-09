EXEC [dbo].pts_CheckTable 'SalesCampaign'
 GO

CREATE TABLE [dbo].[SalesCampaign] (
   [SalesCampaignID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [GroupID] int NOT NULL ,
   [SalesCampaignName] nvarchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Seq] int NOT NULL ,
   [IsCopyURL] bit NOT NULL ,
   [CopyURL] varchar (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Result] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SalesCampaign] WITH NOCHECK ADD
   CONSTRAINT [DF_SalesCampaign_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_SalesCampaign_GroupID] DEFAULT (0) FOR [GroupID] ,
   CONSTRAINT [DF_SalesCampaign_SalesCampaignName] DEFAULT ('') FOR [SalesCampaignName] ,
   CONSTRAINT [DF_SalesCampaign_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_SalesCampaign_IsCopyURL] DEFAULT (0) FOR [IsCopyURL] ,
   CONSTRAINT [DF_SalesCampaign_CopyURL] DEFAULT ('') FOR [CopyURL] ,
   CONSTRAINT [DF_SalesCampaign_Result] DEFAULT ('') FOR [Result]
GO

ALTER TABLE [dbo].[SalesCampaign] WITH NOCHECK ADD
   CONSTRAINT [PK_SalesCampaign] PRIMARY KEY NONCLUSTERED
   ([SalesCampaignID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_SalesCampaign_CompanyID]
   ON [dbo].[SalesCampaign]
   ([CompanyID], [Seq])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_SalesCampaign_GroupID]
   ON [dbo].[SalesCampaign]
   ([GroupID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO