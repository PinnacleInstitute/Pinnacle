EXEC [dbo].pts_CheckTable 'LeadAd'
 GO

CREATE TABLE [dbo].[LeadAd] (
   [LeadAdID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [GroupID] int NOT NULL ,
   [LeadAdName] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [Target] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Link] nvarchar (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Seq] int NOT NULL ,
   [Image] nvarchar (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[LeadAd] WITH NOCHECK ADD
   CONSTRAINT [DF_LeadAd_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_LeadAd_GroupID] DEFAULT (0) FOR [GroupID] ,
   CONSTRAINT [DF_LeadAd_LeadAdName] DEFAULT ('') FOR [LeadAdName] ,
   CONSTRAINT [DF_LeadAd_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_LeadAd_Target] DEFAULT ('') FOR [Target] ,
   CONSTRAINT [DF_LeadAd_Link] DEFAULT ('') FOR [Link] ,
   CONSTRAINT [DF_LeadAd_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_LeadAd_Image] DEFAULT ('') FOR [Image]
GO

ALTER TABLE [dbo].[LeadAd] WITH NOCHECK ADD
   CONSTRAINT [PK_LeadAd] PRIMARY KEY NONCLUSTERED
   ([LeadAdID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_LeadAd_CompanyID]
   ON [dbo].[LeadAd]
   ([CompanyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_LeadAd_GroupID]
   ON [dbo].[LeadAd]
   ([GroupID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO