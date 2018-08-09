EXEC [dbo].pts_CheckTable 'BarterCampaign'
 GO

CREATE TABLE [dbo].[BarterCampaign] (
   [BarterCampaignID] int IDENTITY (1,1) NOT NULL ,
   [ConsumerID] int NOT NULL ,
   [BarterAdID] int NOT NULL ,
   [BarterAreaID] int NOT NULL ,
   [BarterCategoryID] int NOT NULL ,
   [CampaignName] nvarchar (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [StartDate] datetime NOT NULL ,
   [EndDate] datetime NOT NULL ,
   [IsKeyword] bit NOT NULL ,
   [IsAllCategory] bit NOT NULL ,
   [IsMainCategory] bit NOT NULL ,
   [IsSubCategory] bit NOT NULL ,
   [IsAllLocation] bit NOT NULL ,
   [IsCountry] bit NOT NULL ,
   [IsState] bit NOT NULL ,
   [IsCity] bit NOT NULL ,
   [IsArea] bit NOT NULL ,
   [Keyword] nvarchar (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [FT] nvarchar (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Credits] money NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[BarterCampaign] WITH NOCHECK ADD
   CONSTRAINT [DF_BarterCampaign_ConsumerID] DEFAULT (0) FOR [ConsumerID] ,
   CONSTRAINT [DF_BarterCampaign_BarterAdID] DEFAULT (0) FOR [BarterAdID] ,
   CONSTRAINT [DF_BarterCampaign_BarterAreaID] DEFAULT (0) FOR [BarterAreaID] ,
   CONSTRAINT [DF_BarterCampaign_BarterCategoryID] DEFAULT (0) FOR [BarterCategoryID] ,
   CONSTRAINT [DF_BarterCampaign_CampaignName] DEFAULT ('') FOR [CampaignName] ,
   CONSTRAINT [DF_BarterCampaign_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_BarterCampaign_StartDate] DEFAULT (0) FOR [StartDate] ,
   CONSTRAINT [DF_BarterCampaign_EndDate] DEFAULT (0) FOR [EndDate] ,
   CONSTRAINT [DF_BarterCampaign_IsKeyword] DEFAULT (0) FOR [IsKeyword] ,
   CONSTRAINT [DF_BarterCampaign_IsAllCategory] DEFAULT (0) FOR [IsAllCategory] ,
   CONSTRAINT [DF_BarterCampaign_IsMainCategory] DEFAULT (0) FOR [IsMainCategory] ,
   CONSTRAINT [DF_BarterCampaign_IsSubCategory] DEFAULT (0) FOR [IsSubCategory] ,
   CONSTRAINT [DF_BarterCampaign_IsAllLocation] DEFAULT (0) FOR [IsAllLocation] ,
   CONSTRAINT [DF_BarterCampaign_IsCountry] DEFAULT (0) FOR [IsCountry] ,
   CONSTRAINT [DF_BarterCampaign_IsState] DEFAULT (0) FOR [IsState] ,
   CONSTRAINT [DF_BarterCampaign_IsCity] DEFAULT (0) FOR [IsCity] ,
   CONSTRAINT [DF_BarterCampaign_IsArea] DEFAULT (0) FOR [IsArea] ,
   CONSTRAINT [DF_BarterCampaign_Keyword] DEFAULT ('') FOR [Keyword] ,
   CONSTRAINT [DF_BarterCampaign_FT] DEFAULT ('') FOR [FT] ,
   CONSTRAINT [DF_BarterCampaign_Credits] DEFAULT (0) FOR [Credits]
GO

ALTER TABLE [dbo].[BarterCampaign] WITH NOCHECK ADD
   CONSTRAINT [PK_BarterCampaign] PRIMARY KEY NONCLUSTERED
   ([BarterCampaignID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_BarterCampaign_ConsumerID]
   ON [dbo].[BarterCampaign]
   ([BarterAdID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_BarterCampaign_BarterAdID]
   ON [dbo].[BarterCampaign]
   ([BarterAdID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO