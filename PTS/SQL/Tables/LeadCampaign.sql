EXEC [dbo].pts_CheckTable 'LeadCampaign'
 GO

CREATE TABLE [dbo].[LeadCampaign] (
   [LeadCampaignID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [SalesCampaignID] int NOT NULL ,
   [ProspectTypeID] int NOT NULL ,
   [CycleID] int NOT NULL ,
   [NewsLetterID] int NOT NULL ,
   [GroupID] int NOT NULL ,
   [FolderID] int NOT NULL ,
   [LeadCampaignName] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [PageType] int NOT NULL ,
   [Objective] nvarchar (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Title] varchar (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Description] varchar (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Keywords] varchar (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [IsMember] bit NOT NULL ,
   [IsAffiliate] bit NOT NULL ,
   [Cycle] varchar (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [CSS] varchar (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [NoEdit] bit NOT NULL ,
   [Page] nvarchar (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Image] nvarchar (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Entity] int NOT NULL ,
   [Seq] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[LeadCampaign] WITH NOCHECK ADD
   CONSTRAINT [DF_LeadCampaign_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_LeadCampaign_SalesCampaignID] DEFAULT (0) FOR [SalesCampaignID] ,
   CONSTRAINT [DF_LeadCampaign_ProspectTypeID] DEFAULT (0) FOR [ProspectTypeID] ,
   CONSTRAINT [DF_LeadCampaign_CycleID] DEFAULT (0) FOR [CycleID] ,
   CONSTRAINT [DF_LeadCampaign_NewsLetterID] DEFAULT (0) FOR [NewsLetterID] ,
   CONSTRAINT [DF_LeadCampaign_GroupID] DEFAULT (0) FOR [GroupID] ,
   CONSTRAINT [DF_LeadCampaign_FolderID] DEFAULT (0) FOR [FolderID] ,
   CONSTRAINT [DF_LeadCampaign_LeadCampaignName] DEFAULT ('') FOR [LeadCampaignName] ,
   CONSTRAINT [DF_LeadCampaign_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_LeadCampaign_PageType] DEFAULT (0) FOR [PageType] ,
   CONSTRAINT [DF_LeadCampaign_Objective] DEFAULT ('') FOR [Objective] ,
   CONSTRAINT [DF_LeadCampaign_Title] DEFAULT ('') FOR [Title] ,
   CONSTRAINT [DF_LeadCampaign_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_LeadCampaign_Keywords] DEFAULT ('') FOR [Keywords] ,
   CONSTRAINT [DF_LeadCampaign_IsMember] DEFAULT (0) FOR [IsMember] ,
   CONSTRAINT [DF_LeadCampaign_IsAffiliate] DEFAULT (0) FOR [IsAffiliate] ,
   CONSTRAINT [DF_LeadCampaign_Cycle] DEFAULT ('') FOR [Cycle] ,
   CONSTRAINT [DF_LeadCampaign_CSS] DEFAULT ('') FOR [CSS] ,
   CONSTRAINT [DF_LeadCampaign_NoEdit] DEFAULT (0) FOR [NoEdit] ,
   CONSTRAINT [DF_LeadCampaign_Page] DEFAULT ('') FOR [Page] ,
   CONSTRAINT [DF_LeadCampaign_Image] DEFAULT ('') FOR [Image] ,
   CONSTRAINT [DF_LeadCampaign_Entity] DEFAULT (0) FOR [Entity] ,
   CONSTRAINT [DF_LeadCampaign_Seq] DEFAULT (0) FOR [Seq]
GO

ALTER TABLE [dbo].[LeadCampaign] WITH NOCHECK ADD
   CONSTRAINT [PK_LeadCampaign] PRIMARY KEY NONCLUSTERED
   ([LeadCampaignID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_LeadCampaign_CompanyID]
   ON [dbo].[LeadCampaign]
   ([CompanyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_LeadCampaign_GroupID]
   ON [dbo].[LeadCampaign]
   ([GroupID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO