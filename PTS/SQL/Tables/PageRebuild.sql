EXEC [dbo].pts_CheckTableRebuild 'Page'
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