EXEC [dbo].pts_CheckTableRebuild 'Affiliate'
 GO

ALTER TABLE [dbo].[Affiliate] WITH NOCHECK ADD
   CONSTRAINT [DF_Affiliate_AuthUserID] DEFAULT (0) FOR [AuthUserID] ,
   CONSTRAINT [DF_Affiliate_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Affiliate_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Affiliate_SponsorID] DEFAULT (0) FOR [SponsorID] ,
   CONSTRAINT [DF_Affiliate_AffiliateName] DEFAULT ('') FOR [AffiliateName] ,
   CONSTRAINT [DF_Affiliate_NameLast] DEFAULT ('') FOR [NameLast] ,
   CONSTRAINT [DF_Affiliate_NameFirst] DEFAULT ('') FOR [NameFirst] ,
   CONSTRAINT [DF_Affiliate_Street] DEFAULT ('') FOR [Street] ,
   CONSTRAINT [DF_Affiliate_Unit] DEFAULT ('') FOR [Unit] ,
   CONSTRAINT [DF_Affiliate_City] DEFAULT ('') FOR [City] ,
   CONSTRAINT [DF_Affiliate_State] DEFAULT ('') FOR [State] ,
   CONSTRAINT [DF_Affiliate_Zip] DEFAULT ('') FOR [Zip] ,
   CONSTRAINT [DF_Affiliate_Country] DEFAULT ('') FOR [Country] ,
   CONSTRAINT [DF_Affiliate_Email] DEFAULT ('') FOR [Email] ,
   CONSTRAINT [DF_Affiliate_Phone1] DEFAULT ('') FOR [Phone1] ,
   CONSTRAINT [DF_Affiliate_Phone2] DEFAULT ('') FOR [Phone2] ,
   CONSTRAINT [DF_Affiliate_Fax] DEFAULT ('') FOR [Fax] ,
   CONSTRAINT [DF_Affiliate_SSN] DEFAULT ('') FOR [SSN] ,
   CONSTRAINT [DF_Affiliate_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Affiliate_EnrollDate] DEFAULT (0) FOR [EnrollDate] ,
   CONSTRAINT [DF_Affiliate_Website] DEFAULT ('') FOR [Website] ,
   CONSTRAINT [DF_Affiliate_Terms] DEFAULT ('') FOR [Terms] ,
   CONSTRAINT [DF_Affiliate_LeadCampaigns] DEFAULT ('') FOR [LeadCampaigns]
GO

ALTER TABLE [dbo].[Affiliate] WITH NOCHECK ADD
   CONSTRAINT [PK_Affiliate] PRIMARY KEY NONCLUSTERED
   ([AffiliateID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Affiliate_AuthUserID]
   ON [dbo].[Affiliate]
   ([AuthUserID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Affiliate_AffiliateName]
   ON [dbo].[Affiliate]
   ([AffiliateName])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Affiliate_ContactName]
   ON [dbo].[Affiliate]
   ([NameLast], [NameFirst])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Affiliate_CompanyID]
   ON [dbo].[Affiliate]
   ([CompanyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Affiliate_MemberID]
   ON [dbo].[Affiliate]
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO