EXEC [dbo].pts_CheckTable 'Company'
 GO

CREATE TABLE [dbo].[Company] (
   [CompanyID] int IDENTITY (1,1) NOT NULL ,
   [MemberID] int NOT NULL ,
   [BillingID] int NOT NULL ,
   [CompanyName] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [CompanyType] int NOT NULL ,
   [Status] int NOT NULL ,
   [NameLast] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [NameFirst] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Street] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Unit] nvarchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [City] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [State] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Zip] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Country] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Email] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Email2] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Email3] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Phone1] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Phone2] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Fax] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [EnrollDate] datetime NOT NULL ,
   [Subnet] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [LostBonusDate] datetime NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Company] WITH NOCHECK ADD
   CONSTRAINT [DF_Company_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Company_BillingID] DEFAULT (0) FOR [BillingID] ,
   CONSTRAINT [DF_Company_CompanyName] DEFAULT ('') FOR [CompanyName] ,
   CONSTRAINT [DF_Company_CompanyType] DEFAULT (0) FOR [CompanyType] ,
   CONSTRAINT [DF_Company_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Company_NameLast] DEFAULT ('') FOR [NameLast] ,
   CONSTRAINT [DF_Company_NameFirst] DEFAULT ('') FOR [NameFirst] ,
   CONSTRAINT [DF_Company_Street] DEFAULT ('') FOR [Street] ,
   CONSTRAINT [DF_Company_Unit] DEFAULT ('') FOR [Unit] ,
   CONSTRAINT [DF_Company_City] DEFAULT ('') FOR [City] ,
   CONSTRAINT [DF_Company_State] DEFAULT ('') FOR [State] ,
   CONSTRAINT [DF_Company_Zip] DEFAULT ('') FOR [Zip] ,
   CONSTRAINT [DF_Company_Country] DEFAULT ('') FOR [Country] ,
   CONSTRAINT [DF_Company_Email] DEFAULT ('') FOR [Email] ,
   CONSTRAINT [DF_Company_Email2] DEFAULT ('') FOR [Email2] ,
   CONSTRAINT [DF_Company_Email3] DEFAULT ('') FOR [Email3] ,
   CONSTRAINT [DF_Company_Phone1] DEFAULT ('') FOR [Phone1] ,
   CONSTRAINT [DF_Company_Phone2] DEFAULT ('') FOR [Phone2] ,
   CONSTRAINT [DF_Company_Fax] DEFAULT ('') FOR [Fax] ,
   CONSTRAINT [DF_Company_EnrollDate] DEFAULT (0) FOR [EnrollDate] ,
   CONSTRAINT [DF_Company_Subnet] DEFAULT ('') FOR [Subnet] ,
   CONSTRAINT [DF_Company_LostBonusDate] DEFAULT (0) FOR [LostBonusDate]
GO

ALTER TABLE [dbo].[Company] WITH NOCHECK ADD
   CONSTRAINT [PK_Company] PRIMARY KEY NONCLUSTERED
   ([CompanyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Company_CompanyName]
   ON [dbo].[Company]
   ([CompanyName])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Company_Subnet]
   ON [dbo].[Company]
   ([Subnet])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO