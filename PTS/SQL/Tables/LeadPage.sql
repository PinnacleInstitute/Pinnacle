EXEC [dbo].pts_CheckTable 'LeadPage'
 GO

CREATE TABLE [dbo].[LeadPage] (
   [LeadPageID] int IDENTITY (1,1) NOT NULL ,
   [LeadCampaignID] int NOT NULL ,
   [LeadPageName] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [Seq] int NOT NULL ,
   [IsInput] bit NOT NULL ,
   [IsCapture] bit NOT NULL ,
   [IsProspect] bit NOT NULL ,
   [IsNext] bit NOT NULL ,
   [NextCaption] nvarchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Inputs] nvarchar (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Language] varchar (6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [IsLeadURL] bit NOT NULL ,
   [IsRedirectURL] bit NOT NULL ,
   [LeadURL] varchar (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [RedirectURL] varchar (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [TopCode] varchar (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[LeadPage] WITH NOCHECK ADD
   CONSTRAINT [DF_LeadPage_LeadCampaignID] DEFAULT (0) FOR [LeadCampaignID] ,
   CONSTRAINT [DF_LeadPage_LeadPageName] DEFAULT ('') FOR [LeadPageName] ,
   CONSTRAINT [DF_LeadPage_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_LeadPage_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_LeadPage_IsInput] DEFAULT (0) FOR [IsInput] ,
   CONSTRAINT [DF_LeadPage_IsCapture] DEFAULT (0) FOR [IsCapture] ,
   CONSTRAINT [DF_LeadPage_IsProspect] DEFAULT (0) FOR [IsProspect] ,
   CONSTRAINT [DF_LeadPage_IsNext] DEFAULT (0) FOR [IsNext] ,
   CONSTRAINT [DF_LeadPage_NextCaption] DEFAULT ('') FOR [NextCaption] ,
   CONSTRAINT [DF_LeadPage_Inputs] DEFAULT ('') FOR [Inputs] ,
   CONSTRAINT [DF_LeadPage_Language] DEFAULT ('') FOR [Language] ,
   CONSTRAINT [DF_LeadPage_IsLeadURL] DEFAULT (0) FOR [IsLeadURL] ,
   CONSTRAINT [DF_LeadPage_IsRedirectURL] DEFAULT (0) FOR [IsRedirectURL] ,
   CONSTRAINT [DF_LeadPage_LeadURL] DEFAULT ('') FOR [LeadURL] ,
   CONSTRAINT [DF_LeadPage_RedirectURL] DEFAULT ('') FOR [RedirectURL] ,
   CONSTRAINT [DF_LeadPage_TopCode] DEFAULT ('') FOR [TopCode]
GO

ALTER TABLE [dbo].[LeadPage] WITH NOCHECK ADD
   CONSTRAINT [PK_LeadPage] PRIMARY KEY NONCLUSTERED
   ([LeadPageID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_LeadPage_LeadCampaignID]
   ON [dbo].[LeadPage]
   ([LeadCampaignID], [Language], [Seq])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO