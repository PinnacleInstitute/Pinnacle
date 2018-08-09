EXEC [dbo].pts_CheckTable 'NewsLetter'
 GO

CREATE TABLE [dbo].[NewsLetter] (
   [NewsLetterID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [MemberID] int NOT NULL ,
   [NewsLetterName] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [Description] nvarchar (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [MemberCnt] int NOT NULL ,
   [ProspectCnt] int NOT NULL ,
   [IsAttached] bit NOT NULL ,
   [IsFeatured] bit NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[NewsLetter] WITH NOCHECK ADD
   CONSTRAINT [DF_NewsLetter_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_NewsLetter_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_NewsLetter_NewsLetterName] DEFAULT ('') FOR [NewsLetterName] ,
   CONSTRAINT [DF_NewsLetter_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_NewsLetter_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_NewsLetter_MemberCnt] DEFAULT (0) FOR [MemberCnt] ,
   CONSTRAINT [DF_NewsLetter_ProspectCnt] DEFAULT (0) FOR [ProspectCnt] ,
   CONSTRAINT [DF_NewsLetter_IsAttached] DEFAULT (0) FOR [IsAttached] ,
   CONSTRAINT [DF_NewsLetter_IsFeatured] DEFAULT (0) FOR [IsFeatured]
GO

ALTER TABLE [dbo].[NewsLetter] WITH NOCHECK ADD
   CONSTRAINT [PK_NewsLetter] PRIMARY KEY NONCLUSTERED
   ([NewsLetterID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_NewsLetter_CompanyID]
   ON [dbo].[NewsLetter]
   ([CompanyID], [MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_NewsLetter_Featured]
   ON [dbo].[NewsLetter]
   ([CompanyID], [IsFeatured])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_NewsLetter_MemberID]
   ON [dbo].[NewsLetter]
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO