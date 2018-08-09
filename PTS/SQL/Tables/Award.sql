EXEC [dbo].pts_CheckTable 'Award'
 GO

CREATE TABLE [dbo].[Award] (
   [AwardID] int IDENTITY (1,1) NOT NULL ,
   [MerchantID] int NOT NULL ,
   [AwardType] int NOT NULL ,
   [Seq] int NOT NULL ,
   [Amount] money NOT NULL ,
   [Status] int NOT NULL ,
   [Description] nvarchar (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Cap] money NOT NULL ,
   [Award] money NOT NULL ,
   [StartDate] datetime NOT NULL ,
   [EndDate] datetime NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Award] WITH NOCHECK ADD
   CONSTRAINT [DF_Award_MerchantID] DEFAULT (0) FOR [MerchantID] ,
   CONSTRAINT [DF_Award_AwardType] DEFAULT (0) FOR [AwardType] ,
   CONSTRAINT [DF_Award_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_Award_Amount] DEFAULT (0) FOR [Amount] ,
   CONSTRAINT [DF_Award_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Award_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_Award_Cap] DEFAULT (0) FOR [Cap] ,
   CONSTRAINT [DF_Award_Award] DEFAULT (0) FOR [Award] ,
   CONSTRAINT [DF_Award_StartDate] DEFAULT (0) FOR [StartDate] ,
   CONSTRAINT [DF_Award_EndDate] DEFAULT (0) FOR [EndDate]
GO

ALTER TABLE [dbo].[Award] WITH NOCHECK ADD
   CONSTRAINT [PK_Award] PRIMARY KEY NONCLUSTERED
   ([AwardID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Award_MerchantID]
   ON [dbo].[Award]
   ([MerchantID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO