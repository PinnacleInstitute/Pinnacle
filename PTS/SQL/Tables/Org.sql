EXEC [dbo].pts_CheckTable 'Org'
 GO

CREATE TABLE [dbo].[Org] (
   [OrgID] int IDENTITY (1,1) NOT NULL ,
   [AuthUserID] int NOT NULL ,
   [ParentID] int NOT NULL ,
   [CompanyID] int NOT NULL ,
   [ForumID] int NOT NULL ,
   [MemberID] int NOT NULL ,
   [PrivateID] int NOT NULL ,
   [OrgName] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Description] nvarchar (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [NameLast] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [NameFirst] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Email] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [IsCatalog] bit NOT NULL ,
   [Level] int NOT NULL ,
   [Hierarchy] varchar (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [CourseCount] int NOT NULL ,
   [MemberCount] int NOT NULL ,
   [IsPublic] bit NOT NULL ,
   [IsChat] bit NOT NULL ,
   [IsForum] bit NOT NULL ,
   [IsSuggestion] bit NOT NULL ,
   [IsFavorite] bit NOT NULL ,
   [IsProgram] bit NOT NULL ,
   [NoCertificate] bit NOT NULL ,
   [IsCustomCertificate] bit NOT NULL ,
   [Secure] int NOT NULL ,
   [Credits] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Org] WITH NOCHECK ADD
   CONSTRAINT [DF_Org_AuthUserID] DEFAULT (0) FOR [AuthUserID] ,
   CONSTRAINT [DF_Org_ParentID] DEFAULT (0) FOR [ParentID] ,
   CONSTRAINT [DF_Org_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Org_ForumID] DEFAULT (0) FOR [ForumID] ,
   CONSTRAINT [DF_Org_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Org_PrivateID] DEFAULT (0) FOR [PrivateID] ,
   CONSTRAINT [DF_Org_OrgName] DEFAULT ('') FOR [OrgName] ,
   CONSTRAINT [DF_Org_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_Org_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Org_NameLast] DEFAULT ('') FOR [NameLast] ,
   CONSTRAINT [DF_Org_NameFirst] DEFAULT ('') FOR [NameFirst] ,
   CONSTRAINT [DF_Org_Email] DEFAULT ('') FOR [Email] ,
   CONSTRAINT [DF_Org_IsCatalog] DEFAULT (0) FOR [IsCatalog] ,
   CONSTRAINT [DF_Org_Level] DEFAULT (0) FOR [Level] ,
   CONSTRAINT [DF_Org_Hierarchy] DEFAULT ('') FOR [Hierarchy] ,
   CONSTRAINT [DF_Org_CourseCount] DEFAULT (0) FOR [CourseCount] ,
   CONSTRAINT [DF_Org_MemberCount] DEFAULT (0) FOR [MemberCount] ,
   CONSTRAINT [DF_Org_IsPublic] DEFAULT (0) FOR [IsPublic] ,
   CONSTRAINT [DF_Org_IsChat] DEFAULT (0) FOR [IsChat] ,
   CONSTRAINT [DF_Org_IsForum] DEFAULT (0) FOR [IsForum] ,
   CONSTRAINT [DF_Org_IsSuggestion] DEFAULT (0) FOR [IsSuggestion] ,
   CONSTRAINT [DF_Org_IsFavorite] DEFAULT (0) FOR [IsFavorite] ,
   CONSTRAINT [DF_Org_IsProgram] DEFAULT (0) FOR [IsProgram] ,
   CONSTRAINT [DF_Org_NoCertificate] DEFAULT (0) FOR [NoCertificate] ,
   CONSTRAINT [DF_Org_IsCustomCertificate] DEFAULT (0) FOR [IsCustomCertificate] ,
   CONSTRAINT [DF_Org_Secure] DEFAULT (0) FOR [Secure] ,
   CONSTRAINT [DF_Org_Credits] DEFAULT (0) FOR [Credits]
GO

ALTER TABLE [dbo].[Org] WITH NOCHECK ADD
   CONSTRAINT [PK_Org] PRIMARY KEY NONCLUSTERED
   ([OrgID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Org_AuthUserID]
   ON [dbo].[Org]
   ([AuthUserID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Org_OrgName]
   ON [dbo].[Org]
   ([OrgName])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Org_CompanyID]
   ON [dbo].[Org]
   ([CompanyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO