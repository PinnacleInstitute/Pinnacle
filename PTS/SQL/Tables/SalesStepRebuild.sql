EXEC [dbo].pts_CheckTableRebuild 'SalesStep'
 GO

ALTER TABLE [dbo].[SalesStep] WITH NOCHECK ADD
   CONSTRAINT [DF_SalesStep_SalesCampaignID] DEFAULT (0) FOR [SalesCampaignID] ,
   CONSTRAINT [DF_SalesStep_EmailID] DEFAULT (0) FOR [EmailID] ,
   CONSTRAINT [DF_SalesStep_SalesStepName] DEFAULT ('') FOR [SalesStepName] ,
   CONSTRAINT [DF_SalesStep_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_SalesStep_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_SalesStep_AutoStep] DEFAULT (0) FOR [AutoStep] ,
   CONSTRAINT [DF_SalesStep_NextStep] DEFAULT (0) FOR [NextStep] ,
   CONSTRAINT [DF_SalesStep_Delay] DEFAULT (0) FOR [Delay] ,
   CONSTRAINT [DF_SalesStep_DateNo] DEFAULT (0) FOR [DateNo] ,
   CONSTRAINT [DF_SalesStep_IsBoard] DEFAULT (0) FOR [IsBoard] ,
   CONSTRAINT [DF_SalesStep_BoardRate] DEFAULT (0) FOR [BoardRate] ,
   CONSTRAINT [DF_SalesStep_Length] DEFAULT (0) FOR [Length] ,
   CONSTRAINT [DF_SalesStep_Email] DEFAULT ('') FOR [Email]
GO

ALTER TABLE [dbo].[SalesStep] WITH NOCHECK ADD
   CONSTRAINT [PK_SalesStep] PRIMARY KEY NONCLUSTERED
   ([SalesStepID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_SalesStep_SalesCampaignID]
   ON [dbo].[SalesStep]
   ([SalesCampaignID], [Seq])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO