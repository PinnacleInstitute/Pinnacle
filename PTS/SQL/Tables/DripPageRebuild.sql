EXEC [dbo].pts_CheckTableRebuild 'DripPage'
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