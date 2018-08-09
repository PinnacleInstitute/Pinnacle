EXEC [dbo].pts_CheckTableRebuild 'DripCampaign'
 GO

ALTER TABLE [dbo].[DripCampaign] WITH NOCHECK ADD
   CONSTRAINT [DF_DripCampaign_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_DripCampaign_GroupID] DEFAULT (0) FOR [GroupID] ,
   CONSTRAINT [DF_DripCampaign_DripCampaignName] DEFAULT ('') FOR [DripCampaignName] ,
   CONSTRAINT [DF_DripCampaign_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_DripCampaign_Target] DEFAULT (0) FOR [Target] ,
   CONSTRAINT [DF_DripCampaign_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_DripCampaign_IsShare] DEFAULT (0) FOR [IsShare]
GO

ALTER TABLE [dbo].[DripCampaign] WITH NOCHECK ADD
   CONSTRAINT [PK_DripCampaign] PRIMARY KEY NONCLUSTERED
   ([DripCampaignID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_DripCampaign_CompanyID]
   ON [dbo].[DripCampaign]
   ([CompanyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_DripCampaign_GroupID]
   ON [dbo].[DripCampaign]
   ([GroupID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO