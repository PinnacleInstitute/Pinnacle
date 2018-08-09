EXEC [dbo].pts_CheckTable 'Prospect'
 GO

CREATE TABLE [dbo].[Prospect] (
   [ProspectID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [MemberID] int NOT NULL ,
   [SalesCampaignID] int NOT NULL ,
   [LeadCampaignID] int NOT NULL ,
   [PresentID] int NOT NULL ,
   [ProspectTypeID] int NOT NULL ,
   [EmailID] int NOT NULL ,
   [AffiliateID] int NOT NULL ,
   [NewsLetterID] int NOT NULL ,
   [ProspectName] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Website] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Description] nvarchar (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Representing] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Potential] money NOT NULL ,
   [NameLast] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [NameFirst] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Title] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Email] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Phone1] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Phone2] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Street] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Unit] nvarchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [City] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [State] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Zip] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Country] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [NextEvent] int NOT NULL ,
   [NextDate] datetime NOT NULL ,
   [NextTime] varchar (8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [CreateDate] datetime NOT NULL ,
   [FBDate] datetime NOT NULL ,
   [CloseDate] datetime NOT NULL ,
   [DeadDate] datetime NOT NULL ,
   [Date1] datetime NOT NULL ,
   [Date2] datetime NOT NULL ,
   [Date3] datetime NOT NULL ,
   [Date4] datetime NOT NULL ,
   [Date5] datetime NOT NULL ,
   [Date6] datetime NOT NULL ,
   [Date7] datetime NOT NULL ,
   [Date8] datetime NOT NULL ,
   [Date9] datetime NOT NULL ,
   [Date10] datetime NOT NULL ,
   [ChangeDate] datetime NOT NULL ,
   [ChangeStatus] int NOT NULL ,
   [EmailDate] datetime NOT NULL ,
   [RSVP] int NOT NULL ,
   [EmailStatus] int NOT NULL ,
   [LeadViews] int NOT NULL ,
   [LeadPages] varchar (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [LeadReplies] int NOT NULL ,
   [PresentViews] int NOT NULL ,
   [PresentPages] varchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [NoDistribute] bit NOT NULL ,
   [DistributorID] int NOT NULL ,
   [DistributeDate] datetime NOT NULL ,
   [Priority] nvarchar (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [InputValues] nvarchar (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Source] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Code] int NOT NULL ,
   [Reminder] int NOT NULL ,
   [RemindDate] datetime NOT NULL ,
   [TimeZone] int NOT NULL ,
   [BestTime] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Prospect] WITH NOCHECK ADD
   CONSTRAINT [DF_Prospect_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Prospect_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Prospect_SalesCampaignID] DEFAULT (0) FOR [SalesCampaignID] ,
   CONSTRAINT [DF_Prospect_LeadCampaignID] DEFAULT (0) FOR [LeadCampaignID] ,
   CONSTRAINT [DF_Prospect_PresentID] DEFAULT (0) FOR [PresentID] ,
   CONSTRAINT [DF_Prospect_ProspectTypeID] DEFAULT (0) FOR [ProspectTypeID] ,
   CONSTRAINT [DF_Prospect_EmailID] DEFAULT (0) FOR [EmailID] ,
   CONSTRAINT [DF_Prospect_AffiliateID] DEFAULT (0) FOR [AffiliateID] ,
   CONSTRAINT [DF_Prospect_NewsLetterID] DEFAULT (0) FOR [NewsLetterID] ,
   CONSTRAINT [DF_Prospect_ProspectName] DEFAULT ('') FOR [ProspectName] ,
   CONSTRAINT [DF_Prospect_Website] DEFAULT ('') FOR [Website] ,
   CONSTRAINT [DF_Prospect_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_Prospect_Representing] DEFAULT ('') FOR [Representing] ,
   CONSTRAINT [DF_Prospect_Potential] DEFAULT (0) FOR [Potential] ,
   CONSTRAINT [DF_Prospect_NameLast] DEFAULT ('') FOR [NameLast] ,
   CONSTRAINT [DF_Prospect_NameFirst] DEFAULT ('') FOR [NameFirst] ,
   CONSTRAINT [DF_Prospect_Title] DEFAULT ('') FOR [Title] ,
   CONSTRAINT [DF_Prospect_Email] DEFAULT ('') FOR [Email] ,
   CONSTRAINT [DF_Prospect_Phone1] DEFAULT ('') FOR [Phone1] ,
   CONSTRAINT [DF_Prospect_Phone2] DEFAULT ('') FOR [Phone2] ,
   CONSTRAINT [DF_Prospect_Street] DEFAULT ('') FOR [Street] ,
   CONSTRAINT [DF_Prospect_Unit] DEFAULT ('') FOR [Unit] ,
   CONSTRAINT [DF_Prospect_City] DEFAULT ('') FOR [City] ,
   CONSTRAINT [DF_Prospect_State] DEFAULT ('') FOR [State] ,
   CONSTRAINT [DF_Prospect_Zip] DEFAULT ('') FOR [Zip] ,
   CONSTRAINT [DF_Prospect_Country] DEFAULT ('') FOR [Country] ,
   CONSTRAINT [DF_Prospect_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Prospect_NextEvent] DEFAULT (0) FOR [NextEvent] ,
   CONSTRAINT [DF_Prospect_NextDate] DEFAULT (0) FOR [NextDate] ,
   CONSTRAINT [DF_Prospect_NextTime] DEFAULT ('') FOR [NextTime] ,
   CONSTRAINT [DF_Prospect_CreateDate] DEFAULT (0) FOR [CreateDate] ,
   CONSTRAINT [DF_Prospect_FBDate] DEFAULT (0) FOR [FBDate] ,
   CONSTRAINT [DF_Prospect_CloseDate] DEFAULT (0) FOR [CloseDate] ,
   CONSTRAINT [DF_Prospect_DeadDate] DEFAULT (0) FOR [DeadDate] ,
   CONSTRAINT [DF_Prospect_Date1] DEFAULT (0) FOR [Date1] ,
   CONSTRAINT [DF_Prospect_Date2] DEFAULT (0) FOR [Date2] ,
   CONSTRAINT [DF_Prospect_Date3] DEFAULT (0) FOR [Date3] ,
   CONSTRAINT [DF_Prospect_Date4] DEFAULT (0) FOR [Date4] ,
   CONSTRAINT [DF_Prospect_Date5] DEFAULT (0) FOR [Date5] ,
   CONSTRAINT [DF_Prospect_Date6] DEFAULT (0) FOR [Date6] ,
   CONSTRAINT [DF_Prospect_Date7] DEFAULT (0) FOR [Date7] ,
   CONSTRAINT [DF_Prospect_Date8] DEFAULT (0) FOR [Date8] ,
   CONSTRAINT [DF_Prospect_Date9] DEFAULT (0) FOR [Date9] ,
   CONSTRAINT [DF_Prospect_Date10] DEFAULT (0) FOR [Date10] ,
   CONSTRAINT [DF_Prospect_ChangeDate] DEFAULT (0) FOR [ChangeDate] ,
   CONSTRAINT [DF_Prospect_ChangeStatus] DEFAULT (0) FOR [ChangeStatus] ,
   CONSTRAINT [DF_Prospect_EmailDate] DEFAULT (0) FOR [EmailDate] ,
   CONSTRAINT [DF_Prospect_RSVP] DEFAULT (0) FOR [RSVP] ,
   CONSTRAINT [DF_Prospect_EmailStatus] DEFAULT (0) FOR [EmailStatus] ,
   CONSTRAINT [DF_Prospect_LeadViews] DEFAULT (0) FOR [LeadViews] ,
   CONSTRAINT [DF_Prospect_LeadPages] DEFAULT ('') FOR [LeadPages] ,
   CONSTRAINT [DF_Prospect_LeadReplies] DEFAULT (0) FOR [LeadReplies] ,
   CONSTRAINT [DF_Prospect_PresentViews] DEFAULT (0) FOR [PresentViews] ,
   CONSTRAINT [DF_Prospect_PresentPages] DEFAULT ('') FOR [PresentPages] ,
   CONSTRAINT [DF_Prospect_NoDistribute] DEFAULT (0) FOR [NoDistribute] ,
   CONSTRAINT [DF_Prospect_DistributorID] DEFAULT (0) FOR [DistributorID] ,
   CONSTRAINT [DF_Prospect_DistributeDate] DEFAULT (0) FOR [DistributeDate] ,
   CONSTRAINT [DF_Prospect_Priority] DEFAULT ('') FOR [Priority] ,
   CONSTRAINT [DF_Prospect_InputValues] DEFAULT ('') FOR [InputValues] ,
   CONSTRAINT [DF_Prospect_Source] DEFAULT ('') FOR [Source] ,
   CONSTRAINT [DF_Prospect_Code] DEFAULT (0) FOR [Code] ,
   CONSTRAINT [DF_Prospect_Reminder] DEFAULT (0) FOR [Reminder] ,
   CONSTRAINT [DF_Prospect_RemindDate] DEFAULT (0) FOR [RemindDate] ,
   CONSTRAINT [DF_Prospect_TimeZone] DEFAULT (0) FOR [TimeZone] ,
   CONSTRAINT [DF_Prospect_BestTime] DEFAULT (0) FOR [BestTime]
GO

ALTER TABLE [dbo].[Prospect] WITH NOCHECK ADD
   CONSTRAINT [PK_Prospect] PRIMARY KEY NONCLUSTERED
   ([ProspectID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Prospect_ProspectName]
   ON [dbo].[Prospect]
   ([CompanyID], [ProspectName])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Prospect_CompanyID]
   ON [dbo].[Prospect]
   ([CompanyID], [MemberID], [Status])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Prospect_ContactName]
   ON [dbo].[Prospect]
   ([CompanyID], [NameLast], [NameFirst])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Prospect_ChangeDate]
   ON [dbo].[Prospect]
   ([ChangeDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Prospect_Email]
   ON [dbo].[Prospect]
   ([EmailID], [EmailDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Prospect_NewsLetterID]
   ON [dbo].[Prospect]
   ([NewsLetterID], [EmailStatus])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Prospect_LeadCampaignID]
   ON [dbo].[Prospect]
   ([LeadCampaignID], [CreateDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Prospect_AffiliateID]
   ON [dbo].[Prospect]
   ([LeadCampaignID], [AffiliateID], [CreateDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Prospect_MemberID]
   ON [dbo].[Prospect]
   ([LeadCampaignID], [MemberID], [CreateDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Prospect_Distribute]
   ON [dbo].[Prospect]
   ([DistributorID], [DistributeDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Prospect_RemindDate]
   ON [dbo].[Prospect]
   ([RemindDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO