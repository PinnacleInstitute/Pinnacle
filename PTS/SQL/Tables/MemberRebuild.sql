EXEC [dbo].pts_CheckTableRebuild 'Member'
 GO

ALTER TABLE [dbo].[Member] WITH NOCHECK ADD
   CONSTRAINT [DF_Member_AuthUserID] DEFAULT (0) FOR [AuthUserID] ,
   CONSTRAINT [DF_Member_WebsiteID] DEFAULT (0) FOR [WebsiteID] ,
   CONSTRAINT [DF_Member_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Member_PromoID] DEFAULT (0) FOR [PromoID] ,
   CONSTRAINT [DF_Member_BillingID] DEFAULT (0) FOR [BillingID] ,
   CONSTRAINT [DF_Member_PayID] DEFAULT (0) FOR [PayID] ,
   CONSTRAINT [DF_Member_ReferralID] DEFAULT (0) FOR [ReferralID] ,
   CONSTRAINT [DF_Member_SponsorID] DEFAULT (0) FOR [SponsorID] ,
   CONSTRAINT [DF_Member_Sponsor2ID] DEFAULT (0) FOR [Sponsor2ID] ,
   CONSTRAINT [DF_Member_Sponsor3ID] DEFAULT (0) FOR [Sponsor3ID] ,
   CONSTRAINT [DF_Member_MentorID] DEFAULT (0) FOR [MentorID] ,
   CONSTRAINT [DF_Member_CompanyName] DEFAULT ('') FOR [CompanyName] ,
   CONSTRAINT [DF_Member_NameLast] DEFAULT ('') FOR [NameLast] ,
   CONSTRAINT [DF_Member_NameFirst] DEFAULT ('') FOR [NameFirst] ,
   CONSTRAINT [DF_Member_BV] DEFAULT (0) FOR [BV] ,
   CONSTRAINT [DF_Member_QV] DEFAULT (0) FOR [QV] ,
   CONSTRAINT [DF_Member_BV2] DEFAULT (0) FOR [BV2] ,
   CONSTRAINT [DF_Member_QV2] DEFAULT (0) FOR [QV2] ,
   CONSTRAINT [DF_Member_BV3] DEFAULT (0) FOR [BV3] ,
   CONSTRAINT [DF_Member_QV3] DEFAULT (0) FOR [QV3] ,
   CONSTRAINT [DF_Member_BV4] DEFAULT (0) FOR [BV4] ,
   CONSTRAINT [DF_Member_QV4] DEFAULT (0) FOR [QV4] ,
   CONSTRAINT [DF_Member_Qualify] DEFAULT (0) FOR [Qualify] ,
   CONSTRAINT [DF_Member_QualifyDate] DEFAULT (0) FOR [QualifyDate] ,
   CONSTRAINT [DF_Member_Email] DEFAULT ('') FOR [Email] ,
   CONSTRAINT [DF_Member_Email2] DEFAULT ('') FOR [Email2] ,
   CONSTRAINT [DF_Member_Phone1] DEFAULT ('') FOR [Phone1] ,
   CONSTRAINT [DF_Member_Phone2] DEFAULT ('') FOR [Phone2] ,
   CONSTRAINT [DF_Member_Fax] DEFAULT ('') FOR [Fax] ,
   CONSTRAINT [DF_Member_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Member_Level] DEFAULT (0) FOR [Level] ,
   CONSTRAINT [DF_Member_Newsletter] DEFAULT (0) FOR [Newsletter] ,
   CONSTRAINT [DF_Member_EnrollDate] DEFAULT (0) FOR [EnrollDate] ,
   CONSTRAINT [DF_Member_EndDate] DEFAULT (0) FOR [EndDate] ,
   CONSTRAINT [DF_Member_InitPrice] DEFAULT (0) FOR [InitPrice] ,
   CONSTRAINT [DF_Member_Price] DEFAULT (0) FOR [Price] ,
   CONSTRAINT [DF_Member_Retail] DEFAULT (0) FOR [Retail] ,
   CONSTRAINT [DF_Member_BusAccts] DEFAULT (0) FOR [BusAccts] ,
   CONSTRAINT [DF_Member_BusAcctPrice] DEFAULT (0) FOR [BusAcctPrice] ,
   CONSTRAINT [DF_Member_BusAcctRetail] DEFAULT (0) FOR [BusAcctRetail] ,
   CONSTRAINT [DF_Member_IsDiscount] DEFAULT (0) FOR [IsDiscount] ,
   CONSTRAINT [DF_Member_Discount] DEFAULT (0) FOR [Discount] ,
   CONSTRAINT [DF_Member_IsCompany] DEFAULT (0) FOR [IsCompany] ,
   CONSTRAINT [DF_Member_Billing] DEFAULT (0) FOR [Billing] ,
   CONSTRAINT [DF_Member_AccessLimit] DEFAULT ('') FOR [AccessLimit] ,
   CONSTRAINT [DF_Member_QuizLimit] DEFAULT (0) FOR [QuizLimit] ,
   CONSTRAINT [DF_Member_Reference] DEFAULT ('') FOR [Reference] ,
   CONSTRAINT [DF_Member_Referral] DEFAULT ('') FOR [Referral] ,
   CONSTRAINT [DF_Member_TrialDays] DEFAULT (0) FOR [TrialDays] ,
   CONSTRAINT [DF_Member_MasterID] DEFAULT (0) FOR [MasterID] ,
   CONSTRAINT [DF_Member_IsIncluded] DEFAULT (0) FOR [IsIncluded] ,
   CONSTRAINT [DF_Member_IsMaster] DEFAULT (0) FOR [IsMaster] ,
   CONSTRAINT [DF_Member_MasterPrice] DEFAULT (0) FOR [MasterPrice] ,
   CONSTRAINT [DF_Member_MasterMembers] DEFAULT (0) FOR [MasterMembers] ,
   CONSTRAINT [DF_Member_MaxMembers] DEFAULT (0) FOR [MaxMembers] ,
   CONSTRAINT [DF_Member_VisitDate] DEFAULT (0) FOR [VisitDate] ,
   CONSTRAINT [DF_Member_TaxIDType] DEFAULT (0) FOR [TaxIDType] ,
   CONSTRAINT [DF_Member_TaxID] DEFAULT ('') FOR [TaxID] ,
   CONSTRAINT [DF_Member_AutoShipDate] DEFAULT (0) FOR [AutoShipDate] ,
   CONSTRAINT [DF_Member_PaidDate] DEFAULT (0) FOR [PaidDate] ,
   CONSTRAINT [DF_Member_StatusDate] DEFAULT (0) FOR [StatusDate] ,
   CONSTRAINT [DF_Member_StatusChange] DEFAULT (0) FOR [StatusChange] ,
   CONSTRAINT [DF_Member_LevelChange] DEFAULT (0) FOR [LevelChange] ,
   CONSTRAINT [DF_Member_IsRemoved] DEFAULT (0) FOR [IsRemoved] ,
   CONSTRAINT [DF_Member_GroupID] DEFAULT (0) FOR [GroupID] ,
   CONSTRAINT [DF_Member_Role] DEFAULT ('') FOR [Role] ,
   CONSTRAINT [DF_Member_Secure] DEFAULT (0) FOR [Secure] ,
   CONSTRAINT [DF_Member_Options] DEFAULT ('') FOR [Options] ,
   CONSTRAINT [DF_Member_Options2] DEFAULT ('') FOR [Options2] ,
   CONSTRAINT [DF_Member_Pos] DEFAULT (0) FOR [Pos] ,
   CONSTRAINT [DF_Member_Signature] DEFAULT ('') FOR [Signature] ,
   CONSTRAINT [DF_Member_SocNet] DEFAULT ('') FOR [SocNet] ,
   CONSTRAINT [DF_Member_ConfLine] DEFAULT ('') FOR [ConfLine] ,
   CONSTRAINT [DF_Member_NotifyMentor] DEFAULT ('') FOR [NotifyMentor] ,
   CONSTRAINT [DF_Member_Image] DEFAULT ('') FOR [Image] ,
   CONSTRAINT [DF_Member_Identification] DEFAULT ('') FOR [Identification] ,
   CONSTRAINT [DF_Member_Title] DEFAULT (0) FOR [Title] ,
   CONSTRAINT [DF_Member_Title2] DEFAULT (0) FOR [Title2] ,
   CONSTRAINT [DF_Member_MinTitle] DEFAULT (0) FOR [MinTitle] ,
   CONSTRAINT [DF_Member_TitleDate] DEFAULT (0) FOR [TitleDate] ,
   CONSTRAINT [DF_Member_InputValues] DEFAULT ('') FOR [InputValues] ,
   CONSTRAINT [DF_Member_Icons] DEFAULT ('') FOR [Icons] ,
   CONSTRAINT [DF_Member_IsMsg] DEFAULT (0) FOR [IsMsg] ,
   CONSTRAINT [DF_Member_Timezone] DEFAULT (0) FOR [Timezone] ,
   CONSTRAINT [DF_Member_Process] DEFAULT (0) FOR [Process]
GO

ALTER TABLE [dbo].[Member] WITH NOCHECK ADD
   CONSTRAINT [PK_Member] PRIMARY KEY NONCLUSTERED
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Member_AuthUserID]
   ON [dbo].[Member]
   ([AuthUserID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Member_CompanyName]
   ON [dbo].[Member]
   ([CompanyName])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Member_MemberName]
   ON [dbo].[Member]
   ([NameLast], [NameFirst])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Member_ReferralID]
   ON [dbo].[Member]
   ([ReferralID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Member_MentorID]
   ON [dbo].[Member]
   ([MentorID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Member_SponsorID]
   ON [dbo].[Member]
   ([SponsorID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Member_Sponsor2ID]
   ON [dbo].[Member]
   ([Sponsor2ID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Member_Sponsor3ID]
   ON [dbo].[Member]
   ([Sponsor3ID], [Pos])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Member_GroupID]
   ON [dbo].[Member]
   ([GroupID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Member_Reference]
   ON [dbo].[Member]
   ([CompanyID], [Reference])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Member_MasterID]
   ON [dbo].[Member]
   ([MasterID], [GroupID], [Role])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Member_Email]
   ON [dbo].[Member]
   ([CompanyID], [Email])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Member_EnrollDate]
   ON [dbo].[Member]
   ([CompanyID], [EnrollDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO