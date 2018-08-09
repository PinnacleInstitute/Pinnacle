EXEC [dbo].pts_CheckTable 'Lead'
 GO

CREATE TABLE [dbo].[Lead] (
   [LeadID] int IDENTITY (1,1) NOT NULL ,
   [MemberID] int NOT NULL ,
   [SalesCampaignID] int NOT NULL ,
   [ProspectTypeID] int NOT NULL ,
   [NameLast] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [NameFirst] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [LeadDate] datetime NOT NULL ,
   [Email] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Phone1] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Phone2] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Street] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Unit] nvarchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [City] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [State] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Zip] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Country] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Comment] nvarchar (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Source] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [Priority] nvarchar (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [CallBackDate] datetime NOT NULL ,
   [CallBackTime] varchar (8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [TimeZone] int NOT NULL ,
   [BestTime] int NOT NULL ,
   [DistributorID] int NOT NULL ,
   [DistributeDate] datetime NOT NULL ,
   [Code] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Lead] WITH NOCHECK ADD
   CONSTRAINT [DF_Lead_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Lead_SalesCampaignID] DEFAULT (0) FOR [SalesCampaignID] ,
   CONSTRAINT [DF_Lead_ProspectTypeID] DEFAULT (0) FOR [ProspectTypeID] ,
   CONSTRAINT [DF_Lead_NameLast] DEFAULT ('') FOR [NameLast] ,
   CONSTRAINT [DF_Lead_NameFirst] DEFAULT ('') FOR [NameFirst] ,
   CONSTRAINT [DF_Lead_LeadDate] DEFAULT (0) FOR [LeadDate] ,
   CONSTRAINT [DF_Lead_Email] DEFAULT ('') FOR [Email] ,
   CONSTRAINT [DF_Lead_Phone1] DEFAULT ('') FOR [Phone1] ,
   CONSTRAINT [DF_Lead_Phone2] DEFAULT ('') FOR [Phone2] ,
   CONSTRAINT [DF_Lead_Street] DEFAULT ('') FOR [Street] ,
   CONSTRAINT [DF_Lead_Unit] DEFAULT ('') FOR [Unit] ,
   CONSTRAINT [DF_Lead_City] DEFAULT ('') FOR [City] ,
   CONSTRAINT [DF_Lead_State] DEFAULT ('') FOR [State] ,
   CONSTRAINT [DF_Lead_Zip] DEFAULT ('') FOR [Zip] ,
   CONSTRAINT [DF_Lead_Country] DEFAULT ('') FOR [Country] ,
   CONSTRAINT [DF_Lead_Comment] DEFAULT ('') FOR [Comment] ,
   CONSTRAINT [DF_Lead_Source] DEFAULT ('') FOR [Source] ,
   CONSTRAINT [DF_Lead_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Lead_Priority] DEFAULT ('') FOR [Priority] ,
   CONSTRAINT [DF_Lead_CallBackDate] DEFAULT (0) FOR [CallBackDate] ,
   CONSTRAINT [DF_Lead_CallBackTime] DEFAULT ('') FOR [CallBackTime] ,
   CONSTRAINT [DF_Lead_TimeZone] DEFAULT (0) FOR [TimeZone] ,
   CONSTRAINT [DF_Lead_BestTime] DEFAULT (0) FOR [BestTime] ,
   CONSTRAINT [DF_Lead_DistributorID] DEFAULT (0) FOR [DistributorID] ,
   CONSTRAINT [DF_Lead_DistributeDate] DEFAULT (0) FOR [DistributeDate] ,
   CONSTRAINT [DF_Lead_Code] DEFAULT (0) FOR [Code]
GO

ALTER TABLE [dbo].[Lead] WITH NOCHECK ADD
   CONSTRAINT [PK_Lead] PRIMARY KEY NONCLUSTERED
   ([LeadID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Lead_MemberID]
   ON [dbo].[Lead]
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO