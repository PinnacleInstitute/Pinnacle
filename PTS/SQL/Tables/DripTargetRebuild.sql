EXEC [dbo].pts_CheckTableRebuild 'DripTarget'
 GO

ALTER TABLE [dbo].[DripTarget] WITH NOCHECK ADD
   CONSTRAINT [DF_DripTarget_DripCampaignID] DEFAULT (0) FOR [DripCampaignID] ,
   CONSTRAINT [DF_DripTarget_TargetID] DEFAULT (0) FOR [TargetID] ,
   CONSTRAINT [DF_DripTarget_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_DripTarget_StartDate] DEFAULT (0) FOR [StartDate]
GO

ALTER TABLE [dbo].[DripTarget] WITH NOCHECK ADD
   CONSTRAINT [PK_DripTarget] PRIMARY KEY NONCLUSTERED
   ([DripTargetID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_DripTarget_DripCampaignID]
   ON [dbo].[DripTarget]
   ([DripCampaignID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_DripTarget_TargetID]
   ON [dbo].[DripTarget]
   ([TargetID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO