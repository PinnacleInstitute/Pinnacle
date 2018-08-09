EXEC [dbo].pts_CheckTableRebuild 'Consumer'
 GO

ALTER TABLE [dbo].[Consumer] WITH NOCHECK ADD
   CONSTRAINT [DF_Consumer_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Consumer_MerchantID] DEFAULT (0) FOR [MerchantID] ,
   CONSTRAINT [DF_Consumer_ReferID] DEFAULT (0) FOR [ReferID] ,
   CONSTRAINT [DF_Consumer_CountryID] DEFAULT (0) FOR [CountryID] ,
   CONSTRAINT [DF_Consumer_CountryID2] DEFAULT (0) FOR [CountryID2] ,
   CONSTRAINT [DF_Consumer_AffiliateID] DEFAULT (0) FOR [AffiliateID] ,
   CONSTRAINT [DF_Consumer_NameLast] DEFAULT ('') FOR [NameLast] ,
   CONSTRAINT [DF_Consumer_NameFirst] DEFAULT ('') FOR [NameFirst] ,
   CONSTRAINT [DF_Consumer_Email] DEFAULT ('') FOR [Email] ,
   CONSTRAINT [DF_Consumer_Email2] DEFAULT ('') FOR [Email2] ,
   CONSTRAINT [DF_Consumer_Phone] DEFAULT ('') FOR [Phone] ,
   CONSTRAINT [DF_Consumer_Provider] DEFAULT (0) FOR [Provider] ,
   CONSTRAINT [DF_Consumer_Password] DEFAULT ('') FOR [Password] ,
   CONSTRAINT [DF_Consumer_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Consumer_Messages] DEFAULT (0) FOR [Messages] ,
   CONSTRAINT [DF_Consumer_Street1] DEFAULT ('') FOR [Street1] ,
   CONSTRAINT [DF_Consumer_Street2] DEFAULT ('') FOR [Street2] ,
   CONSTRAINT [DF_Consumer_City] DEFAULT ('') FOR [City] ,
   CONSTRAINT [DF_Consumer_State] DEFAULT ('') FOR [State] ,
   CONSTRAINT [DF_Consumer_Zip] DEFAULT ('') FOR [Zip] ,
   CONSTRAINT [DF_Consumer_City2] DEFAULT ('') FOR [City2] ,
   CONSTRAINT [DF_Consumer_State2] DEFAULT ('') FOR [State2] ,
   CONSTRAINT [DF_Consumer_Zip2] DEFAULT ('') FOR [Zip2] ,
   CONSTRAINT [DF_Consumer_Referrals] DEFAULT (0) FOR [Referrals] ,
   CONSTRAINT [DF_Consumer_Cash] DEFAULT (0) FOR [Cash] ,
   CONSTRAINT [DF_Consumer_Points] DEFAULT (0) FOR [Points] ,
   CONSTRAINT [DF_Consumer_VisitDate] DEFAULT (0) FOR [VisitDate] ,
   CONSTRAINT [DF_Consumer_EnrollDate] DEFAULT (0) FOR [EnrollDate] ,
   CONSTRAINT [DF_Consumer_UserKey] DEFAULT ('') FOR [UserKey] ,
   CONSTRAINT [DF_Consumer_Barter] DEFAULT ('') FOR [Barter]
GO

ALTER TABLE [dbo].[Consumer] WITH NOCHECK ADD
   CONSTRAINT [PK_Consumer] PRIMARY KEY NONCLUSTERED
   ([ConsumerID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Consumer_Email]
   ON [dbo].[Consumer]
   ([Email])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Consumer_Phone]
   ON [dbo].[Consumer]
   ([Phone])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Consumer_MemberID]
   ON [dbo].[Consumer]
   ([MemberID], [ReferID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Consumer_MerchantID]
   ON [dbo].[Consumer]
   ([MerchantID], [ReferID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Consumer_ReferID]
   ON [dbo].[Consumer]
   ([ReferID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Consumer_Zip]
   ON [dbo].[Consumer]
   ([CountryID], [Zip])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Consumer_Zip2]
   ON [dbo].[Consumer]
   ([CountryID2], [Zip2])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Consumer_City2]
   ON [dbo].[Consumer]
   ([CountryID2], [City2])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Consumer_State2]
   ON [dbo].[Consumer]
   ([CountryID2], [State2])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO