EXEC [dbo].pts_CheckTable 'Page'
 GO

CREATE TABLE [dbo].[Page] (
   [PageID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [MemberID] int NOT NULL ,
   [PageName] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Category] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [PageType] int NOT NULL ,
   [Status] int NOT NULL ,
   [Language] varchar (6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [IsPrivate] bit NOT NULL ,
   [Form] int NOT NULL ,
   [Fields] varchar (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [IsShare] bit NOT NULL ,
   [Subject] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Page] WITH NOCHECK ADD
   CONSTRAINT [DF_Page_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Page_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Page_PageName] DEFAULT ('') FOR [PageName] ,
   CONSTRAINT [DF_Page_Category] DEFAULT ('') FOR [Category] ,
   CONSTRAINT [DF_Page_PageType] DEFAULT (0) FOR [PageType] ,
   CONSTRAINT [DF_Page_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Page_Language] DEFAULT ('') FOR [Language] ,
   CONSTRAINT [DF_Page_IsPrivate] DEFAULT (0) FOR [IsPrivate] ,
   CONSTRAINT [DF_Page_Form] DEFAULT (0) FOR [Form] ,
   CONSTRAINT [DF_Page_Fields] DEFAULT ('') FOR [Fields] ,
   CONSTRAINT [DF_Page_IsShare] DEFAULT (0) FOR [IsShare] ,
   CONSTRAINT [DF_Page_Subject] DEFAULT ('') FOR [Subject]
GO

ALTER TABLE [dbo].[Page] WITH NOCHECK ADD
   CONSTRAINT [PK_Page] PRIMARY KEY NONCLUSTERED
   ([PageID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Page_CompanyID]
   ON [dbo].[Page]
   ([CompanyID], [PageType])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Page_MemberID]
   ON [dbo].[Page]
   ([MemberID], [PageType])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO