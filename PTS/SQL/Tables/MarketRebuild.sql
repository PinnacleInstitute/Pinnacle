EXEC [dbo].pts_CheckTableRebuild 'Market'
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