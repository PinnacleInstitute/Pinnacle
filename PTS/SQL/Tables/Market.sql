EXEC [dbo].pts_CheckTable 'Market'
 GO

CREATE TABLE [dbo].[Market] (
   [MarketID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [CountryID] int NOT NULL ,
   [MarketName] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [FromEmail] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Subject] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [Target] nvarchar (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [CreateDate] datetime NOT NULL ,
   [SendDate] datetime NOT NULL ,
   [SendDays] int NOT NULL ,
   [Consumers] int NOT NULL ,
   [Merchants] int NOT NULL ,
   [Orgs] int NOT NULL ,
   [TestEmail] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Market] WITH NOCHECK ADD
   CONSTRAINT [DF_Market_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Market_CountryID] DEFAULT (0) FOR [CountryID] ,
   CONSTRAINT [DF_Market_MarketName] DEFAULT ('') FOR [MarketName] ,
   CONSTRAINT [DF_Market_FromEmail] DEFAULT ('') FOR [FromEmail] ,
   CONSTRAINT [DF_Market_Subject] DEFAULT ('') FOR [Subject] ,
   CONSTRAINT [DF_Market_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Market_Target] DEFAULT ('') FOR [Target] ,
   CONSTRAINT [DF_Market_CreateDate] DEFAULT (0) FOR [CreateDate] ,
   CONSTRAINT [DF_Market_SendDate] DEFAULT (0) FOR [SendDate] ,
   CONSTRAINT [DF_Market_SendDays] DEFAULT (0) FOR [SendDays] ,
   CONSTRAINT [DF_Market_Consumers] DEFAULT (0) FOR [Consumers] ,
   CONSTRAINT [DF_Market_Merchants] DEFAULT (0) FOR [Merchants] ,
   CONSTRAINT [DF_Market_Orgs] DEFAULT (0) FOR [Orgs] ,
   CONSTRAINT [DF_Market_TestEmail] DEFAULT ('') FOR [TestEmail]
GO

ALTER TABLE [dbo].[Market] WITH NOCHECK ADD
   CONSTRAINT [PK_Market] PRIMARY KEY NONCLUSTERED
   ([MarketID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Market_CompanyID]
   ON [dbo].[Market]
   ([CompanyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO