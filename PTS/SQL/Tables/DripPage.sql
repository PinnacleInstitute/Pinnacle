EXEC [dbo].pts_CheckTable 'DripPage'
 GO

CREATE TABLE [dbo].[DripPage] (
   [DripPageID] int IDENTITY (1,1) NOT NULL ,
   [DripCampaignID] int NOT NULL ,
   [Subject] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [Days] int NOT NULL ,
   [IsCC] bit NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DripPage] WITH NOCHECK ADD
   CONSTRAINT [DF_DripPage_DripCampaignID] DEFAULT (0) FOR [DripCampaignID] ,
   CONSTRAINT [DF_DripPage_Subject] DEFAULT ('') FOR [Subject] ,
   CONSTRAINT [DF_DripPage_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_DripPage_Days] DEFAULT (0) FOR [Days] ,
   CONSTRAINT [DF_DripPage_IsCC] DEFAULT (0) FOR [IsCC]
GO

ALTER TABLE [dbo].[DripPage] WITH NOCHECK ADD
   CONSTRAINT [PK_DripPage] PRIMARY KEY NONCLUSTERED
   ([DripPageID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_DripPage_DripCampaignID]
   ON [dbo].[DripPage]
   ([DripCampaignID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO