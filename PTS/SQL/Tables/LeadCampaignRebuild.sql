EXEC [dbo].pts_CheckTableRebuild 'LeadCampaign'
 GO

ALTER TABLE [dbo].[LeadCampaign] WITH NOCHECK ADD
   CONSTRAINT [DF_LeadCampaign_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_LeadCampaign_SalesCampaignID] DEFAULT (0) FOR [SalesCampaignID] ,
   CONSTRAINT [DF_LeadCampaign_ProspectTypeID] DEFAULT (0) FOR [ProspectTypeID] ,
   CONSTRAINT [DF_LeadCampaign_CycleID] DEFAULT (0) FOR [CycleID] ,
   CONSTRAINT [DF_LeadCampaign_NewsLetterID] DEFAULT (0) FOR [NewsLetterID] ,
   CONSTRAINT [DF_LeadCampaign_GroupID] DEFAULT (0) FOR [GroupID] ,
   CONSTRAINT [DF_LeadCampaign_FolderID] DEFAULT (0) FOR [FolderID] ,
   CONSTRAINT [DF_LeadCampaign_LeadCampaignName] DEFAULT ('') FOR [LeadCampaignName] ,
   CONSTRAINT [DF_LeadCampaign_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_LeadCampaign_PageType] DEFAULT (0) FOR [PageType] ,
   CONSTRAINT [DF_LeadCampaign_Objective] DEFAULT ('') FOR [Objective] ,
   CONSTRAINT [DF_LeadCampaign_Title] DEFAULT ('') FOR [Title] ,
   CONSTRAINT [DF_LeadCampaign_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_LeadCampaign_Keywords] DEFAULT ('') FOR [Keywords] ,
   CONSTRAINT [DF_LeadCampaign_IsMember] DEFAULT (0) FOR [IsMember] ,
   CONSTRAINT [DF_LeadCampaign_IsAffiliate] DEFAULT (0) FOR [IsAffiliate] ,
   CONSTRAINT [DF_LeadCampaign_Cycle] DEFAULT ('') FOR [Cycle] ,
   CONSTRAINT [DF_LeadCampaign_CSS] DEFAULT ('') FOR [CSS] ,
   CONSTRAINT [DF_LeadCampaign_NoEdit] DEFAULT (0) FOR [NoEdit] ,
   CONSTRAINT [DF_LeadCampaign_Page] DEFAULT ('') FOR [Page] ,
   CONSTRAINT [DF_LeadCampaign_Image] DEFAULT ('') FOR [Image] ,
   CONSTRAINT [DF_LeadCampaign_Entity] DEFAULT (0) FOR [Entity] ,
   CONSTRAINT [DF_LeadCampaign_Seq] DEFAULT (0) FOR [Seq]
GO

ALTER TABLE [dbo].[LeadCampaign] WITH NOCHECK ADD
   CONSTRAINT [PK_LeadCampaign] PRIMARY KEY NONCLUSTERED
   ([LeadCampaignID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_LeadCampaign_CompanyID]
   ON [dbo].[LeadCampaign]
   ([CompanyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_LeadCampaign_GroupID]
   ON [dbo].[LeadCampaign]
   ([GroupID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO