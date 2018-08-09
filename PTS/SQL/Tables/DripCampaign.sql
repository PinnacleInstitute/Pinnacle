EXEC [dbo].pts_CheckTable 'DripCampaign'
 GO

CREATE TABLE [dbo].[DripCampaign] (
   [DripCampaignID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [GroupID] int NOT NULL ,
   [DripCampaignName] nvarchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Description] varchar (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Target] int NOT NULL ,
   [Status] int NOT NULL ,
   [IsShare] bit NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DripCampaign] WITH NOCHECK ADD
   CONSTRAINT [DF_DripCampaign_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_DripCampaign_GroupID] DEFAULT (0) FOR [GroupID] ,
   CONSTRAINT [DF_DripCampaign_DripCampaignName] DEFAULT ('') FOR [DripCampaignName] ,
   CONSTRAINT [DF_DripCampaign_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_DripCampaign_Target] DEFAULT (0) FOR [Target] ,
   CONSTRAINT [DF_DripCampaign_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_DripCampaign_IsShare] DEFAULT (0) FOR [IsShare]
GO

ALTER TABLE [dbo].[DripCampaign] WITH NOCHECK ADD
   CONSTRAINT [PK_DripCampaign] PRIMARY KEY NONCLUSTERED
   ([DripCampaignID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_DripCampaign_CompanyID]
   ON [dbo].[DripCampaign]
   ([CompanyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_DripCampaign_GroupID]
   ON [dbo].[DripCampaign]
   ([GroupID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO