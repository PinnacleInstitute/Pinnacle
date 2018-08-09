EXEC [dbo].pts_CheckTable 'Consumer'
 GO

CREATE TABLE [dbo].[Consumer] (
   [ConsumerID] int IDENTITY (1,1) NOT NULL ,
   [MemberID] int NOT NULL ,
   [MerchantID] int NOT NULL ,
   [ReferID] int NOT NULL ,
   [CountryID] int NOT NULL ,
   [CountryID2] int NOT NULL ,
   [AffiliateID] int NOT NULL ,
   [NameLast] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [NameFirst] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Email] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Email2] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Phone] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Provider] int NOT NULL ,
   [Password] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [Messages] int NOT NULL ,
   [Street1] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Street2] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [City] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [State] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Zip] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [City2] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [State2] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Zip2] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Referrals] int NOT NULL ,
   [Cash] money NOT NULL ,
   [Points] money NOT NULL ,
   [VisitDate] datetime NOT NULL ,
   [EnrollDate] datetime NOT NULL ,
   [UserKey] varchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Barter] varchar (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
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